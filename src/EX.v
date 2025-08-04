module EX(
	input [3:0] ALUOP,
	input[31:0] instructionMEMREADIn,
	input [31:0] operand1,
	input [31:0] operand2,
	input clk, 
	input[31:0] regOut2In,
	input regdstIn,
	input WBDataIn,
	input branchIn,
	input regWriteIn,
	input dataMemWriteIn,
	output [31:0] out,
	output zero,
	output reg[31:0] regOut2,
	output reg regdst,
	output reg WBData,
	output reg branch,
	output reg regWrite,
	output reg dataMemWrite,
	output reg[31:0] instructionMEMREAD);
	
	always@(*)begin
	
		instructionMEMREAD = instructionMEMREADIn;
		regOut2 = regOut2In;
		regdst = regdstIn;	
		WBData = WBDataIn;
		branch = branchIn;
		regWrite = regWriteIn;
		dataMemWrite = dataMemWriteIn;
	end
	ALU instALU(.ALUOP(ALUOP), .operand1(operand1), .operand2(operand2), .clk(clk), .out(out), .zero(zero));

endmodule