`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2016 07:31:24 PM
// Design Name: 
// Module Name: stepMotor
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


module StepperM(
    input clk,
    input logic en,
    input logic dir,
    input logic [1:0] speed,
//  input logic  left, right , 
    output logic [3:0] outsignal
 //  output logic [1:0] led,
 //   output [6:0]seg, logic dp,
 //  output [3:0] an
    );
    //logic clknew;
    
    
    //this enum defines values for each state in 3-bit encodings
    typedef enum logic [2:0] {S0,S1,S2,S3,S4} statetype;
    statetype state, nextstate; 
    
    //initilizing the fsm
    initial state = S0;
    
    //next state logic
        always_comb
        begin
            case(state) 
            S0:
            begin
                // If direction is 0 and enable is 1, the next state is S1.
                // If enable is 0 next state is S0
                if (dir == 1'b0 && en == 1'b1)
                    nextstate = S1;
                else if (dir == 1'b1 && en == 1'b1)
                    nextstate = S4;
                else 
                    nextstate = S0;
            end  
            S1:
            begin
            
                if (dir == 1'b0&& en == 1'b1)
                    nextstate = S2;
                else if (dir == 1'b1 && en == 1'b1)
                    nextstate = S4;
                else 
                    nextstate = S0;
            end 
            S2:
            begin
               if (dir == 1'b0&& en == 1'b1)
                    nextstate = S3;
                else if (dir == 1'b1 && en == 1'b1)
                    nextstate = S1;
                else 
                    nextstate = S0;
            end 
            S3:
            begin
                if (dir == 1'b0&& en == 1'b1)
                    nextstate = S4;
                else if (dir == 1'b1 && en == 1'b1)
                    nextstate = S2;
                else 
                    nextstate = S0;
            end
            S4:
            begin          
                if (dir == 1'b0&& en == 1'b1)
                    nextstate = S1;
                else if (dir == 1'b1 && en == 1'b1)
                    nextstate = S3;
                else 
                   nextstate = S0;
            end
            
            default:
                nextstate = S0; 
            endcase
            end
            
        //Register Logic
            always_ff@(posedge clk)
            begin
            if(en == 0 || speed == 2'b00) state <= S0;
          //  || speed == 2'b00
            else      state <= nextstate;
            end
                   
        // Output Logic     
        always @ (posedge clk)
        begin
            if (state == S1)
                outsignal = 4'b1100;
            else if (state == S2)
                outsignal = 4'b0110;
            else if (state == S3)
                outsignal = 4'b0011;
            else if (state == S4)
                outsignal = 4'b1001;
            else
                outsignal = 4'b0000;
        end
        
 endmodule
           
                
 module car(
 input clk,
 input logic en,
 input logic dir,
 input logic [1:0] speed,
 input logic  left, right , 
 output logic [3:0] outsignal,
 output logic [1:0] led,
 output [6:0]seg, logic dp,
 output [3:0] an

 );

 
 
                
                //Speed Adjustments 
                localparam Mhz = 5000000;
                localparam N = 22;
                logic [N-1:0] counter;
                logic [3:0] digit;
                logic clknew;
                
                
                always@ (posedge clk) 
                begin
                counter <= counter + 1;
                  if (speed == 2'b11)
                  begin
                    if (counter == Mhz)
                    counter <= 0;
                    digit = 4'b0011;
                  end
                  else if (speed == 2'b10)
                  begin
                    if (counter  == 2*Mhz)
                    counter <= 0;
                    digit = 4'b0010;
                  end
                  else if (speed == 2'b01)
                  begin
                    if (counter == 4*Mhz)
                    counter <= 0;
                    digit = 4'b0001;
                  end  
                  else if (speed == 2'b00)
                  begin
                     if (counter == 0)
                     counter <= 0;
                     digit = 4'b0000;
                  end  
                if (counter == 0) 
                     clknew <= 1'b1;
                else clknew <= 1'b0;
                end
                
                //Car Led Signals
                always @ (left)
                    led[1] = left;
                    
                always @ (right)
                    led[0] = right;
                
                
                
     StepperM dut1(clknew, en, dir, speed, outsignal);          
     SevenSegment dut( clknew, digit, 4'b0000, 4'b0000, 4'b0000, seg, dp, an);
      
    endmodule
    

