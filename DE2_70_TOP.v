// --------------------------------------------------------------------
// Copyright (c) 2007 by Terasic Technologies Inc. 
// --------------------------------------------------------------------
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// --------------------------------------------------------------------
//           
//                     Terasic Technologies Inc
//                     356 Fu-Shin E. Rd Sec. 1. JhuBei City,
//                     HsinChu County, Taiwan
//                     302
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// --------------------------------------------------------------------
//
// Major Functions:	DE2_70 TOP LEVEL 
//
// --------------------------------------------------------------------
//
// Revision History :
// --------------------------------------------------------------------
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| Johnny FAN        :| 07/07/09  :| Initial Revision
//   V1.1 :| Johnny FAN        :| 07/07/09  :| 1.change fpga device from 
//                                               ep2c70896c8 to ep2c70896c6
//											   2.change module name from DE2P_TOP
//                                               to DE2_70_TOP		
//   V1.2 :| Johnny FAN        :| 07/07/09  :| 1. change for pcb v1.1
//											   2. modify PS2 interface i/o
//											   3. modify GPIO,VGA, and UART interface
//										  		  pin assignment
//											   4. change GPIO_CLKOUT from output to inout
//   V1.21 :| Johnny FAN       :| 07/07/09  :| 1.remove ssram address bus oSRAM_A[19]and oSRAM_A[20]
//											   2.remove flash address bus oFLASH_A[25:22]		
//   V2.0 :| Perly HU          :| 08/12/2010:| Revision to Quartus II 10.0
// --------------------------------------------------------------------

