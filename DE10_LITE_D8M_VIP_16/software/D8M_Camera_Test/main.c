#include <stdio.h>
#include "I2C_core.h"
#include "terasic_includes.h"
#include "mipi_camera_config.h"
#include "mipi_bridge_config.h"
#include "auto_focus.h"
#include "altera_avalon_uart.h"
#include "altera_avalon_uart_fd.h"
#include "altera_avalon_uart_regs.h"
#include <fcntl.h>
#include <unistd.h>

//EEE_IMGPROC defines
#define EEE_IMGPROC_MSG_START ('R'<<16 | 'B'<<8 | 'B')

//offsets
#define EEE_IMGPROC_STATUS 0    // image processor status
#define EEE_IMGPROC_MSG 1       // image processor message buffer
#define EEE_IMGPROC_ID 2        // image processor block ID
#define EEE_IMGPROC_BBCOL 3     // image processor bounding box colour -> set from verilog?

#define EXPOSURE_INIT 0x002500
#define EXPOSURE_STEP 0x100
#define GAIN_INIT 0x888
#define GAIN_STEP 0x040
#define DEFAULT_LEVEL 3

#define MIPI_REG_PHYClkCtl		0x0056
#define MIPI_REG_PHYData0Ctl	0x0058
#define MIPI_REG_PHYData1Ctl	0x005A
#define MIPI_REG_PHYData2Ctl	0x005C
#define MIPI_REG_PHYData3Ctl	0x005E
#define MIPI_REG_PHYTimDly		0x0060
#define MIPI_REG_PHYSta			0x0062
#define MIPI_REG_CSIStatus		0x0064
#define MIPI_REG_CSIErrEn		0x0066
#define MIPI_REG_MDLSynErr		0x0068
#define MIPI_REG_FrmErrCnt		0x0080
#define MIPI_REG_MDLErrCnt		0x0090

// MIPI Error Information
void mipi_clear_error(void){
	MipiBridgeRegWrite(MIPI_REG_CSIStatus,0x01FF); // clear error
	MipiBridgeRegWrite(MIPI_REG_MDLSynErr,0x0000); // clear error
	MipiBridgeRegWrite(MIPI_REG_FrmErrCnt,0x0000); // clear error
	MipiBridgeRegWrite(MIPI_REG_MDLErrCnt, 0x0000); // clear error

  	MipiBridgeRegWrite(0x0082,0x00);
  	MipiBridgeRegWrite(0x0084,0x00);
  	MipiBridgeRegWrite(0x0086,0x00);
  	MipiBridgeRegWrite(0x0088,0x00);
  	MipiBridgeRegWrite(0x008A,0x00);
  	MipiBridgeRegWrite(0x008C,0x00);
  	MipiBridgeRegWrite(0x008E,0x00);
  	MipiBridgeRegWrite(0x0090,0x00);
}
void mipi_show_error_info(void){

	alt_u16 PHY_status, SCI_status, MDLSynErr, FrmErrCnt, MDLErrCnt;

	PHY_status = MipiBridgeRegRead(MIPI_REG_PHYSta);
	SCI_status = MipiBridgeRegRead(MIPI_REG_CSIStatus);
	MDLSynErr = MipiBridgeRegRead(MIPI_REG_MDLSynErr);
	FrmErrCnt = MipiBridgeRegRead(MIPI_REG_FrmErrCnt);
	MDLErrCnt = MipiBridgeRegRead(MIPI_REG_MDLErrCnt);
	printf("PHY_status=%xh, CSI_status=%xh, MDLSynErr=%xh, FrmErrCnt=%xh, MDLErrCnt=%xh\r\n", PHY_status, SCI_status, MDLSynErr,FrmErrCnt, MDLErrCnt);
}
void mipi_show_error_info_more(void){
    printf("FrmErrCnt = %d\n",MipiBridgeRegRead(0x0080));
    printf("CRCErrCnt = %d\n",MipiBridgeRegRead(0x0082));
    printf("CorErrCnt = %d\n",MipiBridgeRegRead(0x0084));
    printf("HdrErrCnt = %d\n",MipiBridgeRegRead(0x0086));
    printf("EIDErrCnt = %d\n",MipiBridgeRegRead(0x0088));
    printf("CtlErrCnt = %d\n",MipiBridgeRegRead(0x008A));
    printf("SoTErrCnt = %d\n",MipiBridgeRegRead(0x008C));
    printf("SynErrCnt = %d\n",MipiBridgeRegRead(0x008E));
    printf("MDLErrCnt = %d\n",MipiBridgeRegRead(0x0090));
    printf("FIFOSTATUS = %d\n",MipiBridgeRegRead(0x00F8));
    printf("DataType = 0x%04x\n",MipiBridgeRegRead(0x006A));
    printf("CSIPktLen = %d\n",MipiBridgeRegRead(0x006E));
}

