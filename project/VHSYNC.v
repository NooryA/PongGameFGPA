module VHSYNC (clk,hsp,vsp,disparea,hsync, vsync);
input clk;
output reg [9:0] hsp; //Horizontal position
output reg [9:0] vsp; //Vertical position
output reg disparea ; //display area

//vertical and horizontal sync
output hsync;
output vsync;

//pulses
reg vga_H;
reg vga_V;

//total pixels 
wire counterXmax = (hsp == 800);
wire counterYmax = (vsp == 525);

//x, y counters
always @(posedge clk)
if (counterXmax)
hsp <=0;
else
hsp <= hsp + 1;

always @(posedge clk)
begin
if(counterXmax)
begin
if (counterYmax)
vsp <= 0;
else
vsp <= vsp +1;
end 
end

//clock pulses
always @(posedge clk)
begin

// 96 clock pulses for horizontal sync
vga_H <= (hsp > (640 + 16) && (hsp < (640 + 16 + 96)));
// 2 clock pulses for horizontal sync
vga_V <= (vsp > (480 + 10) && (vsp < (480 + 10 + 2)));

end 

always @(posedge clk)
begin

disparea <= (hsp < 640) && (vsp < 480);

end 

//inverting signals for vga outputs
assign hsync = ~vga_H;
assign vsync = ~vga_V;
endmodule