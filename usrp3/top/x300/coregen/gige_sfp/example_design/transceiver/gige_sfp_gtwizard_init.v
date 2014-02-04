//------------------------------------------------------------------------------
//   ____  ____
//  /   /\/   /
// /___/  \  /    Vendor: Xilinx
// \   \   \/     Version : 2.1
//  \   \         Application : 7 Series FPGAs Transceivers Wizard 
//  /   /         Filename : gige_sfp_gtwizard_init.v
// /___/   /\      
// \   \  /  \ 
//  \___\/\___\
//
//  Description : This module instantiates the modules required for
//                reset and initialisation of the Transceiver
//
// Module GTWIZARD_init
// Generated by Xilinx 7 Series FPGAs Transceivers Wizard
// 
// 
// (c) Copyright 2010-2012 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES. 


`timescale 1ns / 1ps
`define DLY #1

//***********************************Entity Declaration************************

module gige_sfp_GTWIZARD_init #
(
    parameter EXAMPLE_SIM_GTRESET_SPEEDUP            = "TRUE",     // Simulation setting for GT SecureIP model
    parameter EXAMPLE_SIMULATION                     =  0,         // Set to 1 for simulation
    parameter EXAMPLE_USE_CHIPSCOPE                  =  0          // Set to 1 to use Chipscope to drive resets

)
(
    input           SYSCLK_IN,
    input           SOFT_RESET_IN,
    output          GT0_TX_FSM_RESET_DONE_OUT,
    output          GT0_RX_FSM_RESET_DONE_OUT,
    input           GT0_DATA_VALID_IN,

    //_________________________________________________________________________
    //GT0  (X1Y4)
    //____________________________CHANNEL PORTS________________________________
    //----------------------- Channel - Ref Clock Ports ------------------------
    input           GT0_GTREFCLK0_IN,
    //------------------------------ Channel PLL -------------------------------
    output          GT0_CPLLFBCLKLOST_OUT,
    output          GT0_CPLLLOCK_OUT,
    input           GT0_CPLLLOCKDETCLK_IN,
    input           GT0_CPLLRESET_IN,
    //----------------------------- Eye Scan Ports -----------------------------
    output          GT0_EYESCANDATAERROR_OUT,
    //---------------------- Loopback and Powerdown Ports ----------------------
    input   [2:0]   GT0_LOOPBACK_IN,
    input   [1:0]   GT0_RXPD_IN,
    input   [1:0]   GT0_TXPD_IN,
    //----------------------------- Receive Ports ------------------------------
    input           GT0_RXUSERRDY_IN,
    //--------------------- Receive Ports - 8b10b Decoder ----------------------
    output  [1:0]   GT0_RXCHARISCOMMA_OUT,
    output  [1:0]   GT0_RXCHARISK_OUT,
    output  [1:0]   GT0_RXDISPERR_OUT,
    output  [1:0]   GT0_RXNOTINTABLE_OUT,
    //----------------- Receive Ports - Clock Correction Ports -----------------
        output  [1:0]   GT0_RXCLKCORCNT_OUT,
        //------------- Receive Ports - Comma Detection and Alignment --------------
    input           GT0_RXMCOMMAALIGNEN_IN,
    input           GT0_RXPCOMMAALIGNEN_IN,
    //----------------- Receive Ports - RX Data Path interface -----------------
    input           GT0_GTRXRESET_IN,
    output  [15:0]  GT0_RXDATA_OUT,
    output          GT0_RXOUTCLK_OUT,
    input           GT0_RXUSRCLK_IN,
    input           GT0_RXUSRCLK2_IN,
    //----- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
    input           GT0_GTXRXN_IN,
    input           GT0_GTXRXP_IN,
    output          GT0_RXCDRLOCK_OUT,
    output          GT0_RXELECIDLE_OUT,
    //------ Receive Ports - RX Elastic Buffer and Phase Alignment Ports -------
    input           GT0_RXBUFRESET_IN,
    output  [2:0]   GT0_RXBUFSTATUS_OUT,
    //---------------------- Receive Ports - RX PLL Ports ----------------------
    output          GT0_RXRESETDONE_OUT,
    //----------------------------- Transmit Ports -----------------------------
    input           GT0_TXUSERRDY_IN,
    //-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
    input   [1:0]   GT0_TXCHARDISPMODE_IN,
    input   [1:0]   GT0_TXCHARDISPVAL_IN,
    input   [1:0]   GT0_TXCHARISK_IN,
    //---------- Transmit Ports - TX Buffer and Phase Alignment Ports ----------
    output  [1:0]   GT0_TXBUFSTATUS_OUT,
    //---------------- Transmit Ports - TX Data Path interface -----------------
    input           GT0_GTTXRESET_IN,
    input   [15:0]  GT0_TXDATA_IN,
    output          GT0_TXOUTCLK_OUT,
    output          GT0_TXOUTCLKFABRIC_OUT,
    output          GT0_TXOUTCLKPCS_OUT,
    input           GT0_TXUSRCLK_IN,
    input           GT0_TXUSRCLK2_IN,
    //-------------- Transmit Ports - TX Driver and OOB signaling --------------
    output          GT0_GTXTXN_OUT,
    output          GT0_GTXTXP_OUT,
    //--------------------- Transmit Ports - TX PLL Ports ----------------------
    output          GT0_TXRESETDONE_OUT



);