// MIPI Bridge Initialisation
bool MIPI_Init(void){
	bool bSuccess = oc_i2c_init_ex(I2C_OPENCORES_MIPI_BASE, 50*1000*1000,400*1000); // I2C: 400K
	if (!bSuccess) { printf("failed to init MIPI- Bridge i2c\r\n"); } usleep(50*1000);
    MipiBridgeInit(); usleep(500*1000);
    MipiCameraInit();
    MIPI_BIN_LEVEL(DEFAULT_LEVEL); usleep(1000);
	return bSuccess;
}

int main()
{
	fcntl(STDIN_FILENO, F_SETFL, O_NONBLOCK);
    printf("DE10-LITE D8M VGA Jayjun\nImperial College EEE2 Project\n");
    IOWR(MIPI_PWDN_N_BASE, 0x00, 0x00);                                             // IOWR: Input Output WRite
    IOWR(MIPI_RESET_N_BASE, 0x00, 0x00); usleep(2000);
    IOWR(MIPI_PWDN_N_BASE, 0x00, 0xFF);  usleep(2000);
    IOWR(MIPI_RESET_N_BASE, 0x00, 0xFF);
    printf("Image Processor ID: %x\n",IORD(0x42000,EEE_IMGPROC_ID)); usleep(2000);  // IORD: Input Output ReaD

    // MIPI Init
    if (!MIPI_Init()) { printf("MIPI_Init Init failed!\r\n"); }
    else              { printf("MIPI_Init Init successfully!\r\n"); }
    mipi_clear_error(); usleep(50*1000);
    mipi_clear_error(); usleep(1000*1000);
    mipi_show_error_info(); printf("\n");

    int boundingBoxColour = 0;
    alt_u8  manual_focus_step = 10;
    alt_u16 bin_level=DEFAULT_LEVEL, current_focus=300, gain=GAIN_INIT;
    alt_u32 exposureTime=EXPOSURE_INIT;

    // Set default exposure time, gain and focus settings
    OV8865SetExposure(exposureTime); OV8865SetGain(gain); Focus_Init();

    while(1){
        // Button 0 for auto focus
        if ( (IORD(KEY_BASE,0) & 0x03) == 0x02 ) {
            current_focus = Focus_Window(320,240);
        }
        // Button 1 for zoom
        if ( (IORD(KEY_BASE,0) & 0x03) == 0x01 ) {
            if (bin_level == 3 ) { bin_level = 1; }
            else { bin_level++; }
            printf("set bin level to %d\n",bin_level);
            MIPI_BIN_LEVEL(bin_level); usleep(500000);
        }

        FILE* fp;
        fp = fopen ("/dev/uart_0", "r+"); //Open file for reading and writing
        if (fp) {
            // Read messages from the image processor and print them on the terminal
            while ( (IORD(0x42000,EEE_IMGPROC_STATUS) >> 8) & 0xff ) {                     // Find out if there are words to read
                int word = IORD(0x42000,EEE_IMGPROC_MSG); 			                       // Get next word from message buffer
                if (word == EEE_IMGPROC_MSG_START) { printf("\n"); fprintf("\n"); }        // Newline on message identifier
                printf("%08x\n",word); fprintf("%08x\n",word);
            }
            fclose(fp);
        }


        // Update the bounding box colour
        // boundingBoxColour = ((boundingBoxColour + 1) & 0xff);
        // IOWR(0x42000, EEE_IMGPROC_BBCOL, (boundingBoxColour << 8) | (0xff - boundingBoxColour));

        // Process input commands
        int in = getchar();
        switch (in) {
            // Exposure Setting Control
            case 'e': { exposureTime += EXPOSURE_STEP; OV8865SetExposure(exposureTime); printf("\nExposure = %x ", exposureTime); break; }
            case 'd': { exposureTime -= EXPOSURE_STEP; OV8865SetExposure(exposureTime); printf("\nExposure = %x ", exposureTime); break; }
            // Gain Setting Control
            case 't': { gain += GAIN_STEP; OV8865SetGain(gain); printf("\nGain = %x ", gain); break; }
            case 'g': { gain -= GAIN_STEP; OV8865SetGain(gain); printf("\nGain = %x ", gain); break; }
            // Focus Setting Control
            case 'r': { current_focus += manual_focus_step; if(current_focus >1023) { current_focus = 1023; } OV8865_FOCUS_Move_to(current_focus); printf("\nFocus = %x ",current_focus); break; }
            case 'f': { if(current_focus > manual_focus_step) current_focus -= manual_focus_step; OV8865_FOCUS_Move_to(current_focus); printf("\nFocus = %x ",current_focus); break; }
        }
        //Main loop delay
        usleep(10000);
    };
    return 0;
}
