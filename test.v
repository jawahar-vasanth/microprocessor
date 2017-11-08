`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:   00:50:53 11/06/2017
// Design Name:   mini
// Module Name:   C:/Users/JawaharPC/Documents/Xilinx/mini/test1.v
// Project Name:  mini
// Target Device: 
// Tool versions: 
// Description:
//
// Verilog Test Fixture created by ISE for module: mini
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////

module test;

    // Inputs
    reg clk;

    // Outputs
    wire L;
    wire W;
    wire R;
    wire S;

    // Instantiate the Unit Under Test (UUT)
    mini uut (
        .clk(clk),
        .L(L),
        .W(W),
        .R(R),
        .S(S)
    );

    initial begin
    $dumpfile("test.vcd");
    $dumpvars(0,test);
 // Initialize Inputs
        clk = 0;
                // Wait 100 ns for global reset to finish
     repeat(1000) begin
     #100 ;
        clk=!clk;
    end
      end 
        // Add stimulus here

   
     
endmodule