module DE2_70_TOP
	(
		////////////////////	Clock Input	 	////////////////////	 
		iCLK_28,							//  28.63636 MHz
		iCLK_50,							//	50 MHz
		iCLK_50_2,						//	50 MHz
		iCLK_50_3,						//	50 MHz
		iCLK_50_4,						//	50 MHz
		iEXT_CLOCK,						//	External Clock
		////////////////////	Push Button		////////////////////
		iKEY,								//	Pushbutton[3:0]
		////////////////////	DPDT Switch		////////////////////
		iSW,								//	Toggle Switch[17:0]
		////////////////////	7-SEG Dispaly	////////////////////
		oHEX0_D,							//	Seven Segment Digit 0
		oHEX0_DP,						//  Seven Segment Digit 0 decimal point
		oHEX1_D,							//	Seven Segment Digit 1
		oHEX1_DP,						//  Seven Segment Digit 1 decimal point
		oHEX2_D,							//	Seven Segment Digit 2
		oHEX2_DP,						//  Seven Segment Digit 2 decimal point
		oHEX3_D,							//	Seven Segment Digit 3
		oHEX3_DP,						//  Seven Segment Digit 3 decimal point
		oHEX4_D,							//	Seven Segment Digit 4
		oHEX4_DP,						//  Seven Segment Digit 4 decimal point
		oHEX5_D,							//	Seven Segment Digit 5
		oHEX5_DP,						//  Seven Segment Digit 5 decimal point
		oHEX6_D,							//	Seven Segment Digit 6
		oHEX6_DP,						//  Seven Segment Digit 6 decimal point
		oHEX7_D,							//	Seven Segment Digit 7
		oHEX7_DP,						//  Seven Segment Digit 7 decimal point
		////////////////////////	LED		////////////////////////
		oLEDG,							//	LED Green[8:0]
		oLEDR,							//	LED Red[17:0]
		////////////////////////	UART	////////////////////////
		oUART_TXD,						//	UART Transmitter
		iUART_RXD,						//	UART Receiver
		oUART_CTS,          			//	UART Clear To Send
		iUART_RTS,          			//	UART Requst To Send
		////////////////////////	IRDA	////////////////////////
		oIRDA_TXD,						//	IRDA Transmitter
		iIRDA_RXD,						//	IRDA Receiver
		/////////////////////	SDRAM Interface		////////////////
		DRAM_DQ,							//	SDRAM Data bus 32 Bits
		oDRAM0_A,						//	SDRAM0 Address bus 13 Bits
		oDRAM1_A,						//	SDRAM1 Address bus 13 Bits
		oDRAM0_LDQM0,					//	SDRAM0 Low-byte Data Mask 
		oDRAM1_LDQM0,					//	SDRAM1 Low-byte Data Mask 
		oDRAM0_UDQM1,					//	SDRAM0 High-byte Data Mask
		oDRAM1_UDQM1,					//	SDRAM1 High-byte Data Mask
		oDRAM0_WE_N,					//	SDRAM0 Write Enable
		oDRAM1_WE_N,					//	SDRAM1 Write Enable
		oDRAM0_CAS_N,					//	SDRAM0 Column Address Strobe
		oDRAM1_CAS_N,					//	SDRAM1 Column Address Strobe
		oDRAM0_RAS_N,					//	SDRAM0 Row Address Strobe
		oDRAM1_RAS_N,					//	SDRAM1 Row Address Strobe
		oDRAM0_CS_N,					//	SDRAM0 Chip Select
		oDRAM1_CS_N,					//	SDRAM1 Chip Select
		oDRAM0_BA,						//	SDRAM0 Bank Address
		oDRAM1_BA,	 					//	SDRAM1 Bank Address
		oDRAM0_CLK,						//	SDRAM0 Clock
		oDRAM1_CLK,						//	SDRAM1 Clock
		oDRAM0_CKE,						//	SDRAM0 Clock Enable
		oDRAM1_CKE,						//	SDRAM1 Clock Enable
		////////////////////	Flash Interface		////////////////
		FLASH_DQ,						//	FLASH Data bus 15 Bits (0 to 14)
		FLASH_DQ15_AM1,				//  FLASH Data bus Bit 15 or Address A-1
		oFLASH_A,						//	FLASH Address bus 26 Bits
		oFLASH_WE_N,					//	FLASH Write Enable
		oFLASH_RST_N,					//	FLASH Reset
		oFLASH_WP_N,					//	FLASH Write Protect /Programming Acceleration 
		iFLASH_RY_N,					//	FLASH Ready/Busy output 
		oFLASH_BYTE_N,					//	FLASH Byte/Word Mode Configuration
		oFLASH_OE_N,					//	FLASH Output Enable
		oFLASH_CE_N,					//	FLASH Chip Enable
		////////////////////	SRAM Interface		////////////////
		SRAM_DQ,							//	SRAM Data Bus 32 Bits
		SRAM_DPA, 						//  SRAM Parity Data Bus
		oSRAM_A,							//	SRAM Address bus 22 Bits
		oSRAM_ADSC_N,       			//	SRAM Controller Address Status 	
		oSRAM_ADSP_N,              //	SRAM Processor Address Status
		oSRAM_ADV_N,               //	SRAM Burst Address Advance
		oSRAM_BE_N,                //	SRAM Byte Write Enable
		oSRAM_CE1_N,        			//	SRAM Chip Enable
		oSRAM_CE2,          			//	SRAM Chip Enable
		oSRAM_CE3_N,        			//	SRAM Chip Enable
		oSRAM_CLK,                 //	SRAM Clock
		oSRAM_GW_N,         			//  SRAM Global Write Enable
		oSRAM_OE_N,         			//	SRAM Output Enable
		oSRAM_WE_N,         			//	SRAM Write Enable
		////////////////////	ISP1362 Interface	////////////////
		OTG_D,							//	ISP1362 Data bus 16 Bits
		oOTG_A,							//	ISP1362 Address 2 Bits
		oOTG_CS_N,						//	ISP1362 Chip Select
		oOTG_OE_N,						//	ISP1362 Read
		oOTG_WE_N,						//	ISP1362 Write
		oOTG_RESET_N,					//	ISP1362 Reset
		OTG_FSPEED,						//	USB Full Speed,	0 = Enable, Z = Disable
		OTG_LSPEED,						//	USB Low Speed, 	0 = Enable, Z = Disable
		iOTG_INT0,						//	ISP1362 Interrupt 0
		iOTG_INT1,						//	ISP1362 Interrupt 1
		iOTG_DREQ0,						//	ISP1362 DMA Request 0
		iOTG_DREQ1,						//	ISP1362 DMA Request 1
		oOTG_DACK0_N,					//	ISP1362 DMA Acknowledge 0
		oOTG_DACK1_N,					//	ISP1362 DMA Acknowledge 1
		////////////////////	LCD Module 16X2		////////////////
		oLCD_ON,							//	LCD Power ON/OFF
		oLCD_BLON,						//	LCD Back Light ON/OFF
		oLCD_RW,							//	LCD Read/Write Select, 0 = Write, 1 = Read
		oLCD_EN,							//	LCD Enable
		oLCD_RS,							//	LCD Command/Data Select, 0 = Command, 1 = Data
		LCD_D,							//	LCD Data bus 8 bits
		////////////////////	SD_Card Interface	////////////////
		SD_DAT,							//	SD Card Data
		SD_DAT3,							//	SD Card Data 3
		SD_CMD,							//	SD Card Command Signal
		oSD_CLK,							//	SD Card Clock
		////////////////////	I2C		////////////////////////////
		I2C_SDAT,						//	I2C Data
		oI2C_SCLK,						//	I2C Clock
		////////////////////	PS2		////////////////////////////
		PS2_KBDAT,						//	PS2 Keyboard Data
		PS2_KBCLK,						//	PS2 Keyboard Clock		
		PS2_MSDAT,						//	PS2 Mouse Data
		PS2_MSCLK,						//	PS2 Mouse Clock
		////////////////////	VGA		////////////////////////////
		oVGA_CLOCK,   					//	VGA Clock
		oVGA_HS,							//	VGA H_SYNC
		oVGA_VS,							//	VGA V_SYNC
		oVGA_BLANK_N,					//	VGA BLANK
		oVGA_SYNC_N,					//	VGA SYNC
		oVGA_R,   						//	VGA Red[9:0]
		oVGA_G,	 						//	VGA Green[9:0]
		oVGA_B,  						//	VGA Blue[9:0]
		////////////	Ethernet Interface	////////////////////////
		ENET_D,							//	DM9000A DATA bus 16Bits
		oENET_CMD,						//	DM9000A Command/Data Select, 0 = Command, 1 = Data
		oENET_CS_N,						//	DM9000A Chip Select
		oENET_IOW_N,					//	DM9000A Write
		oENET_IOR_N,					//	DM9000A Read
		oENET_RESET_N,					//	DM9000A Reset
		iENET_INT,						//	DM9000A Interrupt
		oENET_CLK,						//	DM9000A Clock 25 MHz
		////////////////	Audio CODEC		////////////////////////
		AUD_ADCLRCK,					//	Audio CODEC ADC LR Clock
		iAUD_ADCDAT,					//	Audio CODEC ADC Data
		AUD_DACLRCK,					//	Audio CODEC DAC LR Clock
		oAUD_DACDAT,					//	Audio CODEC DAC Data
		AUD_BCLK,						//	Audio CODEC Bit-Stream Clock
		oAUD_XCK,						//	Audio CODEC Chip Clock
		////////////////	TV Decoder		////////////////////////
		iTD1_CLK27,						//	TV Decoder1 Line_Lock Output Clock 
		iTD1_D,    					   //	TV Decoder1 Data bus 8 bits
		iTD1_HS,							//	TV Decoder1 H_SYNC
		iTD1_VS,							//	TV Decoder1 V_SYNC
		oTD1_RESET_N,					//	TV Decoder1 Reset
		iTD2_CLK27,						//	TV Decoder2 Line_Lock Output Clock 		
		iTD2_D,    					   //	TV Decoder2 Data bus 8 bits
		iTD2_HS,							//	TV Decoder2 H_SYNC
		iTD2_VS,							//	TV Decoder2 V_SYNC
		oTD2_RESET_N,					//	TV Decoder2 Reset
		////////////////////	GPIO	////////////////////////////
		GPIO_0,							//	GPIO Connection 0 I/O
		GPIO_CLKIN_N0,     			//	GPIO Connection 0 Clock Input 0
		GPIO_CLKIN_P0,          	//	GPIO Connection 0 Clock Input 1
		GPIO_CLKOUT_N0,     			//	GPIO Connection 0 Clock Output 0
		GPIO_CLKOUT_P0,            //	GPIO Connection 0 Clock Output 1
		GPIO_1,							//	GPIO Connection 1 I/O
		GPIO_CLKIN_N1,             //	GPIO Connection 1 Clock Input 0
		GPIO_CLKIN_P1,             //	GPIO Connection 1 Clock Input 1
		GPIO_CLKOUT_N1,            //	GPIO Connection 1 Clock Output 0
		GPIO_CLKOUT_P1             //	GPIO Connection 1 Clock Output 1
	   
	);

