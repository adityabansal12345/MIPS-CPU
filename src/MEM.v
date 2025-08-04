module MEM(
	input [31:0] outIn,
	input[31:0] instructionMEMREADIn,
	input dataMemWrite,
	input [31:0] regOut2,
	input clk, 
	input [10:0] counter,
	input regdstIn,
	input WBDataIn,
	input regWriteIn,
	output [31:0] readDATAMEM,
	output reg regdst,
	output reg WBData,
	output reg regWrite,
	output reg [31:0] instructionMEMREAD,
	output reg[31:0] out );
	always@(*)begin
		instructionMEMREAD = instructionMEMREADIn;
		regdst = regdstIn;
		WBData = WBDataIn;
		regWrite = regWriteIn;
		out = outIn;
	end
	DATAMEM instDATA(.out(outIn), .dataMemWrite(dataMemWrite), .regOut2(regOut2), .clk(clk),.counter(counter), .readDATAMEM(readDATAMEM));

endmodule