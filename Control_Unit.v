`timescale 1ns/1ns
import common::*;
`define ENABLED 1'b1
`define DISABLED 1'b0

//Written by STelios and JEssie
//this is all behavoiral

module Control(fetch,store_PC,Datareg_wr_En,Addreg_wr_En,regfile_wr_En,PC_wr_En,DataBus_En,store_databusvalue,Branch_En,
	increment,literal,Valid,oppB,oppA,opcode,literalEn,RW,ready,data,clk,reset);


input [31:0] data;
input ready, clk, reset;
output reg [5:0] opcode;
output reg [4:0] oppB;
output reg [4:0] oppA;
output reg [31:0] literal;
output reg Valid,regfile_wr_En,increment,Datareg_wr_En,Addreg_wr_En,
PC_wr_En,DataBus_En,store_databusvalue,RW,fetch,Branch_En,store_PC,literalEn;

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
	regfile_wr_En <= `DISABLED;
	increment <= `DISABLED;
	RW <= `DISABLED;
	Datareg_wr_En <= `DISABLED;
	Addreg_wr_En <= `DISABLED;
	PC_wr_En <= `DISABLED;
	DataBus_En <= `DISABLED;
	store_databusvalue<= `DISABLED;
	fetch <= `DISABLED;
	Branch_En <= `DISABLED;
	store_PC <= `DISABLED;
	literalEn <= `DISABLED;
	Valid <= `DISABLED;

