module EEE_IMGPROC(
	// global clock & reset
	clk,
	reset_n,
	
	// mm slave
	s_chipselect,
	s_read,
	s_write,
	s_readdata,
	s_writedata,
	s_address,

	// stream sink
	sink_data,
	sink_valid,
	sink_ready,
	sink_sop,
	sink_eop,
	
	// streaming source
	source_data,
	source_valid,
	source_ready,
	source_sop,
	source_eop,
	
	// conduit
	mode,
	filter
);

// global clock & reset
input	clk;
input	reset_n;

// mm slave
input	s_chipselect;
input	s_read;
input	s_write;
output	reg	[31:0]	s_readdata;
input	[31:0]	s_writedata;
input	[2:0]	s_address;

// streaming sink
input	[23:0]	sink_data;
input	sink_valid;
input	sink_sop;
input	sink_eop;
output	sink_ready;	// backpressure

// streaming source
input	source_ready; // backpressure
output	[23:0]	source_data;
output	source_valid;
output	source_sop;
output	source_eop;

// conduit export
input	mode;
input 	filter;

parameter IMAGE_W = 11'd640;			// image width
parameter IMAGE_H = 11'd480;			// image height
parameter MESSAGE_BUF_MAX = 256;
parameter MSG_INTERVAL = 6;
parameter BB_COL_DEFAULT = 24'h00ff00;	// bounding box default colour: green

wire [7:0]   red, green, blue, grey;
wire [7:0]   red_out, green_out, blue_out;
wire         sop, eop, in_valid, out_ready;

// RGB -> HSV colour space conversion
// 8 bit HSV ranges as follows:
// H: 0 ~ 180, S: 0 ~ 255, V: 0 ~ 255
wire [7:0] cmax, cmin, delta, hue, saturation, value;
assign cmax = ((red > green) & (red > blue)) ? red : ((green > blue) & (green > red)) ? green : blue;
assign cmin = ((red < green) & (red < blue)) ? red : ((green < blue) & (green < red)) ? green : blue;
assign delta = cmax-cmin;
assign saturation = (cmax == 0) ? 0 : delta/cmax;
assign hue = (delta == 0) ? 0 : (cmax == red) ? (green - blue)*60/saturation 
							  : (cmax == green) ? 120 + (blue - red)*60/saturation
		   					  : 240 + (red - green)*60/saturation;
assign value = cmax;

wire brightness_filter;
assign brightness_filter = value >= 60 & value <= 180;

// Detect red, green, blue, yellow, pink and white areas
wire red_detect, green_detect, blue_detect, white_detect, yellow_detect, pink_detect;
assign red_detect = red[7] & ~green[7] & ~blue[7];
assign green_detect = ~red[7] & green <= 8'h99 & green >= 8'h66 & blue <= 8'hd0 & blue >= 8'h40;
assign blue_detect = ~red[7] & green <= 8'h66 & green >= 8'h33 & blue <= 8'hcc & blue >= 8'h66;
assign yellow_detect = red[7] & green[7] & blue <= 8'haa & blue >= 8'h33;
assign pink_detect = red[7] & green <= 8'hee & green >= 8'h66 & blue <= 8'he5 & blue >= 8'h88;
assign white_detect = red[7] & red[6] & green[7] & green[6] & blue[7] & blue[6];

