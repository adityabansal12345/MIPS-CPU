module HDU(
	input[4:0] dstEX,
	input[4:0] dstMEM,
	input[4:0] dstWB,
	input clk,	
	input[4:0] dstCheck,
	input EXVal,
	input MEMVal,
	input WBVal, 
	output reg stall);
	always@(*)begin
		if(dstCheck == dstEX && EXVal || dstCheck == dstMEM && MEMVal|| dstCheck == dstWB && WBVal)begin
			stall = 1'b1;
		end else
			stall = 1'b0;
	end
endmodule