end
else begin
//QUEST??????????????????? why does this not work in non blocking?
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
			//start reading process of new instruction
 				fetch <= `ENABLED;
				Addreg_wr_En <= `ENABLED;
				Valid <= `ENABLED;
				RW <= `ENABLED;
				//handshake here
				wait(!ready);
				wait(ready);
				//read is done
				NextState <= State2;
		  end


		// lower signals and store instruction in IR reg, go to decode state
			State2: begin
  		increment <= `ENABLED;
		 	Valid <= `DISABLED;
			Addreg_wr_En <= `DISABLED;
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
//branching based on the 3 main opperations, Load store, arithmetic/logic, branching
			State1: begin
  		increment <= `DISABLED;
			if(IR[31:30] == 2'b10)
			NextState <= State2;
			else if(IR[31:30] == 2'b11)
			NextState <= State3;
			else if(IR[31:30] == 2'b01) begin
				if(IR[28:26] == 3'b000 || IR[28:26] == 3'b001 ||IR[28:26] == 3'b111)
				NextState <= State4;
				else
				NextState <= State5;
				end
			end
			//this is for 2 opperations instructions  arithmetic/logic
			State2: begin
			literal <= {32'b0};
			opcode <= IR[31:26];
			oppA <= IR[20:16];
			oppB <= IR[15:11];
			literalEn <= `DISABLED;
			NextState <= State1;
			nextmotherstate <= S_ExecuteArth;
			end
			// this is for 1 opperation  arithmetic/logic
			State3: begin
			literal <= {{16{IR[15]}},IR[15:0]};
			opcode <= IR[31:26];
			oppA <= IR[20:16];
			oppB <= 5'b11111;
			literalEn <= `ENABLED;
			NextState <= State1;
			nextmotherstate <= S_ExecuteArth;
			end
			//this state is for load and store instructions
			State4: begin
			literal <= {{16{IR[15]}},IR[15:0]};
			opcode <= IR[31:26];
			oppA <= IR[20:16];
			oppB <= 5'b11111;
			literalEn <= `ENABLED;
			NextState <= State1;
			nextmotherstate <= S_ExecuteLS;
			end
			//this is for branching instructions
			State5: begin
			literal <= {{16{IR[15]}},IR[15:0]};
			opcode <= IR[31:26];
			oppA <= IR[25:21];
			oppB <= 5'b11111;
			literalEn <= `DISABLED;
			NextState <= State1;
			nextmotherstate <= S_ExecuteBR;
			end
			endcase
  end

//this execute is for  arithmetic/logic operations
	S_ExecuteArth: begin
		case (state)
		State1: begin
		Datareg_wr_En <= `ENABLED;
		store_databusvalue <= `DISABLED;
		nextmotherstate <= S_store;
		NextState <= State4;
		end
		endcase
	end

//this execute is for  load and store operations
	S_ExecuteLS: begin
		case (state)
		  //this state gets address on bus for load and store
			State1: begin
			Addreg_wr_En <= `ENABLED;
			if(opcode[2:0] == 3'b001)
			//is this a store instruction?
			NextState <= State2;
			//else is this a load instruction
			else if(opcode[2:0] == 3'b000)
			NextState <= State3;
			// else this must be a LDR instruction
			else
			NextState <= State4;
			end

			//for store instruction, getting ready to store value on data bus
			State2: begin
			Addreg_wr_En <= `DISABLED;
		 oppA <= IR[25:21];
			literalEn <= `DISABLED;
		 Datareg_wr_En <= `ENABLED;
		 DataBus_En <= `ENABLED;
		 NextState <= State3;
		 nextmotherstate <= S_store;
		 end


			//for load/LDR instructions,  putting value on address bus
			State3: begin
			Branch_En <= `DISABLED;
			Addreg_wr_En <= `DISABLED;
		 oppA <= IR[25:21];
		 NextState <= State1;
		 nextmotherstate <= S_store;
		 end
		 // LDR instruction, put PC + 4 * literial in Address reg
		 State4:begin
		 Branch_En <= `ENABLED;
		 literal <= 4*literal;
		 NextState <= State3;
		 end
		  endcase
	end


//executing for branching operations
	S_ExecuteBR: begin
		case(state)
		//we are storing the pc value in data reg, branching based in operations type
			State1: begin
			store_PC <= `ENABLED;
			regfile_wr_En <= `ENABLED;
			if(opcode[1:0] == 3'b11)
			NextState <= State2;
			else
			NextState <= State3;
			end
//this is for jump operation, we are reading oppA into data reg
			State2: begin
			store_PC <= `DISABLED;
			regfile_wr_En <= `DISABLED;
			oppA <= IR[20:16];
			Datareg_wr_En <= `ENABLED;
			NextState <= State6;
			nextmotherstate <= S_store;
			end
//this state is for BNE BEQ operations
			State3: begin
	//write the value of reg a on the data bus
   	  store_PC <= `DISABLED;
			regfile_wr_En <= `DISABLED;
			oppA <= IR[20:16];
			Datareg_wr_En <= `ENABLED;
			DataBus_En <= `ENABLED;
			NextState <= State4;
			end

			State4: begin
				Datareg_wr_En <= `DISABLED;
				// if this is the case, we want to branch!
				if(data && opcode[2:0] == 3'b101 || !data && opcode[2:0] == 3'b100)
				NextState <= State7;
				else
				NextState <= State5;
				nextmotherstate <= S_store;
				end

		endcase
	end





// this is the store FSM for all operations
S_store: begin
	case(state)
	//*****************
	//States 1-3 are for load and store//
	//this state is for load
	   State1: begin
 	 	store_databusvalue <= `ENABLED;
		Datareg_wr_En <= `ENABLED;
		 Valid <= `ENABLED;
		 RW <= `ENABLED;
			 //handshake
			 wait(!ready);
			 wait(ready);
			 Valid <= `DISABLED;
			 store_databusvalue <= `DISABLED;
	 		Datareg_wr_En <= `DISABLED;
			 regfile_wr_En <= `ENABLED;
			 NextState <= State2;
			 end
			 //lowering signals and getting ready for next instruction
			 State2: begin
			 regfile_wr_En <= `DISABLED;
			 store_databusvalue <= `DISABLED;
			  NextState <= State1;
				nextmotherstate <= S_fetch;
			 end
			 //this is for store state
			  State3: begin
				Datareg_wr_En <= `DISABLED;
				Valid <= `ENABLED;
				 RW <= `DISABLED;
				 Valid <= `ENABLED;
				 wait(!ready);
				 wait(ready);
				 Valid <= `DISABLED;
				 DataBus_En <= `DISABLED;
				 NextState <= State1;
				 nextmotherstate <= S_fetch;
				 end
				 // end load store States
				//****************
				 //states 4-5 are to store values back in file registers
				 State4: begin
				 Datareg_wr_En <= `DISABLED;
				 oppA <= IR[25:21];
				 regfile_wr_En <= `ENABLED;
				 NextState <= State5;
				 end
				 State5: begin
				 DataBus_En <= `DISABLED;
				 regfile_wr_En <= `DISABLED;
				 PC_wr_En <= `DISABLED;
				 nextmotherstate <= S_fetch;
				 NextState <= State1;
				 end
				 //this is to store a value in pc
				 State6: begin
				 Branch_En <= `DISABLED;
				 Datareg_wr_En <= `DISABLED;
				 PC_wr_En <= `ENABLED;
				 NextState <= State5;
				 end

				 //this is for branching with a literal
				 State7: begin
				 Branch_En <= `ENABLED;
				 literal <= literal * 4;
				 literalEn <= `ENABLED;
				 DataBus_En <= `DISABLED;
				 Datareg_wr_En <= `ENABLED;
				 NextState <= State6;
				 end




	endcase
      end
endcase
end
end

endmodule
