`timescale 1ns/1ns
import common::*;
`define ENABLED 1'b1
`define DISABLED 1'b0

//Written by STelios and JEssie
//this is all behavoiral

module Control(fetch,Datawr_En,Addwr_En,regEn,PCEn,DataBus_En,store_en,Branch_En,increment,literal,Valid,oppB,oppA,opcode,RW,ready,data,clk,reset);


input [31:0] data;
input ready, clk, reset;
output reg [5:0] opcode;
output reg [4:0] oppB;
output reg [4:0] oppA;
output reg [31:0] literal;
output reg Valid,regEn,increment,Datawr_En,Addwr_En,PCEn,DataBus_En,store_en,RW,fetch,Branch_En;

motherStates motherstate,nextmotherstate;
States state,NextState;
reg [31:0] IR;

always @(posedge reset or posedge clk)
begin
//if we reset we want to have all these values
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
	Branch_En <= `DISABLED;
end
else begin
//else we want next state tranistions
	state = NextState;
	motherstate = nextmotherstate;
end
end

always @(posedge clk) begin
if(!reset) begin
//the overall mother FSM
case (motherstate)
S_fetch: begin

	case(state)
//These states are part of the fetch FSM
		State1: begin
			//wait for the mem con to start read
			  increment <= `DISABLED;
			  fetch <= `ENABLED;
				Addwr_En <= `ENABLED;
				Valid <= `ENABLED;
				RW <= `ENABLED;
				//handshake here
				wait(!ready);
				wait(ready);
				NextState <= State2;
		  end
     //wating for read to be done

		// lower signals and store in IR reg, go to decode
			State2: begin
			Valid <= `DISABLED;
			Addwr_En <= `DISABLED;
			fetch <= `DISABLED;
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
			//this is for 2 opperations instructions arthrimatic
			State2: begin
			literal <= {32'b0};
			opcode <= IR[31:26];
			oppA <= IR[20:16];
			oppB <= IR[15:11];
			NextState <= State1;
			nextmotherstate <= S_ExecuteArth;
			end
			// this is for 1 opperation arthmatic
			State3: begin
			literal <= {16'b0,IR[15:0]};
			opcode <= IR[31:26];
			oppA <= IR[20:16];
			NextState <= State1;
			nextmotherstate <= S_ExecuteArth;
			end
			//this state is for LD,Store instructions
			State4: begin
			literal <= {16'b0,IR[15:0]};
			opcode <= IR[31:26];
			oppA <= IR[20:16];
			NextState <= State1;
			nextmotherstate <= S_ExecuteBLS;
			end
			endcase
  end

//this execute is for arthemtic operations
	S_ExecuteArth: begin
	case (state)
	State1: begin
	Datawr_En <= `ENABLED;
	store_en <= `DISABLED;
	nextmotherstate <= S_store;
	NextState <= State4;
	end
	endcase
	end

	S_ExecuteBLS: begin
		case (state)
		  //this state gets address on bus for load and store
			State1: begin
			Addwr_En <= `ENABLED;
			if(opcode[2:0] == 3'b001)
			NextState <= State3;
			else if(opcode[2:0] == 3'b000)
			NextState <= State1;
			nextmotherstate <= S_store;
			end

		endcase

	end





S_store: begin
	case(state)
	//*****************
	//States 1-3 are for load and store//
	   State1: begin
		 	Addwr_En <= `DISABLED;
			 Valid <= `ENABLED;
			 RW <= `ENABLED;
			 oppA <= IR[25:21];
			 //handshake
			 wait(!ready);
			 wait(ready);
			 Valid <= `DISABLED;
			 store_en <= `ENABLED;
			 regEn <= `ENABLED;
			 NextState <= State2;
			 end
			 State2: begin
			 regEn = `DISABLED;
			 store_en = `DISABLED;
			  increment <= `ENABLED;
			  NextState <= State1;
				nextmotherstate <= S_fetch;
			 end
			 //store state
			  State3: begin
				 	Addwr_En <= `DISABLED;
			  	oppA <= IR[25:21];
					literal <= 32'b0;
				  Datawr_En <= `ENABLED;
				  DataBus_En <= `ENABLED;
				 RW <= `DISABLED;
				 Valid <= `ENABLED;
				 wait(!ready);
				 wait(ready);
				 NextState <= State1;
				 nextmotherstate <= S_fetch;
				 Datawr_En <= `DISABLED;
				 DataBus_En <= `DISABLED;
				 end
				 // end load store States
				//****************
				 //states 4-5 are to store values back in file registers
				 State4: begin
				 Datawr_En <= `DISABLED;
				 oppA <= IR[25:21];
				 regEn <= `ENABLED;
				 NextState <= State5;
				 end
				 State5: begin
				 regEn <= `DISABLED;
				 nextmotherstate <= S_fetch;
				 NextState <= State1;
				 increment <= `ENABLED;
				 end











	endcase
      end
endcase
end
end

endmodule
