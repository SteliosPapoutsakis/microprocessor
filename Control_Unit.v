`timescale 1ns/1ns
import common::*;
`define ENABLED 1'b1
`define DISABLED 1'b0

module Control(fetch,Datawr_En,Addwr_En,regEn,PCEn,DataBus_En,store_en,increment,literal,Valid,oppB,oppA,opcode,RW,ready,data,clk,reset);


input [31:0] data;
input ready, clk, reset;
output reg [5:0] opcode;
output reg [4:0] oppB;
output reg [4:0] oppA;
output reg [31:0] literal;
output reg Valid,regEn,increment,Datawr_En,Addwr_En,PCEn,DataBus_En,store_en,RW,fetch;

motherStates motherstate,nextmotherstate;
States state,NextState;
reg [31:0] IR;

always @(posedge reset or posedge clk)
begin
if(reset) begin
state <= State1;
motherstate <= S_fetch;
nextmotherstate <= S_fetch;
NextState <= State1;
opcode <= 6'b0;
oppA <= 5'b0;
oppB <= 5'b0;
literal <= 32'b0;
IR <= 32'b0;
regEn <= `DISABLED;
increment <= `DISABLED;
RW <= `DISABLED;
Datawr_En <= `DISABLED;
Addwr_En <= `DISABLED;
PCEn <= `DISABLED;
DataBus_En <= `DISABLED;
store_en <= `DISABLED;
fetch <= `DISABLED;
end
else begin
state = NextState;
motherstate = nextmotherstate;
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
			//wait for the mem con to start read
			  fetch <= `ENABLED;
				Addwr_En <= `ENABLED;
				#1 Valid <= `ENABLED;
				#1 RW <= `ENABLED;
				wait(!ready);
				wait(ready);
				NextState <= State2;
		  end
     //wating for read to be done

		// lower signals and store in IR reg
			State2: begin
		  AddCon <= `DISABLED;
			Valid <= `DISABLED;
			Addwr_En <= `DISABLED;
			IR <= data;
			nextmotherstate <= S_Decode;
			NextState <= State1;
			end
			//fetch is done here
		endcase
end
//decoding state
S_Decode: begin
			case(state)
//branching based on the 3 main opperations
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
			oppA <= IR[20:16];
			NextState <= State3;
			nextmotherstate <= S_Execute;
			end
			endcase
  end
S_Execute: begin
		case(state)
			State3: begin
			AddCon <= `ENABLED;
			if(opcode[2:0] == 3'b001)
			NextState <= State3;
			else
			NextState <= State1;
			nextmotherstate <= S_store;
			end
endcase
end


S_store: begin
	case(state)
	//load state
	   State1: begin
			 Valid <= `ENABLED;
			 RW <= `ENABLED;
			 wait(!ready);
			 wait(ready);
			 AddCon <= `DISABLED;
			  NextState <= State2;
				 oppA <= IR[25:21];
				regEn <= `ENABLED;
				end

			 State2: begin
			 regEn = `DISABLED;
			 Valid <= `DISABLED;
			 RW <= `DISABLED;
			  increment <= `ENABLED;
			  NextState <= State1;
				nextmotherstate <= S_fetch;
			 end
			 // end load op

       //store state
			  State3: begin
				DataCon <= `ENABLED;
				 oppB <= IR[25:21];
				 RW <= `DISABLED;
				 Valid <= `ENABLED;
				 wait(!ready);
				 wait(ready);
				 NextState <= State1;
				 nextmotherstate <= S_fetch;
				 end
				 //end store state








	endcase
      end
endcase
end
end

endmodule