//===========================================================================
// PARAMETER declarations
//===========================================================================


//===========================================================================
// PORT declarations
//===========================================================================
////////////////////////	Clock Input	 	////////////////////////
input				iCLK_28;					//  28.63636 MHz
input				iCLK_50;					//	50 MHz
input				iCLK_50_2;				//	50 MHz
input          iCLK_50_3;				//	50 MHz
input          iCLK_50_4;				//	50 MHz
input          iEXT_CLOCK;				//	External Clock
////////////////////////	Push Button		////////////////////////
input		[3:0]	iKEY;						//	Pushbutton[3:0]
////////////////////////	DPDT Switch		////////////////////////
input		[17:0]iSW;						//	Toggle Switch[17:0]
////////////////////////	7-SEG Dispaly	////////////////////////
output	[6:0]	oHEX0_D;					//	Seven Segment Digit 0
output			oHEX0_DP;				//  Seven Segment Digit 0 decimal point
output	[6:0]	oHEX1_D;					//	Seven Segment Digit 1
output			oHEX1_DP;				//  Seven Segment Digit 1 decimal point
output	[6:0]	oHEX2_D;					//	Seven Segment Digit 2
output			oHEX2_DP;				//  Seven Segment Digit 2 decimal point
output	[6:0]	oHEX3_D;					//	Seven Segment Digit 3
output			oHEX3_DP;				//  Seven Segment Digit 3 decimal point
output	[6:0]	oHEX4_D;					//	Seven Segment Digit 4
output			oHEX4_DP;				//  Seven Segment Digit 4 decimal point
output	[6:0]	oHEX5_D;					//	Seven Segment Digit 5
output			oHEX5_DP;				//  Seven Segment Digit 5 decimal point
output	[6:0]	oHEX6_D;					//	Seven Segment Digit 6
output			oHEX6_DP;				//  Seven Segment Digit 6 decimal point
output	[6:0]	oHEX7_D;					//	Seven Segment Digit 7
output			oHEX7_DP;				//  Seven Segment Digit 7 decimal point
////////////////////////////	LED		////////////////////////////
output	[8:0]	oLEDG;					//	LED Green[8:0]
output	[17:0]oLEDR;					//	LED Red[17:0]
////////////////////////////	UART	////////////////////////////
output			oUART_TXD;				//	UART Transmitter
input				iUART_RXD;				//	UART Receiver
output			oUART_CTS;          	//	UART Clear To Send
input				iUART_RTS;          	//	UART Requst To Send
////////////////////////////	IRDA	////////////////////////////
output			oIRDA_TXD;				//	IRDA Transmitter
input				iIRDA_RXD;				//	IRDA Receiver
///////////////////////		SDRAM Interface	////////////////////////
inout		[31:0]DRAM_DQ;					//	SDRAM Data bus 32 Bits
output	[12:0]oDRAM0_A;				//	SDRAM0 Address bus 13 Bits
output	[12:0]oDRAM1_A;				//	SDRAM1 Address bus 13 Bits
output			oDRAM0_LDQM0;			//	SDRAM0 Low-byte Data Mask 
output			oDRAM1_LDQM0;			//	SDRAM1 Low-byte Data Mask 
output			oDRAM0_UDQM1;			//	SDRAM0 High-byte Data Mask
output			oDRAM1_UDQM1;			//	SDRAM1 High-byte Data Mask
output			oDRAM0_WE_N;			//	SDRAM0 Write Enable
output			oDRAM1_WE_N;			//	SDRAM1 Write Enable
output			oDRAM0_CAS_N;			//	SDRAM0 Column Address Strobe
output			oDRAM1_CAS_N;			//	SDRAM1 Column Address Strobe
output			oDRAM0_RAS_N;			//	SDRAM0 Row Address Strobe
output			oDRAM1_RAS_N;			//	SDRAM1 Row Address Strobe
output			oDRAM0_CS_N;			//	SDRAM0 Chip Select
output			oDRAM1_CS_N;			//	SDRAM1 Chip Select
output	[1:0]	oDRAM0_BA;				//	SDRAM0 Bank Address
output	[1:0]	oDRAM1_BA;		 		//	SDRAM1 Bank Address
output			oDRAM0_CLK;				//	SDRAM0 Clock
output			oDRAM1_CLK;				//	SDRAM1 Clock
output			oDRAM0_CKE;				//	SDRAM0 Clock Enable
output			oDRAM1_CKE;				//	SDRAM1 Clock Enable
////////////////////////	Flash Interface	////////////////////////
inout		[14:0]FLASH_DQ;				//	FLASH Data bus 15 Bits (0 to 14)
inout				FLASH_DQ15_AM1;		//  FLASH Data bus Bit 15 or Address A-1
output	[21:0]oFLASH_A;				//	FLASH Address bus 22 Bits
output			oFLASH_WE_N;			//	FLASH Write Enable
output			oFLASH_RST_N;			//	FLASH Reset
output			oFLASH_WP_N;			//	FLASH Write Protect /Programming Acceleration 
input				iFLASH_RY_N;			//	FLASH Ready/Busy output 
output			oFLASH_BYTE_N;			//	FLASH Byte/Word Mode Configuration
output			oFLASH_OE_N;			//	FLASH Output Enable
output			oFLASH_CE_N;			//	FLASH Chip Enable
////////////////////////	SRAM Interface	////////////////////////
inout		[31:0]SRAM_DQ;					//	SRAM Data Bus 32 Bits
inout		[3:0]	SRAM_DPA; 				//  SRAM Parity Data Bus
output	[18:0]oSRAM_A;					//	SRAM Address bus 21 Bits
output			oSRAM_ADSC_N;       	//	SRAM Controller Address Status 	
output			oSRAM_ADSP_N;        //	SRAM Processor Address Status
output			oSRAM_ADV_N;         //	SRAM Burst Address Advance
output	[3:0]	oSRAM_BE_N;          //	SRAM Byte Write Enable
output			oSRAM_CE1_N;        	//	SRAM Chip Enable
output			oSRAM_CE2;          	//	SRAM Chip Enable
output			oSRAM_CE3_N;        	//	SRAM Chip Enable
output			oSRAM_CLK;           //	SRAM Clock
output			oSRAM_GW_N;         	//  SRAM Global Write Enable
output			oSRAM_OE_N;         	//	SRAM Output Enable
output			oSRAM_WE_N;         	//	SRAM Write Enable
////////////////////	ISP1362 Interface	////////////////////////
inout		[15:0]OTG_D;					//	ISP1362 Data bus 16 Bits
output	[1:0]	oOTG_A;					//	ISP1362 Address 2 Bits
output			oOTG_CS_N;				//	ISP1362 Chip Select
output			oOTG_OE_N;				//	ISP1362 Read
output			oOTG_WE_N;				//	ISP1362 Write
output			oOTG_RESET_N;			//	ISP1362 Reset
inout				OTG_FSPEED;				//	USB Full Speed,	0 = Enable, Z = Disable
inout				OTG_LSPEED;				//	USB Low Speed, 	0 = Enable, Z = Disable
input				iOTG_INT0;				//	ISP1362 Interrupt 0
input				iOTG_INT1;				//	ISP1362 Interrupt 1
input				iOTG_DREQ0;				//	ISP1362 DMA Request 0
input				iOTG_DREQ1;				//	ISP1362 DMA Request 1
output			oOTG_DACK0_N;			//	ISP1362 DMA Acknowledge 0
output			oOTG_DACK1_N;			//	ISP1362 DMA Acknowledge 1
////////////////////	LCD Module 16X2	////////////////////////////
inout		[7:0]	LCD_D;					//	LCD Data bus 8 bits
output			oLCD_ON;					//	LCD Power ON/OFF
output			oLCD_BLON;				//	LCD Back Light ON/OFF
output			oLCD_RW;					//	LCD Read/Write Select, 0 = Write, 1 = Read
output			oLCD_EN;					//	LCD Enable
output			oLCD_RS;					//	LCD Command/Data Select, 0 = Command, 1 = Data
////////////////////	SD Card Interface	////////////////////////
inout				SD_DAT;					//	SD Card Data
inout				SD_DAT3;					//	SD Card Data 3
inout				SD_CMD;					//	SD Card Command Signal
output			oSD_CLK;					//	SD Card Clock
////////////////////////	I2C		////////////////////////////////
inout				I2C_SDAT;				//	I2C Data
output			oI2C_SCLK;				//	I2C Clock
////////////////////////	PS2		////////////////////////////////
inout		 		PS2_KBDAT;				//	PS2 Keyboard Data
inout				PS2_KBCLK;				//	PS2 Keyboard Clock
inout		 		PS2_MSDAT;				//	PS2 Mouse Data
inout				PS2_MSCLK;				//	PS2 Mouse Clock
////////////////////////	VGA			////////////////////////////
output			oVGA_CLOCK;   			//	VGA Clock
output			oVGA_HS;					//	VGA H_SYNC
output			oVGA_VS;					//	VGA V_SYNC
output			oVGA_BLANK_N;			//	VGA BLANK
output			oVGA_SYNC_N;			//	VGA SYNC
output	[9:0]	oVGA_R;   				//	VGA Red[9:0]
output	[9:0]	oVGA_G;	 				//	VGA Green[9:0]
output	[9:0]	oVGA_B;   				//	VGA Blue[9:0]
////////////////	Ethernet Interface	////////////////////////////
inout	[15:0]	ENET_D;					//	DM9000A DATA bus 16Bits
output			oENET_CMD;				//	DM9000A Command/Data Select, 0 = Command, 1 = Data
output			oENET_CS_N;				//	DM9000A Chip Select
output			oENET_IOW_N;			//	DM9000A Write
output			oENET_IOR_N;			//	DM9000A Read
output			oENET_RESET_N;			//	DM9000A Reset
input				iENET_INT;				//	DM9000A Interrupt
output			oENET_CLK;				//	DM9000A Clock 25 MHz
////////////////////	Audio CODEC		////////////////////////////
inout				AUD_ADCLRCK;			//	Audio CODEC ADC LR Clock
input				iAUD_ADCDAT;			//	Audio CODEC ADC Data
inout				AUD_DACLRCK;			//	Audio CODEC DAC LR Clock
output			oAUD_DACDAT;			//	Audio CODEC DAC Data
inout				AUD_BCLK;				//	Audio CODEC Bit-Stream Clock
output			oAUD_XCK;				//	Audio CODEC Chip Clock
////////////////////	TV Devoder		////////////////////////////
input				iTD1_CLK27;				//	TV Decoder1 Line_Lock Output Clock 
input		[7:0]	iTD1_D;    				//	TV Decoder1 Data bus 8 bits
input				iTD1_HS;					//	TV Decoder1 H_SYNC
input				iTD1_VS;					//	TV Decoder1 V_SYNC
output			oTD1_RESET_N;			//	TV Decoder1 Reset
input				iTD2_CLK27;				//	TV Decoder2 Line_Lock Output Clock 		
input		[7:0]	iTD2_D;    				//	TV Decoder2 Data bus 8 bits
input				iTD2_HS;					//	TV Decoder2 H_SYNC
input				iTD2_VS;					//	TV Decoder2 V_SYNC
output			oTD2_RESET_N;			//	TV Decoder2 Reset

