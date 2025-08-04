module datapath(
	input clk,
	output reg[31:0] value);
	reg[10:0] counter = 0;
	wire regdst;
	wire ALUoperand;
	wire WBDATA;
	wire regWrite;
	wire dataMemWrite;
	wire[3:0] ALUControl;
	wire[9:0] pc;
	wire[31:0] instruction;
	reg[4:0] address;
	wire[31:0] regOut1;
	wire[31:0] regOut2;
	reg[9:0] newPC;
	reg[31:0] ALUOp2;
	wire[31:0] out;
	wire zero;
	wire branch;
	wire[31:0] DMEMOUT;
	reg[31:0] wbVal;
	reg[31:0] valueLast;
	reg[5:0]writeTime = 0;
	wire [31:0] instruction1;
	PC u2(.clk(clk), .newPC(newPC), .IFAddress(pc), .counter(counter));
	registerFile u5(.reg1(instruction[25:21]), .reg2(instruction[20:16]), .clk(clk), .regWrite(regWrite), .wb(address), .wbValue(wbVal), .regOut1(regOut1), .regOut2(regOut2), .counter(counter));
	INSTRUCTION u4(.clk(clk), .PCINPUT(pc), .instructionMEMREAD(instruction), .counter(counter), .instructionPlus1(instruction1));
	
    control u1(.branch(branch), .regdst(regdst), .ALUoperand(ALUoperand), .WBDATA(WBDATA), .regWrite(regWrite), .dataMemWrite(dataMemWrite), .ALUControl(ALUControl), .clk(clk), .funct(instruction[5:0]), .op(instruction[31:26]));
		
	always@(posedge clk)begin
		if(!(counter <1056 && counter > 1024))begin
			if(regdst == 1)
				address	 <= instruction[15:11];
			else 
				address <= instruction[20:16];
			if(ALUoperand == 1)
				ALUOp2 <= instruction[15:0];
			else
				ALUOp2 <= regOut2;
			if(WBDATA)
				wbVal <= out;
			else
				wbVal <= DMEMOUT;
			if(branch && zero)
				newPC <= instruction[15:0];
			else
				newPC <= pc + 1;		
			if(instruction == {32{1'b1}})begin
				value <= valueLast;
				newPC <= pc;
			end else begin
				if(instruction1 == 32'b00000000000000000000000000000000)begin// ad 32 bits of 0 to indicate setting a value.
					value <= out;
					valueLast <= out;
										
				end
			end
			
		end
		if(counter > 1056)
			counter <= 0;
		else
			counter <= counter + 1;
	end

	ALU u6(.ALUOP(ALUControl), .operand1(regOut1), .operand2(ALUOp2), .clk(clk),.out(out), .zero(zero));
	DATAMEM u7(.ADDRESS(out), .writeValidate(dataMemWrite),.writeData(regOut1), .clk(clk), .readDATAMEM(DMEMOUT), .counter(counter)); 
	

	
	
	//change wb
	
endmodule