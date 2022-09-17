`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2022 10:49:40 AM
// Design Name: 
// Module Name: CNTL
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Datapath(
    input CLK,
    input Reset,
    output [31:0] Dout
);

    //internal wire
    //wire <define by user> <btw there are 5 of them :ded:>
    //but heres just 2 of them
    //PC
    wire [31:0] PC_Add_out, PC_Out, Inst_out, S, T;
    wire [31:0] ALUOut;
    wire RegWrite;
    wire [3:0] ALUCntl;
    wire C, V, N, Z;
    //instantiate PC
    PC pc(.CLK(CLK), .Reset(Reset), .Din(PC_Add_out), .PC_Out(PC_Out));

    //instatiate instruction memory
    Instruction_Memory im(.Addr(PC_Out), .Inst_out(Inst_out));

    //instantiate all the other modules. Good fucking luck!

    PC_ADD pcadd(.Din(PC_Out),.PC_Add_out(PC_Add_out));

    CNTL control(.Op(Inst_out[31:26]), .Func(Inst_out[5:0]), .RegWrite(RegWrite), .ALUCntl(ALUCntl));

    ALU alu(.A(S), .B(T), .ALUCntl(ALUCntl), .ALUOut(Dout), .C(C), .N(N), .V(V), .Z(Z));

    //Instantiate regfile
    regfile32 rf(.CLK(CLK), .Reset(Reset), .D_En(RegWrite), .D_Addr(Inst_out[15:11]), .S_Addr(Inst_out[25:21]), .T_Addr(Inst_out[20:16]), .D(Dout), .S(S), .T(T));

    //then at the end, only Dout from ALUOut will be the one that outputs
    assign Dout = ALUOut;

endmodule
