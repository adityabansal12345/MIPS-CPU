module ID(
	input[31:0] instructionMEMREADIn,
	input clk,
	input[9:0] counter,
	input[4:0] wbDestinationIn,
	input[31:0] WBDataIn,
	input regWriteIn,
	output reg[31:0] regOut1,
	output reg[31:0] regOut2,
	output reg regdst,
	output reg ALUoperand,
	output reg WBData,
	output reg branch,
	output reg regWrite,
	output reg dataMemWrite,
	output reg[3:0] ALUOP,
	output reg[31:0] instructionMEMREAD);
	reg instructionMEMREADUse;
	reg[31:0] regOut1Use;
	reg[31:0] regOut2Use;
	reg regdstUse;
	reg ALUoperandUse;
	reg WBDataUse;
	reg branchUse;
	reg regWriteUse;
	reg dataMemWriteUs;
	reg[3:0] ALUOPUse;
	always@(*)begin
		regOut1 = regOut1Use;
		regOut2 = regOut2Use;
		regdst = regdstUse;
		ALUoperand = ALUoperandUse;
		WBData = WBDataUse;
		branch = branchUse;
		regWrite = regWriteUse;
		dataMemWrite = dataMemWriteUse;
		ALUOP = ALUOPUse;
		instructionMEMREADUse = instructionMEMREADIn;
		instructionMEMREAD = instructionMEMREADUse;
	end
	registerFile instReg(.WBDATA(WBDataIn), .wbDestination(wbDestinationIn), .regWrite(regWriteIn), .regOut1(regOut1Use), .regOut2(regOut2Use), .reg1(instructionMEMREAD[25:21]), .reg2(instructionMEMREAD[20:16]), .clk(clk), .counter(counter)); 
	control instControl(.op(instructionMEMREAD[31:26]), .funct(instructionMEMREAD[5:0]), .clk(clk), .regdst(regdstUse), .ALUoperand(ALUoperandUse), .WBDATA(WBDATAUse), .branch(branchUse), .regWrite(regWriteUse), .dataMemWrite(dataMemWriteUse), .ALUOP(ALUOPUse));
endmodule
	