// Find boundary of cursor box
// Highlight detected areas
wire [23:0] rgb_high;
assign grey = green[7:1] + red[7:2] + blue[7:2]; //Grey = green/2 + red/4 + blue/4
// filter/detect by descending order/magnitude of RGB colour space
assign rgb_high = filter ? ((white_detect&brightness_filter) ? {grey, grey, grey} : (blue_detect&brightness_filter) ? {8'h0, 8'h0, 8'hff} : (pink_detect&brightness_filter) ? {8'hff, 8'haa, 8'hcc} : (red_detect&brightness_filter) ? {8'hff, 8'h0, 8'h0} : (green_detect&brightness_filter) ? {8'h0, 8'hff, 8'h0} : (yellow_detect&brightness_filter) ? {8'hff, 8'hff, 8'h66} : {grey, grey, grey})
						 : (white_detect ? {grey, grey, grey} : blue_detect ? {8'h0, 8'h0, 8'hff} : pink_detect ? {8'hff, 8'haa, 8'hcc} : red_detect ? {8'hff, 8'h0, 8'h0} : green_detect ? {8'h0, 8'hff, 8'h0} : yellow_detect ? {8'hff, 8'hff, 8'h66} : {grey, grey, grey});

// Show bounding box
wire [23:0] new_image;
wire bb_active_r, bb_active_g, bb_active_b, bb_active_y, bb_active_p;
assign bb_active_r = ((x == left_r | x == right_r) & (y <= bottom_r) & (y >= top_r)) | ((y == top_r | y == bottom_r) & (x <= right_r) & (x >= left_r));
assign bb_active_g = ((x == left_g | x == right_g) & (y <= bottom_g) & (y >= top_g)) | ((y == top_g | y == bottom_g) & (x <= right_g) & (x >= left_g));
assign bb_active_b = ((x == left_b | x == right_b) & (y <= bottom_b) & (y >= top_b)) | ((y == top_b | y == bottom_b) & (x <= right_b) & (x >= left_b));
assign bb_active_y = ((x == left_y | x == right_y) & (y <= bottom_y) & (y >= top_y)) | ((y == top_y | y == bottom_y) & (x <= right_y) & (x >= left_y));
assign bb_active_p = ((x == left_p | x == right_p) & (y <= bottom_p) & (y >= top_p)) | ((y == top_p | y == bottom_p) & (x <= right_p) & (x >= left_p));
assign new_image = bb_active_r ? bb_col_r : bb_active_b ? bb_col_b : bb_active_g ? bb_col_g : bb_active_y ? bb_col_y : bb_active_p ? bb_col_p : rgb_high;

// Switch output pixels depending on mode switch
// Don't modify the start-of-packet word - it's a packet discriptor
// Don't modify data in non-video packets
assign {red_out, green_out, blue_out} = (mode & ~sop & packet_video) ? new_image : {red,green,blue};


// Incrementing x and y pixels for processing
// Count valid pixels to get the image coordinates. Reset and detect packet type on Start of Packet (sop).
reg [10:0] x, y;
reg packet_video;
always @(posedge clk) begin
	if (sop) begin
		x <= 11'h0;		// start (x,y) pixel at (0,0)
		y <= 11'h0;
		packet_video <= (blue[3:0] == 3'h0);	// ??? not sure what this is
	end else if (in_valid) begin
		if (x == IMAGE_W-1) begin	// read the entire row of image pixels x = 0 ~ IMAGE_W - 1 then read the next row above
			x <= 11'h0;
			y <= y + 11'h1;
		end else begin
			x <= x + 11'h1;
		end
	end
end

// Find first and last r,g,b,y,p pixels
reg [10:0] x_min_r, y_min_r, x_max_r, y_max_r;
reg [10:0] x_min_g, y_min_g, x_max_g, y_max_g;
reg [10:0] x_min_b, y_min_b, x_max_b, y_max_b;
reg [10:0] x_min_y, y_min_y, x_max_y, y_max_y;
reg [10:0] x_min_p, y_min_p, x_max_p, y_max_p;
always @(posedge clk) begin
if (filter) begin
		if (brightness_filter & red_detect & in_valid) begin	// Update bounds when the pixel is red
			if (x < x_min_r) x_min_r <= x;
			if (x > x_max_r) x_max_r <= x;
			if (y < y_min_r) y_min_r <= y;
			y_max_r <= y;
		end
		if (brightness_filter & green_detect & in_valid) begin	// green
			if (x < x_min_g) x_min_g <= x;
			if (x > x_max_g) x_max_g <= x;
			if (y < y_min_g) y_min_g <= y;
			y_max_g <= y;
		end
		if (brightness_filter & blue_detect & in_valid) begin	// blue
			if (x < x_min_b) x_min_b <= x;
			if (x > x_max_b) x_max_b <= x;
			if (y < y_min_b) y_min_b <= y;
			y_max_b <= y;
		end
		if (brightness_filter & yellow_detect & in_valid) begin	// yellow
			if (x < x_min_y) x_min_y <= x;
			if (x > x_max_y) x_max_y <= x;
			if (y < y_min_y) y_min_y <= y;
			y_max_y <= y;
		end
		if (brightness_filter & pink_detect & in_valid) begin	// pink
			if (x < x_min_p) x_min_p <= x;
			if (x > x_max_p) x_max_p <= x;
			if (y < y_min_p) y_min_p <= y;
			y_max_p <= y;
		end
	end else begin
			if (red_detect & in_valid) begin	// Update bounds when the pixel is red
			if (x < x_min_r) x_min_r <= x;
			if (x > x_max_r) x_max_r <= x;
			if (y < y_min_r) y_min_r <= y;
			y_max_r <= y;
		end
		if (green_detect & in_valid) begin	// green
			if (x < x_min_g) x_min_g <= x;
			if (x > x_max_g) x_max_g <= x;
			if (y < y_min_g) y_min_g <= y;
			y_max_g <= y;
		end
		if (blue_detect & in_valid) begin	// blue
			if (x < x_min_b) x_min_b <= x;
			if (x > x_max_b) x_max_b <= x;
			if (y < y_min_b) y_min_b <= y;
			y_max_b <= y;
		end
		if (yellow_detect & in_valid) begin	// yellow
			if (x < x_min_y) x_min_y <= x;
			if (x > x_max_y) x_max_y <= x;
			if (y < y_min_y) y_min_y <= y;
			y_max_y <= y;
		end
		if (pink_detect & in_valid) begin	// pink
			if (x < x_min_p) x_min_p <= x;
			if (x > x_max_p) x_max_p <= x;
			if (y < y_min_p) y_min_p <= y;
			y_max_p <= y;
		end
	end
	if (sop & in_valid) begin	// Reset bounds on start of packet
		x_min_r <= IMAGE_W-11'h1; x_max_r <= 0;
		y_min_r <= IMAGE_H-11'h1; y_max_r <= 0; // red
		x_min_g <= IMAGE_W-11'h1; x_max_g <= 0;
		y_min_g <= IMAGE_H-11'h1; y_max_g <= 0; // green
		x_min_b <= IMAGE_W-11'h1; x_max_b <= 0;
		y_min_b <= IMAGE_H-11'h1; y_max_b <= 0; // blue
		x_min_y <= IMAGE_W-11'h1; x_max_y <= 0;
		y_min_y <= IMAGE_H-11'h1; y_max_y <= 0; // yellow
		x_min_p <= IMAGE_W-11'h1; x_max_p <= 0;
		y_min_p <= IMAGE_H-11'h1; y_max_p <= 0; // pink
	end
end

// Process bounding box at the end of the frame.
reg [1:0] msg_state;
reg [10:0] left_r, right_r, top_r, bottom_r;
reg [10:0] left_g, right_g, top_g, bottom_g;
reg [10:0] left_b, right_b, top_b, bottom_b;
reg [10:0] left_y, right_y, top_y, bottom_y;
reg [10:0] left_p, right_p, top_p, bottom_p;
reg [7:0] frame_count;
always@(posedge clk) begin
	if (eop & in_valid & packet_video) begin  // Ignore non-video packets
		// Latch edges for display overlay on next frame
		// red
		left_r <= x_min_r;
		right_r <= x_max_r;
		top_r <= y_min_r;
		bottom_r <= y_max_r;
		// green
		left_g <= x_min_g;
		right_g <= x_max_g;
		top_g <= y_min_g;
		bottom_g <= y_max_g;
		// blue
		left_b <= x_min_b;
		right_b <= x_max_b;
		top_b <= y_min_b;
		bottom_b <= y_max_b;
		// yellow
		left_y <= x_min_y;
		right_y <= x_max_y;
		top_y <= y_min_y;
		bottom_y <= y_max_y;
		// pink
		left_p <= x_min_p;
		right_p <= x_max_p;
		top_p <= y_min_p;
		bottom_p <= y_max_p;

		// Start message writer FSM once every MSG_INTERVAL frames, if there is room in the FIFO
		frame_count <= frame_count - 1;
		
		if (frame_count == 0 && msg_buf_size < MESSAGE_BUF_MAX - 3) begin
			msg_state <= 2'b01;
			frame_count <= MSG_INTERVAL-1;
		end
	end
	// Cycle through message writer states once started
	if (msg_state != 2'b00) msg_state <= msg_state + 2'b01;
end

// Compute distance to balls
wire [9:0] box_width_r, box_width_g, box_width_b, box_width_y, box_width_p; // max 640 < 1024 = 2^10
wire [8:0] box_height_r, box_height_g, box_height_b, box_height_y, box_height_p;
assign box_width_r = x_max_r - x_min_r;
assign box_width_g = x_max_g - x_min_g;
assign box_width_b = x_max_b - x_min_b;
assign box_width_y = x_max_y - x_min_y;
assign box_width_p = x_max_p - x_min_p;
assign box_height_r = y_max_r - y_min_r;
assign box_height_g = y_max_g - y_min_g;
assign box_height_b = y_max_b - y_min_b;
assign box_height_y = y_max_y - y_min_y;
assign box_height_p = y_max_p - y_min_p;

// Compute the perpendicular distance from the camera to the balls + distance from camera to the optical sensor displacement readings
wire [7:0] dis_r, dis_g, dis_b, dis_y, dis_p; 	// 8 bits: max 256 cm away from rover's camera
wire [9:0] focal_length; 						// all real life lengths in cm
assign focal_length = 10'd800; 					// units: box width in pixels
assign dis_r = 4 * focal_length / box_width_r + 24; 	// 4 cm ball diameter and 24 cm from camera to optical flow sensor
assign dis_g = 4 * focal_length / box_width_g + 24;
assign dis_b = 4 * focal_length / box_width_b + 24;
assign dis_y = 4 * focal_length / box_width_y + 24;
assign dis_p = 4 * focal_length / box_width_p + 24;

// Compute angle from the centre of camera vision using perpendicular distance and number of pixels from the centre of camera (320,240)
// Rather than computing the angle by arctan on verilog / hardware (not efficient use) -> let ESP32 do this
// Find the number of pixels apart from the centre of vision to the balls
wire signed [9:0] pixel_r, pixel_g, pixel_b, pixel_y, pixel_p;
assign pixel_r = (x_min_r + box_width_r >> 2) - 320; // centre of ball pixel to the right of centre: +ve
assign pixel_g = (x_min_r + box_width_g >> 2) - 320; // 					 to the  left of centre: -ve
assign pixel_b = (x_min_r + box_width_b >> 2) - 320;
assign pixel_y = (x_min_r + box_width_y >> 2) - 320;
assign pixel_p = (x_min_r + box_width_p >> 2) - 320;

// Generate output messages for CPU
reg	[31:0]	msg_buf_in;
reg msg_buf_wr;
wire [31:0] msg_buf_out;
wire msg_buf_rd, msg_buf_flush, msg_buf_empty;
wire [7:0] msg_buf_size;

`define RED_BOX_MSG_ID "RBB" // -> #define EEE_IMGPROC_MSG_START ('R'<<16 | 'B'<<8 | 'B') in main.c

always @(*) begin	// Write words to FIFO as state machine advances
	case(msg_state)
		2'b00: begin
			msg_buf_in = 32'b0;
			msg_buf_wr = 1'b0;				// nothing written in buffer
		end
		2'b01: begin
			msg_buf_in = {dis_r,dis_g,dis_b,dis_y};	// distance to the balls r,g,b,y
			msg_buf_wr = 1'b1;
		end
		2'b10: begin
			msg_buf_in = {dis_p,2'd0,pixel_r,2'd0,pixel_g};	// distance to the ball p, pixel distance to the centre of r, g
			msg_buf_wr = 1'b1;
		end
		2'b11: begin
			msg_buf_in = {pixel_b,1'd0,pixel_y,1'd0,pixel_p}; // pixel distance to the centre of b, y, p
			msg_buf_wr = 1'b1;
		end
	endcase
end


//Output message FIFO
MSG_FIFO MSG_FIFO_inst (
	.clock (clk),
	.data (msg_buf_in),
	.rdreq (msg_buf_rd),
	.sclr (~reset_n | msg_buf_flush),
	.wrreq (msg_buf_wr),
	.q (msg_buf_out),
	.usedw (msg_buf_size),
	.empty (msg_buf_empty)
);

// Two pipeline stages
// Streaming registers to buffer video signal
STREAM_REG #(.DATA_WIDTH(26)) in_reg (
	.clk(clk),
	.rst_n(reset_n),
	.ready_out(sink_ready),
	.valid_out(in_valid),
	.data_out({red,green,blue,sop,eop}),
	.ready_in(out_ready),
	.valid_in(sink_valid),
	.data_in({sink_data,sink_sop,sink_eop})
);
STREAM_REG #(.DATA_WIDTH(26)) out_reg (
	.clk(clk),
	.rst_n(reset_n),
	.ready_out(out_ready),
	.valid_out(source_valid),
	.data_out({source_data,source_sop,source_eop}),
	.ready_in(source_ready),
	.valid_in(in_valid),
	.data_in({red_out, green_out, blue_out, sop, eop})
);

/////////////////////////////////
////   Memory-mapped port	/////
/////////////////////////////////

// Addresses
`define REG_STATUS    			0
`define READ_MSG    			1
`define READ_ID    				2
`define REG_BBCOL				3

// Status register bits
// 31:16 - unimplemented
// 15:8  - number of words in message buffer (read only)
// 7:5   - unused
// 4 	 - flush message buffer (write only - read as 0)
// 3:0 	 - unused


// Process write (input from main.c to change bb_colour)
reg  [7:0]	reg_status;
reg	[23:0]	bb_col_r, bb_col_g, bb_col_b, bb_col_y, bb_col_p, bb_col;

always @ (posedge clk)
begin
	if (~reset_n)
	begin
		reg_status <= 8'b0;
		bb_col_r <= 24'hff0000;
		bb_col_g <= 24'h00ff00;
		bb_col_b <= 24'h0000ff;
		bb_col_y <= 24'hffff66;
		bb_col_p <= 24'hffaacc;
	end else begin
		if(s_chipselect & s_write) begin
		   if      (s_address == `REG_STATUS)	reg_status <= s_writedata[7:0];
		   //if      (s_address == `REG_BBCOL)	bb_col <= s_writedata[23:0];
		end
	end
end


// Flush the message buffer if 1 is written to status register bit 4
assign msg_buf_flush = (s_chipselect & s_write & (s_address == `REG_STATUS) & s_writedata[4]);

// Process reads
reg read_d; // Store the read signal for correct updating of the message buffer

// Copy the requested word to the output port when there is a read.
always @(posedge clk) begin
   if (~reset_n) begin
	   	s_readdata <= {32'b0};
		read_d <= 1'b0;
	end	else if (s_chipselect & s_read) begin
		if   (s_address == `REG_STATUS) s_readdata <= {16'b0,msg_buf_size,reg_status};
		if   (s_address == `READ_MSG) 	s_readdata <= {msg_buf_out};
		if   (s_address == `READ_ID) 	s_readdata <= 32'h1234EEE2;			// -> printf("Image Processor ID: %x\n",IORD(0x42000,EEE_IMGPROC_ID)); in main.c
		if   (s_address == `REG_BBCOL) 	s_readdata <= {8'h0, bb_col_r};
	end
	read_d <= s_read;
end

// Fetch next word from message buffer after read from READ_MSG
assign msg_buf_rd = s_chipselect & s_read & ~read_d & ~msg_buf_empty & (s_address == `READ_MSG);
						
endmodule

