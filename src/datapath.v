module datapath(
	input clk,
	output reg[31:0] value);
	
	reg[10:0] counter;
	wire[31:0]IFinstructionMEMREAD;
	reg[10:0] newPC;
	wire[31:0] IFinstructionPlus1;
	wire[9:0] IFpcRes;
	reg[31:0] IDinstructionMEMREADIn;
	reg[4:0] IDwbDestinationIn;
	reg[31:0] IDWBDataIn;
	reg IDregWriteIn;
	wire[31:0] IDregOut1;
	wire[31:0] IDregOut2;
	wire IDregdst;
	wire IDALUoperand;
	wire IDWBData;
	wire IDbranch;
	wire IDregWrite;
	wire IDdataMemWrite;
	wire[3:0] IDALUOP;
	reg IDregdstUse;
	reg IDALUoperandUse;
	reg IDWBDataUse;
	reg IDbranchUse;
	reg IDregWriteUse;
	reg IDdataMemWriteUse;
	reg[3:0] IDALUOPUse;
	wire[31:0] IDinstructionMEMREAD;
	reg[31:0] IDinstructionMEMREADUse;
	reg[3:0] EXALUOP;
	reg EXALUoperand;
	reg[31:0] EXinstructionMEMREADIn;
	reg[31:0] EXoperand1;
	reg[31:0] EXoperand2;
	reg[31:0] EXregOut2In;
	reg EXregdstIn;
	reg EXWBDataIn;
	reg EXbranchIn;
	reg EXregWriteIn;
	reg EXdataMemWriteIn;
	wire[31:0] EXout;
	wire EXzero;
	wire[31:0] EXregOut2;
	wire EXregdst;
	wire EXWBData;
	wire EXbranch;
	wire EXregWrite;
	wire EXdataMemWrite;
	wire[31:0] EXinstructionMEMREAD;
	reg[31:0] MEMoutIn;
	wire[31:0] MEMout;
	reg[31:0] MEMinstructionMEMREADIn;
	reg MEMdataMemWrite;
	reg[31:0] MEMregOut2;
	reg MEMregdstIn;
	reg MEMWBDataIn;
	reg MEMregWriteIn;
	wire[31:0] MEMreadDATAMEM;
	wire MEMregdst;
	wire MEMWBData;
	wire MEMregWrite;
	wire [31:0] MEMinstructionMEMREAD;
	reg[31:0] WBout;
	reg[31:0] WBinstructionMEMREAD;
	reg[31:0] WBreadDATAMEM;
	reg WBregdst;
	reg WBWBData;
	reg WBregWriteIn;
	wire WBregWrite;

	reg[4:0] HDUdstEX;
	reg[4:0] HDUdstMEM;
	reg[4:0] HDUdstWB;
	reg[4:0] HDUdstCheck;
	reg [31:0] currState;
	reg[31:0] MEMout;
	wire stall;
	reg stallUse;
	//assign all of the "in" signals
	always@(*)begin
		stallUse  =stall;
		IDinstructionMEMREADUse = IDinstructionMEMREAD;		
		IDregdstUse = IDregdst;
		IDALUoperandUse = IDALUoperand;
		IDWBDataUse = IDWBData;
		IDbranchUse = IDbranch;
		IDregWriteUse = IDregWrite;
		IDdataMemWriteUse = IDdataMemWrite;
		IDALUOPUse = IDALUOP;
		if(EXregdst == 1)
			HDUdstEX = EXinstructionMEMREADIn[15:11];
		else
			HDUdstEX = EXinstructionMEMREADIn[20:16];
		if(MEMregdst == 1)
			HDUdstMEM = MEMinstructionMEMREADIn[15:11];
		else
			HDUdstMEM= MEMinstructionMEMREADIn[20:16];
		if(WBregdst == 1)
			HDUdstWB = WBinstructionMEMREAD[15:11];
		else
			HDUdstWB = WBinstructionMEMREAD[20:16];
		if(IDregdst == 1)
			HDUdstCheck = IDinstructionMEMREAD[15:11];
		else
			HDUdstCheck = IDinstructionMEMREAD[20:16];
	end
	always@(posedge clk)begin
		
		if(counter > 1024 && counter < 1056)begin
			if(stallUse)begin
				IDregdstUse <= 1'b0;
				IDALUoperandUse <= 1'b0;
				IDWBDataUse <= 1'b0;
				IDbranchUse <= 1'b0;
				IDregWriteUse <= 1'b0;
				IDdataMemWriteUse <= 1'b0;
				IDALUOPUse <= 3'b000; 
				newPC <= IFpcRes-2;
			end else begin
				IDinstructionMEMREADIn <= IFinstructionMEMREAD;
				EXinstructionMEMREADIn <= IDinstructionMEMREADUse ;
				MEMinstructionMEMREADIn <= EXinstructionMEMREAD;
				WBinstructionMEMREAD <= MEMinstructionMEMREAD;
				EXALUoperand <= IDALUoperand;
				
				EXoperand1 <= IDregOut1;
				if(EXALUoperand == 1)begin
					EXoperand2 <= EXinstructionMEMREADIn[15:0];
				end else begin
					EXoperand2 <= IDregOut2;
				end
				EXALUOP <= IDALUOP;
				EXregOut2In <= IDregOut2;
				EXregdstIn <= IDregdst;
				EXWBDataIn <= IDWBData;
				EXbranchIn <= IDbranch;
				EXregWriteIn <= IDregWrite;
				EXdataMemWriteIn <= IDdataMemWrite;
				MEMoutIn <= EXout;
				MEMdataMemWrite <= EXdataMemWrite;
				MEMregOut2 <= EXregOut2;
				MEMregdstIn <= EXregdst;
				MEMWBDataIn <= EXWBData;
				MEMregWriteIn <= EXregWrite;
				WBout <= MEMout;
				WBreadDATAMEM <= MEMreadDATAMEM;
				WBregdst <= MEMregdst;
				WBWBData <= MEMWBData;
				WBregWriteIn <= MEMregWrite;
				if(WBregdst == 1)begin
					IDwbDestinationIn <= WBinstructionMEMREAD[15:11];
				end else
					IDwbDestinationIn <= WBinstructionMEMREAD[20:16];
				if(WBWBData == 1)
					IDWBDataIn <= WBout;
				else
					IDWBDataIn <= WBreadDATAMEM;
				IDregWriteIn <= WBregWrite;
				if(EXzero && EXbranchIn)begin
					newPC <= EXinstructionMEMREAD[15:0];
				end else
					newPC <= IFpcRes + 1;
			end

			
		end
		if(counter >1056)begin
			counter <= 0;
		end else 
			counter <= counter + 1;
		if(IDinstructionMEMREADIn == 32'b00000000000000000000000000000000)begin
				currState <= EXout;
		end
		if(IFinstructionMEMREAD == 32'b1)begin
			newPC <= IFpcRes;
			value <= currState;
		end
	end
	HDU instHDU(
		.dstCheck(HDUdstCheck),
		.dstEX(HDUdstEX),
		.dstMEM(HDUdstMEM),
		.dstWB(HDUdstWB),
		.stall(stall)); 		

	WB instWB(
		.out(WBout),
		.instructionMEMREAD(WBinstructionMEMREAD),
		.readDATAMEM(WBreadDATAMEM),
		.regdst(WBregdst),
		.WBData(WBWBData),
		.regWriteIn(WBregWriteIn),
		.regWrite(WBregWrite));

	MEM instMEM(
		.outIn(MEMoutIn),
		.instructionMEMREADIn(MEMinstructionMEMREADIn),
		.dataMemWrite(MEMdataMemWrite),
		.regOut2(MEMregOut2),
		.clk(clk), 
		.counter(counter),
		.regdstIn(MEMregdstIn),
		.WBDataIn(MEMWBDataIn),
		.regWriteIn(MEMregWriteIn),
		.readDATAMEM(MEMreadDATAMEM),
		.regdst(MEMregdst),
		.WBData(MEMWBData),
		.regWrite(MEMregWrite),
		.instructionMEMREAD(MEMinstructionMEMREAD),
		.out(MEMout));

	EX instEX(
		.ALUOP(EXALUOP),
		.instructionMEMREADIn(EXinstructionMEMREADIn),
		.operand1(EXoperand1),
		.clk(clk), 
		.operand2(EXoperand2),
		.regOut2In(EXregOut2In),
		.regdstIn(EXregdstIn),
		.WBDataIn(EXWBDataIn),
		.branchIn(EXbranchIn),
		.regWriteIn(EXregWrite),
		.dataMemWriteIn(EXdataMemWriteIn),
		.out(EXout),
		.zero(EXzero),
		.regOut2(EXregOut2),
		.regdst(EXregdst),
		.WBData(EXWBData),
		.branch(EXbranch),
		.regWrite(EXregWrite),
		.dataMemWrite(EXdataMemWrite),
		.instructionMEMREAD(EXinstructionMEMREAD));
		
	ID instID(
		.instructionMEMREADIn(IDinstructionMemREADIn),
		.clk(clk),
		.counter(counter),
		.wbDestinationIn(IDwbDestinationIn),
		.WBDataIn(IDWBDataIn),
		.regWriteIn(IDregWriteIn),
		.regOut1(IDregOut1),
		.regOut2(IDregOut2),
		.regdst(IDregdst),
		.ALUoperand(IDALUoperand),
		.WBData(IDWBData),
		.branch(IDbranch),
		.regWrite(IDregWrite),
		.dataMemWrite(IDdataMemWrite),
		.ALUOP(IDALUOP),
		.instructionMEMREAD(IDinstructionMEMREAD));

	IF instIF(
		.instructionMEMREAD(IFinstructionMEMREAD), 
		.newPC(newPC),
		.clk(clk),
		.counter(counter),
		.pcRes(IFpcRes));

	

endmodule