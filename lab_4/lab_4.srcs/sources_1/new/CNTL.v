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


module CNTL(
    input [5:0] Op, Func,
    output reg [0:0] RegWrite,
    output reg [3:0] ALUCntl
);

    always@(*) begin
        if(Op == 6'b0) begin
            RegWrite = 1'b1;
            case(Func)
                6'h20: ALUCntl = 4'b1010; // Add Signed
                6'h21: ALUCntl = 4'b0010; // Add Unsigned
                6'h22: ALUCntl = 4'b1110; // Subtract Signed
                6'h23: ALUCntl = 4'b0110; // Subtract Unsigned
                6'h24: ALUCntl = 4'b0000; // AND gate
                6'h25: ALUCntl = 4'b0001; // OR gate
                6'h26: ALUCntl = 4'b0011; // XOR gate
                6'h27: ALUCntl = 4'b1100; // NOR gate
                6'h2A: ALUCntl = 4'b0101; // Set Less Than Signed
                6'h2B: ALUCntl = 4'b1011; // Set Less Than Unsigned
                default: ALUCntl = 4'bxxxx; // Default
            endcase
        end
        else begin
            RegWrite = 1'b0;
            ALUCntl = 4'bxxxx;
        end
    end

endmodule