//***********************************Parameter Declarations********************

    parameter STABLE_CLOCK_PERIOD  = 5;               //Period of the stable clock driving this state-machine, unit is [ns]

    //Typical CDRLOCK Time is 50,000UI, as per DS183
    parameter RX_CDRLOCK_TIME      = (EXAMPLE_SIMULATION == 1) ? 1000 : 50000/1.25;
       
    integer   WAIT_TIME_CDRLOCK    = RX_CDRLOCK_TIME / STABLE_CLOCK_PERIOD;      

//-------------------------- GT Wrapper Wires ------------------------------
    wire           gt0_cpllreset_i;
    wire           gt0_cpllreset_t;
    wire           gt0_cpllrefclklost_i;
    wire           gt0_cplllock_i;
    wire           gt0_txresetdone_i;
    wire           gt0_rxresetdone_i;
    wire           gt0_gttxreset_i;
    wire           gt0_gttxreset_t;
    wire           gt0_gtrxreset_i;
    wire           gt0_gtrxreset_t;
    wire           gt0_txpcsreset_i;
    wire           gt0_rxpcsreset_i;
    wire           gt0_txuserrdy_i;
    wire           gt0_txuserrdy_t;
    wire           gt0_rxuserrdy_i;
    wire           gt0_rxuserrdy_t;

    wire           gt0_rxdfeagchold_i;
    wire           gt0_rxdfelfhold_i;
    wire           gt0_rxlpmlfhold_i;
    wire           gt0_rxlpmhfhold_i;




//------------------------------- Global Signals -----------------------------
    wire          tied_to_ground_i;
    wire          tied_to_vcc_i;

    wire           gt0_rxoutclk_i;
    wire           gt0_recclk_stable_i;
    wire           gt0_rxelecidle_i;


    integer  rx_cdrlock_counter= 0;
    reg              rx_cdrlocked;

    wire           gt0_txresetdone_sync;
    wire           gt0_rxresetdone_sync;
    wire           gt0_gttxreset_gt;
    wire           gt0_gtrxreset_gt;

//**************************** Main Body of Code *******************************
    //  Static signal Assigments
    assign  tied_to_ground_i                     =  1'b0;
    assign  tied_to_vcc_i                        =  1'b1;
   assign gt0_cpllrefclklost_i = 1'b0;
    assign  gt0_gttxreset_gt                     =  gt0_gttxreset_t || GT0_GTTXRESET_IN;
    assign  gt0_gtrxreset_gt                     =  gt0_gtrxreset_t || GT0_GTRXRESET_IN;

gige_sfp_sync_block sync_block_txresetdone
          (
             .clk             (SYSCLK_IN),
             .data_in         (gt0_txresetdone_i),
             .data_out        (gt0_txresetdone_sync)
          );

gige_sfp_sync_block sync_block_rxresetdone
          (
             .clk             (SYSCLK_IN),
             .data_in         (gt0_rxresetdone_i),
             .data_out        (gt0_rxresetdone_sync)
          );

