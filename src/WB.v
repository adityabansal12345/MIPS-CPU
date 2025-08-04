module WB(
	input [31:0] out,
	input[31:0] instructionMEMREAD,
	input [31:0] readDATAMEM,
	input regdst,
	input WBData,
	input regWriteIn,
	output reg regWrite);
	reg[31:0] WBDataOut;
	reg[4:0] regdstOut;
	always@(*)begin
		regWrite = regWriteIn;
		if(regdst == 1)begin
			regdstOut <= instructionMEMREAD[15:11];			
		end else begin
			regdstOut <= instructionMEMREAD[20:16];
		end
		if(WBData == 1)begin
			WBDataOut <= out;
						
		end else begin
			WBDataOut <= readDATAMEM;
		end
	end
	

endmodule