//MemController by Stelios and Jessie

module MemController(data_in,data,ready,Addr,wrEn,rdEn,Valid,RW,Addr_in,reset,clk);

parameter width = 32;
parameter adwidth = 32;

output reg rdEn,wrEn,ready;
output [adwidth-1:0] Addr;

inout tri [width-1:0] data_in,data;


reg [1:0] state,next_state;
input clk,reset,RW,Valid;
input [adwidth-1:0] Addr_in;

//assgin the tri state buffers values
assign data =(!RW && Valid)?data_in:32'bzz;
assign data_in = (RW && Valid)?data:32'bzz;
assign Addr = Addr_in / 4;

always @ ( * ) begin
  if(reset) fork
  state <= 2'b00;
  next_state <= 2'b00;
  rdEn <= 1'b0;
  wrEn <= 1'b0;
  ready <= 1'b0;
join
else fork
state <= next_state;
join
end

always @ ( posedge clk && !reset ) begin
  case (state)
    2'b00: begin
     if(Valid && !RW)
    next_state <= 2'b01;
    else if(Valid && RW)
    next_state <= 2'b10;
    else
    next_state <= 2'b00;
    ready <= 1'b1;
    rdEn <= 1'b0;
    wrEn <= 1'b0;
    end
    2'b01: begin
    next_state <= 2'b11;
    ready <= 1'b0;
    rdEn <= 1'b1;
    wrEn <= 1'b0;
    repeat(2)
    @(posedge clk);
    end

    2'b10: begin
    next_state = 2'b11;
    ready <= 1'b0;
    rdEn <= 1'b0;
    wrEn <= 1'b1;
    repeat(2)
    @(posedge clk);

    end

    2'b11: begin
    ready <= 1'b1;
    rdEn <= 1'b0;
    wrEn <= 1'b0;
    wait(!Valid);
    next_state = 1'b00;
end
endcase
end
endmodule