//    ----------------------------- The GT Wrapper -----------------------------
    
    // Use the instantiation template in the example directory to add the GT wrapper to your design.
    // In this example, the wrapper is wired up for basic operation with a frame generator and frame 
    // checker. The GTs will reset, then attempt to align and transmit data. If channel bonding is 
    // enabled, bonding should occur after alignment.


    gige_sfp_GTWIZARD #
    (
        .WRAPPER_SIM_GTRESET_SPEEDUP    (EXAMPLE_SIM_GTRESET_SPEEDUP)
    )
    GTWIZARD_i
    (
  
        //_____________________________________________________________________
        //_____________________________________________________________________
        //GT0  (X1Y4)

        //----------------------- Channel - Ref Clock Ports ------------------------
        .GT0_GTREFCLK0_IN               (GT0_GTREFCLK0_IN),
        //------------------------------ Channel PLL -------------------------------
        .GT0_CPLLFBCLKLOST_OUT          (GT0_CPLLFBCLKLOST_OUT),
        .GT0_CPLLLOCK_OUT               (gt0_cplllock_i),
        .GT0_CPLLLOCKDETCLK_IN          (GT0_CPLLLOCKDETCLK_IN),
        .GT0_CPLLREFCLKLOST_OUT         (),
        .GT0_CPLLRESET_IN               (gt0_cpllreset_i),
        //----------------------------- Eye Scan Ports -----------------------------
        .GT0_EYESCANDATAERROR_OUT       (GT0_EYESCANDATAERROR_OUT),
        //---------------------- Loopback and Powerdown Ports ----------------------
        .GT0_LOOPBACK_IN                (GT0_LOOPBACK_IN),
        .GT0_RXPD_IN                    (GT0_RXPD_IN),
        .GT0_TXPD_IN                    (GT0_TXPD_IN),
        //----------------------------- Receive Ports ------------------------------
        .GT0_RXUSERRDY_IN               (gt0_rxuserrdy_i),
        //--------------------- Receive Ports - 8b10b Decoder ----------------------
        .GT0_RXCHARISCOMMA_OUT          (GT0_RXCHARISCOMMA_OUT),
        .GT0_RXCHARISK_OUT              (GT0_RXCHARISK_OUT),
        .GT0_RXDISPERR_OUT              (GT0_RXDISPERR_OUT),
        .GT0_RXNOTINTABLE_OUT           (GT0_RXNOTINTABLE_OUT),
        //----------------- Receive Ports - Clock Correction Ports -----------------
                .GT0_RXCLKCORCNT_OUT            (GT0_RXCLKCORCNT_OUT),
                //------------- Receive Ports - Comma Detection and Alignment --------------
        .GT0_RXMCOMMAALIGNEN_IN         (GT0_RXMCOMMAALIGNEN_IN),
        .GT0_RXPCOMMAALIGNEN_IN         (GT0_RXPCOMMAALIGNEN_IN),
        //----------------- Receive Ports - RX Data Path interface -----------------
        .GT0_GTRXRESET_IN               (gt0_gtrxreset_gt),
        .GT0_RXDATA_OUT                 (GT0_RXDATA_OUT),
        .GT0_RXOUTCLK_OUT               (gt0_rxoutclk_i),
        .GT0_RXPCSRESET_IN              (gt0_rxpcsreset_i),
        .GT0_RXUSRCLK_IN                (GT0_RXUSRCLK_IN),
        .GT0_RXUSRCLK2_IN               (GT0_RXUSRCLK2_IN),
        //----- Receive Ports - RX Driver,OOB signalling,Coupling and Eq.,CDR ------
        .GT0_GTXRXN_IN                  (GT0_GTXRXN_IN),
        .GT0_GTXRXP_IN                  (GT0_GTXRXP_IN),
        .GT0_RXCDRLOCK_OUT              (GT0_RXCDRLOCK_OUT),
        .GT0_RXELECIDLE_OUT             (gt0_rxelecidle_i),
        //------ Receive Ports - RX Elastic Buffer and Phase Alignment Ports -------
        .GT0_RXBUFRESET_IN              (GT0_RXBUFRESET_IN),
        .GT0_RXBUFSTATUS_OUT            (GT0_RXBUFSTATUS_OUT),
        //---------------------- Receive Ports - RX PLL Ports ----------------------
        .GT0_RXRESETDONE_OUT            (gt0_rxresetdone_i),
        //----------------------------- Transmit Ports -----------------------------
        .GT0_TXUSERRDY_IN               (gt0_txuserrdy_i),
        //-------------- Transmit Ports - 8b10b Encoder Control Ports --------------
        .GT0_TXCHARDISPMODE_IN          (GT0_TXCHARDISPMODE_IN),
        .GT0_TXCHARDISPVAL_IN           (GT0_TXCHARDISPVAL_IN),
        .GT0_TXCHARISK_IN               (GT0_TXCHARISK_IN),
        //---------- Transmit Ports - TX Buffer and Phase Alignment Ports ----------
        .GT0_TXBUFSTATUS_OUT            (GT0_TXBUFSTATUS_OUT),
        //---------------- Transmit Ports - TX Data Path interface -----------------
        .GT0_GTTXRESET_IN               (gt0_gttxreset_gt),
        .GT0_TXDATA_IN                  (GT0_TXDATA_IN),
        .GT0_TXOUTCLK_OUT               (GT0_TXOUTCLK_OUT),
        .GT0_TXOUTCLKFABRIC_OUT         (GT0_TXOUTCLKFABRIC_OUT),
        .GT0_TXOUTCLKPCS_OUT            (GT0_TXOUTCLKPCS_OUT),
        .GT0_TXPCSRESET_IN              (gt0_txpcsreset_i),
        .GT0_TXUSRCLK_IN                (GT0_TXUSRCLK_IN),
        .GT0_TXUSRCLK2_IN               (GT0_TXUSRCLK2_IN),
        //-------------- Transmit Ports - TX Driver and OOB signaling --------------
        .GT0_GTXTXN_OUT                 (GT0_GTXTXN_OUT),
        .GT0_GTXTXP_OUT                 (GT0_GTXTXP_OUT),
        //--------------------- Transmit Ports - TX PLL Ports ----------------------
        .GT0_TXRESETDONE_OUT            (gt0_txresetdone_i)



    );

    assign  gt0_rxpcsreset_i                     =  tied_to_ground_i;
    assign  gt0_txpcsreset_i                     =  tied_to_ground_i;



    assign  GT0_CPLLLOCK_OUT                     =  gt0_cplllock_i;
    assign  GT0_TXRESETDONE_OUT                  =  gt0_txresetdone_i;
    assign  GT0_RXRESETDONE_OUT                  =  gt0_rxresetdone_i;
    assign  GT0_RXELECIDLE_OUT                   =  gt0_rxelecidle_i;
    assign  GT0_RXOUTCLK_OUT                     =  gt0_rxoutclk_i;

