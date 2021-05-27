module STREAM_REG(
	clk, 
	rst_n,
	data_in,
	data_out, 
	ready_in, 
	ready_out, 
	valid_in, 
	valid_out
);

	// Input Port(s)
	input clk, rst_n;
	input ready_in; 	// stalls the pipeline if output is not able to rx
	input valid_in;		// enable signal from previous register in the pipeline
	input [DATA_WIDTH-1:0] data_in;
	
	// Output Port(s)
	output ready_out, valid_out;
	output reg [DATA_WIDTH-1:0] data_out;

	// Parameter Declaration(s)
	parameter DATA_WIDTH = 26;
	
	reg data_valid, ready_in_d;

	always@(posedge clk) begin
		if (~rst_n) begin		// reset
			data_out <= 1'b0;
			data_valid <= 0;
			ready_in_d <= 0;
			end
		else begin
			ready_in_d <= ready_in;
			if (valid_in & (~data_valid | ready_in_d)) begin
				data_out <= data_in;
				data_valid <= 1;
			end else if (ready_in_d) begin
				data_valid <= 0;
			end
		end
	end
	
	assign ready_out = (~data_valid & ~valid_in) | ready_in;
	assign valid_out = ready_in_d & data_valid;


endmodule