////////////////////////	GPIO	////////////////////////////////
inout		[31:0]GPIO_0;					//	GPIO Connection 0 I/O
input				GPIO_CLKIN_N0;     	//	GPIO Connection 0 Clock Input 0
input				GPIO_CLKIN_P0;       //	GPIO Connection 0 Clock Input 1
inout				GPIO_CLKOUT_N0;     	//	GPIO Connection 0 Clock Output 0
inout				GPIO_CLKOUT_P0;      //	GPIO Connection 0 Clock Output 1
inout		[31:0]GPIO_1;					//	GPIO Connection 1 I/O
input				GPIO_CLKIN_N1;       //	GPIO Connection 1 Clock Input 0
input				GPIO_CLKIN_P1;       //	GPIO Connection 1 Clock Input 1
inout				GPIO_CLKOUT_N1;      //	GPIO Connection 1 Clock Output 0
inout				GPIO_CLKOUT_P1;      //	GPIO Connection 1 Clock Output 1
///////////////////////////////////////////////////////////////////
//=============================================================================
// REG/WIRE declarations
//=============================================================================



//=============================================================================
// Structural coding
//=============================================================================


    NiosSoc u0 (
        .clk_50m_clk      (iCLK_50),      //    clk_50m.clk
        .reset_reset_n    (iKEY[0]),    //      reset.reset_n

		  /* PLL interface */
        .dram_clk_clk     (oDRAM0_CLK),     //   dram_clk.clk
        .areset_export    (1'b0),    //     areset.export
        .locked_export    (/* no use */),    //     locked.export
        .phasedone_export (/* no use */), //  phasedone.export

		  /* SDRAM controller inferface */
        .sdram_wire_addr  (oDRAM0_A),  // sdram_wire.addr
        .sdram_wire_ba    (oDRAM0_BA),    //           .ba
        .sdram_wire_cas_n (oDRAM0_CAS_N), //           .cas_n
        .sdram_wire_cke   (oDRAM0_CKE),   //           .cke
        .sdram_wire_cs_n  (oDRAM0_CS_N),  //           .cs_n
        .sdram_wire_dq    (DRAM_DQ[15:0]),    //           .dq
        .sdram_wire_dqm   ({oDRAM0_UDQM1, oDRAM0_LDQM0}),   //           .dqm
        .sdram_wire_ras_n (oDRAM0_RAS_N), //           .ras_n
        .sdram_wire_we_n  (oDRAM0_WE_N),   //           .we_n

		  /* uart */
		  .uart0_rxd        (iUART_RXD),        //      uart0.rxd
        .uart0_txd        (oUART_TXD),        //           .txd

		  /* LEDG */
		  .led_export       (oLEDG)       //        led.export

    );





endmodule