generate
if (EXAMPLE_USE_CHIPSCOPE == 1) 
begin : chipscope
    assign  gt0_cpllreset_i                      =  GT0_CPLLRESET_IN;
    assign  gt0_gttxreset_i                      =  GT0_GTTXRESET_IN;
    assign  gt0_gtrxreset_i                      =  GT0_GTRXRESET_IN;
    assign  gt0_txuserrdy_i                      =  GT0_TXUSERRDY_IN;
    assign  gt0_rxuserrdy_i                      =  GT0_RXUSERRDY_IN;
end
endgenerate 

generate
if (EXAMPLE_USE_CHIPSCOPE == 0) 
begin : no_chipscope
    assign  gt0_cpllreset_i                      =  gt0_cpllreset_t;
    assign  gt0_gttxreset_i                      =  gt0_gttxreset_t;
    assign  gt0_gtrxreset_i                      =  gt0_gtrxreset_t;
    assign  gt0_txuserrdy_i                      =  gt0_txuserrdy_t;
    assign  gt0_rxuserrdy_i                      =  gt0_rxuserrdy_t;
end
endgenerate 


gige_sfp_TX_STARTUP_FSM #
          (
           .GT_TYPE                  ("GTX"), //GTX or GTH or GTP
           .STABLE_CLOCK_PERIOD      (STABLE_CLOCK_PERIOD),           // Period of the stable clock driving this state-machine, unit is [ns]
           .RETRY_COUNTER_BITWIDTH   (8), 
           .TX_QPLL_USED             ("FALSE"),                       // the TX and RX Reset FSMs must
           .RX_QPLL_USED             ("FALSE"),                       // share these two generic values
           .PHASE_ALIGNMENT_MANUAL   ("FALSE")               // Decision if a manual phase-alignment is necessary or the automatic 
                                                                     // is enough. For single-lane applications the automatic alignment is 
                                                                     // sufficient              
             ) 
