`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2022 11:45:57 AM
// Design Name: 
// Module Name: Datapath_TB
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


module Datapath_TB();

    //step 1: define data structure

    reg CLK, Reset;
    wire [31:0] Dout;
    integer i;

    //instantiate datapath uut
    Datapath d( .CLK(CLK), .Reset(Reset), .Dout(Dout));

    //create a clock genereator (logic)
    always begin
        #10 CLK = ~CLK;
    end

    //define a task to read the value of the register file
    task Save_Reg;
        begin
            $timeformat (-9, 1, "ns", 9);
            for(i=0;i<32;i=i+1) begin
                @(posedge CLK)
                $display ("t=%t rf[%0d1] %h", $time, i,  d.rf.regArray[i]);
            end
        end
    endtask


    // start testing logic
    initial begin
        CLK = 0;
        Reset = 1;
        #20 Reset = 0;

        //time to use some strange functions (info about them in Lab4_Inro_and_Verilog (slide 26)
        $readmemh("imem.dat", d.im.imem);
        $readmemh("regfile.dat", d.rf.regArray);

        Save_Reg;
        #20 Reset = 1;
        $finish;
    end

endmodule
