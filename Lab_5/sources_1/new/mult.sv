`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2019 10:10:27
// Design Name: 
// Module Name: mult
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


module mult
    (
        input clk,
        input  reset,
        input  in,
        input  [3:0] B,
        input  [3:0] M,
        output logic [7:0] out,
        output logic [7:0]parB,
        output logic [3:0]parM
    );
     
    typedef enum logic [1:0] {S0,S1,S2} statetype;
    statetype state, nextstate;
            
    // assign parB = B;
    // assign parM = M;
     
    always@ (posedge clk)                //SHIFT REGISTER B 8 bit
    begin 
    if (reset==1)
    begin
      parB[3:0] = B;
      parB[7:4] = 4'b0000;
      parM = M;
      out[7:0] = parB;
  //  out[7:4] = 4'b0000;
    end
    else
    begin
        if(in == 1'b1)
        begin
            parB = parB << 1;
            parM = parM >> 1; 
            if (parM[0] == 1)
                    begin
                       out = parB + out;
                    end
            end  
         end        
    end
    
//    always_ff@ (posedge clk)				//ACCUMULATOR
//    begin
//     //   if (reset == 1'b1)
//    //       out <= 8'b0000_0000;
//        if (in == 1 && parM[0] == 1)
//        begin
//    //       parB = parB[0] * B; 
//            out = parB + out;
//        end
//    end
    
    always_ff@ (posedge clk)				//STATE REGISTER
    begin
       if (reset == 1'b1)
            state <= S0;
       else
         if (in == 1)
            state <= nextstate;
    end
    
 
 always@(posedge clk)					//FSM 
    begin
        case(state)
            S0:
            begin
                if(in == 1 && parM[0] == 1 )
                    nextstate <= S1;
                else if(in == 1 && parM[0] == 0)
                    nextstate <= S2;
            end
            
            S1:
            begin
                if(in == 1 && parM[0] == 1)
                    nextstate <= S1;
                else if(in == 1 && parM[0] == 0)
                    nextstate <= S2;    
            end
    
            S2:
            begin
                if(in == 1 && parM[0] == 1)
                     nextstate <= S1;
                else if(in == 1 && parM[0] == 0)
                     nextstate <= S2;
            end
        endcase
    end
    
    // Output Logic     
        //    always @ (posedge clk)
        always_comb
            begin
                if (state == S0)
                 //   out = 8'b0000_0000;
                 out = out;
                else if (state == S1)
                  out = out;
                else if (state == S2)
                  out = out;
            end

  endmodule

