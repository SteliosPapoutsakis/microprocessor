`timescale 1ns/1ns
import common::*;

module Control(literal,Valid,regEn,oppB,oppA,opcode,fetch,RW,ready,data,clk,reset);

input [31:0] data;
input ready, clk, reset;
output reg [5:0] opcode;
output reg [4:0] oppB;
output reg [4:0] oppA;
output reg [31:0] literal;
output reg RW;
output reg fetch,Valid,regEn;

motherStates motherstate,nextmotherstate;
States state,NextState;
reg [31:0] IR;

always @(posedge reset or posedge clk)
begin
if(reset) begin
state <= 4'b0;
motherstate <= S_fetch;
nextmotherstate <= S_fetch;
NextState <= State1;
opcode <= 6'b0;
regEn <= 1'b0;
oppA <= 5'b0;
oppB <= 5'b0;
literal <= 32'b0;
fetch <= 1'b0;
RW <= 1'b0;
excuteEn <= 1'b0;
end
else begin
state <= NextState;
motherstate <= nextmotherstate;
end
end

always @(posedge clk) begin
if(!reset) begin
//the overall mother FSMs
case (motherstate)
S_fetch: begin

	case(state)
//These states are part of the fetch FSM
		State1: begin
			fetch <= 1'b1;
			Valid <= 1'b1;
			RW <= 1'b1;
			if(!ready)
			NextState <= State2;
			else
			NextState <= State1;
		  end
		  State2: begin
			if(ready)
			NextState <= 4'b0010;
			else
			NextState <= 4'b0001;
			end
			State3: begin
			fetch <= 1'b0;
			Valid <= 1'b0;
			IR <= data;
			nextmotherstate <= S_Decode;
			NextState <= State1;
			end
			//fetch is done here
		endcase
end
S_Decode: begin
			case(state)
			State1: begin
			if(IR[31:30] == 2'b10)
			NextState <= State2;
			else if(IR[31:30] == 2'b11)
			NextState <= State3;
			else if(IR[31:30] == 2'b01)
			NextState <= State4;
			end
			//this state is for LD,Store instructions
			State4: begin
			literal <= {16'b0,IR[15:0]};
			opcode <= IR[31:26];
			oppA <= IR[25:21];
			oppB <= IR[20:16];
			NextState <= State3;
			nextmotherstate <= S_Execute;
			end
			endcase
  end
S_Execute: begin
		case(state)
			State3: begin
			if(opcode[2:0] == 3'b001)
			NextState <= State4;
			else
			NextState <= State5;
		  end

			State4: begin
			nextmotherstate <= S_store;
			NextState <= State2;
			end
			endcase
		end
S_store: begin
	case(state)
		State2: begin
		regEn <= 1'b0;
		Valid <= 1'b1;
		RW <= 1'b0;

		end


endcase
end
end
endmodule
