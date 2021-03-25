`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2019 10:12:04
// Design Name: 
// Module Name: test
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


module test(

    );
    
     logic clk;
       logic reset;
       logic in;
       logic [3:0]B ;
       logic [3:0]M ;
       logic [7:0] out;
       logic [3:0] parB;
       logic [3:0] parM;
       
       
       
       mult dut(clk, reset, in, B, M, out, parB, parM);
       
       always begin
       clk = 0; #5;
        clk = 1; #5;
       end
       
       initial begin
       in = 1;reset = 1; #5;
        B = 4'b1001;
        M = 4'b1111; 
        #10;reset = 0;
    //    B = 4'b1001;
    //   M = 4'b1111; 
    //   in = 0; 
      
       end
endmodule
