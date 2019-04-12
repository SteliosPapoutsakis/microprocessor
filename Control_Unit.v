`timescale 1ns/1ns

module Control(literal,Valid,Rb,Ra,Rc,opcode,fetch,RW,ready,data,clk,reset);

input [31:0] data;
input ready, clk, reset;
output reg [5:0] opcode;
output reg [4:0] Rc;
output reg [4:0] Ra;
output reg [4:0] Rb;
output reg [31:0] literal;
output reg RW;
output reg fetch,Valid;

reg [3:0] state,NextState;
reg [31:0] IR;

always @(posedge reset or posedge clk)
begin
if(reset) begin
state <= 4'b0;
NextState <= 4'b0;
opcode <= 6'b0;
Rc <= 5'b0;
Ra <= 5'b0;
Rb <= 5'b0;
literal <= 32'b0;
fetch <= 1'b0;
RW <= 1'b0;
end
else begin
state <= NextState;
end
end

always @(posedge clk) begin
if(!reset) begin
case(state)
//These states are part of the fetch FSM
4'b0000: begin
	fetch <= 1'b1;
	Valid <= 1'b1;
	RW <= 1'b1;
	if(!ready)
	NextState <= 4'b0001;
	else
	NextState <= 4'b0000;
  end
4'b0001: begin
	if(ready)
	NextState <= 4'b0010;
	else
	NextState <= 4'b0001;
	end
	4'b0010: begin
	fetch <= 1'b0;
	Valid <= 1'b0;
	IR = data;
	
	end
	//fetch is done here
endcase
end
end
endmodule