gt0_txresetfsm_i      
            ( 
        .STABLE_CLOCK                   (SYSCLK_IN),
        .TXUSERCLK                      (GT0_TXUSRCLK_IN),
        .SOFT_RESET                     (SOFT_RESET_IN),
        .QPLLREFCLKLOST                 (tied_to_ground_i),
        .CPLLREFCLKLOST                 (gt0_cpllrefclklost_i),
        .QPLLLOCK                       (tied_to_vcc_i),
        .CPLLLOCK                       (gt0_cplllock_i),
        .TXRESETDONE                    (gt0_txresetdone_sync),
        .MMCM_LOCK                      (tied_to_vcc_i),
        .GTTXRESET                      (gt0_gttxreset_t),
        .MMCM_RESET                     (),
        .QPLL_RESET                     (),
        .CPLL_RESET                     (gt0_cpllreset_t),
        .TX_FSM_RESET_DONE              (GT0_TX_FSM_RESET_DONE_OUT),
        .TXUSERRDY                      (gt0_txuserrdy_t),
        .RUN_PHALIGNMENT                (),
        .RESET_PHALIGNMENT              (),
        .PHALIGNMENT_DONE               (tied_to_vcc_i),
        .RETRY_COUNTER                  ()
           );






gige_sfp_RX_STARTUP_FSM  #
          (
           .EXAMPLE_SIMULATION       (EXAMPLE_SIMULATION),
           .GT_TYPE                  ("GTX"), //GTX or GTH or GTP
           .EQ_MODE                  ("DFE"),                   //Rx Equalization Mode - Set to DFE or LPM
           .STABLE_CLOCK_PERIOD      (STABLE_CLOCK_PERIOD),              //Period of the stable clock driving this state-machine, unit is [ns]
           .RETRY_COUNTER_BITWIDTH   (8), 
           .TX_QPLL_USED             ("FALSE"),                          // the TX and RX Reset FSMs must
           .RX_QPLL_USED             ("FALSE"),                          // share these two generic values
           .PHASE_ALIGNMENT_MANUAL   ("FALSE")                           // Decision if a manual phase-alignment is necessary or the automatic 
                                                                         // is enough. For single-lane applications the automatic alignment is 
                                                                         // sufficient              
             )     
gt0_rxresetfsm_i
             ( 
        .STABLE_CLOCK                   (SYSCLK_IN),
        .RXUSERCLK                      (GT0_RXUSRCLK_IN),
        .SOFT_RESET                     (SOFT_RESET_IN),
        .QPLLREFCLKLOST                 (tied_to_ground_i),
        .CPLLREFCLKLOST                 (gt0_cpllrefclklost_i),
        .QPLLLOCK                       (tied_to_vcc_i),
        .CPLLLOCK                       (gt0_cplllock_i),
        .RXRESETDONE                    (gt0_rxresetdone_sync),
        .MMCM_LOCK                      (tied_to_vcc_i),
        .RECCLK_STABLE                  (gt0_recclk_stable_i),
        .RECCLK_MONITOR_RESTART         (tied_to_ground_i),
        .DATA_VALID                     (GT0_DATA_VALID_IN),
        .TXUSERRDY                      (tied_to_vcc_i),
        .GTRXRESET                      (gt0_gtrxreset_t),
        .MMCM_RESET                     (),
        .QPLL_RESET                     (),
        .CPLL_RESET                     (),
        .RX_FSM_RESET_DONE              (GT0_RX_FSM_RESET_DONE_OUT),
        .RXUSERRDY                      (gt0_rxuserrdy_t),
        .RUN_PHALIGNMENT                (),
        .RESET_PHALIGNMENT              (),
        .PHALIGNMENT_DONE               (tied_to_vcc_i),
        .RXDFEAGCHOLD                   (gt0_rxdfeagchold_i),
        .RXDFELFHOLD                    (gt0_rxdfelfhold_i),
        .RXLPMLFHOLD                    (gt0_rxlpmlfhold_i),
        .RXLPMHFHOLD                    (gt0_rxlpmhfhold_i),
        .RETRY_COUNTER                  ()
           );




  always @(posedge SYSCLK_IN)
  begin
        if(gt0_gtrxreset_i)
        begin
          rx_cdrlocked       <= `DLY    1'b0;
          rx_cdrlock_counter <= `DLY    0;      
        end                
        else if (rx_cdrlock_counter == WAIT_TIME_CDRLOCK) 
        begin
          rx_cdrlocked       <= `DLY    1'b1;
          rx_cdrlock_counter <= `DLY    rx_cdrlock_counter;
        end
        else
          rx_cdrlock_counter <= `DLY    rx_cdrlock_counter + 1;
  end 

assign  gt0_recclk_stable_i                  =  rx_cdrlocked;







endmodule


