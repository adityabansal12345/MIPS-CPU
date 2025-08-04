module IF(
	input clk,
	input[10:0] counter,
	input [9:0] newPC,
	output reg[31:0] instructionMEMREAD,
	output reg[9:0] pcRes);
	PC instPC(.clk(clk), .newPC(newPC), .counter(counter), .IFADDRESS(pcRes));
	instruction instInstruction(.IFADDRESS(IFADDRESS), .clk(clk), .counter(counter), .instructionMEMREAD(instructionMEMREAD));
endmodule