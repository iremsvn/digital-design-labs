//Testbench for only test the basic stepper motor logic
module Testbench();

logic clk;
logic en;
logic dir;
logic [3:0] outsignal;

always
begin
clk = 0; #5; clk = 1; #5;
end

StepperM dut(clk, en, dir, outsignal);

initial begin
#90;
en = 1; 
dir = 0; 
#90
en = 1;
dir = 1;
end

endmodule


//module Testbench();

// logic clk;
// logic en;
// logic dir;
// logic [1:0] speed;
// logic  left, right;
// logic [3:0] outsignal;
// logic [1:0] led;
// logic [6:0]seg;
// logic dp;
// logic [3:0] an;

//always
//begin
//clk = 0; #5; clk = 1; #5;
//end

////StepperM dut(clk, en, dir, left, right, outsignal, led);
//car dut(clk, en, dir, speed, left, right, outsignal, led, seg, dp, an);

//initial begin
//#20;
//speed = 2'b01;
//en = 1; 
//dir = 0;
//left = 1;
//right = 0; 
//#20;
//speed = 2'b10;
//en = 1; 
//dir = 0;
//left = 0;
//right = 1;
//#20;
//en = 0; 
//#20
//speed = 2'b11;
//en = 1;
//dir = 1;
//#20
//speed = 2'b00;
//en = 1;
//dir = 1; 
//end
//endmodule
