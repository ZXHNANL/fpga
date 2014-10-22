
// Write xilinx DSP48E1 primitive for multiplication with AXI interfaces
// Latency must be 1 to 4

// FIXME handle tlast

module mult
  #(parameter WIDTH_A=25,
    parameter WIDTH_B=18,
    parameter WIDTH_P=0,
    parameter LATENCY=3)
   (input clk, input reset,
    input [WIDTH_A-1:0] a_tdata, input a_tlast, input a_tvalid, output a_tready,
    input [WIDTH_B-1:0] b_tdata, input b_tlast, input b_tvalid, output b_tready,
    /* p_tdata declared below */ output p_tlast, output p_tvalid, output p_tready);
   
   localparam WIDTH_P_IN = (WIDTH_P == 0) ? (WIDTH_A+WIDTH_B) : WIDTH_P;
   output [WIDTH_P_IN-1:0] p_tdata;

   wire [47:0] 		   P1_OUT;
   wire [24:0] 		   A_IN = { a_tdata, {(25-(WIDTH_A)){1'b0}}};
   wire [17:0] 		   B_IN = { b_tdata, {(18-(WIDTH_B)){1'b0}}};
   assign p_tdata = P1_OUT[42 : (42-((WIDTH_A+WIDTH_B)-1))];
   
   localparam MREG_IN = 1;    // Always have this reg
   localparam PREG_IN = (LATENCY >= 3) ? 1 : 0;
   localparam A2REG_IN = (LATENCY >= 2) ? 1 : 0;
   localparam A1REG_IN = (LATENCY == 4) ? 1 : 0;
   localparam AREG_IN = A1REG_IN + A2REG_IN;

   wire [A1REG_IN:0] 		   en0, en1;
   wire [PREG_IN:0] 		   en_post;
   reg 				   CEP, CEM, CEA2, CEA1, CEB2, CEB1;
   wire 			   CE = 1'b1;   // FIXME
   
   always @*
     case(LATENCY)
       2 : {CEP, CEM, CEA2, CEA1, CEB2, CEB1} <= { 1'b0      , en_post[0], en0[0], 1'b0  , en1[0], 1'b0   };
       3 : {CEP, CEM, CEA2, CEA1, CEB2, CEB1} <= { en_post[1], en_post[0], en0[0], 1'b0  , en1[0], 1'b0   };
       4 : {CEP, CEM, CEA2, CEA1, CEB2, CEB1} <= { en_post[1], en_post[0], en0[1], en0[0], en1[1], en1[0] };
     endcase
	 
   axi_pipe_join #(.PRE_JOIN_STAGES0(AREG_IN), .PRE_JOIN_STAGES1(AREG_IN),
		   .POST_JOIN_STAGES(MREG_IN+PREG_IN)) axi_pipe
     (.clk(clk), .reset(reset), .clear(0),
      .i0_tvalid(a_tvalid), .i0_tready(a_tready),
      .i1_tvalid(b_tvalid), .i1_tready(b_tready),
      .o_tvalid(p_tvalid), .o_tready(p_tready),
      .enables0(en0), .enables1(en1), .enables_post(en_post));
   
   DSP48E1 #(.ACASCREG(AREG_IN),       
             .AREG(AREG_IN),           
             .ADREG(0),
             .DREG(0),
             .BCASCREG(AREG_IN),       
             .BREG(AREG_IN),           
             .MREG(MREG_IN),           
             .PREG(PREG_IN)) 
   DSP48_inst (.ACOUT(),   
               .BCOUT(),  
               .CARRYCASCOUT(), 
               .CARRYOUT(), 
               .MULTSIGNOUT(), 
               .OVERFLOW(), 
               .P(P1_OUT),          
               .PATTERNBDETECT(), 
               .PATTERNDETECT(), 
               .PCOUT(),  
               .UNDERFLOW(), 
               .A({5'b0,A_IN}),          
               .ACIN(30'b0),    
               .ALUMODE(4'b0000), 
               .B(B_IN),          
               .BCIN(18'b0),    
               .C(48'b0),          
               .CARRYCASCIN(1'b0), 
               .CARRYIN(1'b0), 
               .CARRYINSEL(3'b0), 
               .CEA1(CEA1),      
               .CEA2(CEA2),      
               .CEAD(1'b0),
               .CEALUMODE(1'b1), 
               .CEB1(CEB1),      
               .CEB2(CEB2),      
               .CEC(CE),       //
               .CECARRYIN(CE), 
               .CECTRL(CE), 
               .CED(CE),
               .CEINMODE(CE),
               .CEM(CEM),       
               .CEP(CEP),       
               .CLK(clk),       
               .D(25'b0),
               .INMODE(5'b0),
               .MULTSIGNIN(1'b0), 
               .OPMODE(7'b0000101), 
               .PCIN(48'b0),      
               .RSTA(reset),     
               .RSTALLCARRYIN(reset), 
               .RSTALUMODE(reset), 
               .RSTB(reset),     
               .RSTC(reset),   
               .RSTD(reset),  
               .RSTCTRL(reset),
               .RSTINMODE(reset), 
               .RSTM(reset), 
               .RSTP(reset));
   
endmodule // mult
