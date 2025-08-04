module control(
	input[5:0] op,
	input [5:0] funct,
	input clk,
	output reg regdst,
	output reg ALUoperand,
	output reg WBDATA,
	output reg branch,
	output reg regWrite,
	output reg dataMemWrite,
	output reg[3:0] ALUControl);
	
	always@(*)begin
		regdst = !op[5];
		ALUoperand= op[5];
		WBDATA = (!op[2]) & (!op[5]);
		regWrite = !((op[5] & op[3]) | ((!op[5]) & op[2]) );
		dataMemWrite = op[5] & op[3];
		branch = (!op[5]) & op[2];
		if(op[5] || !op[5] && !op[2] && funct == 6'b100000)
			ALUControl = 4'b0010;
		if(!op[5] && op[2] || !op[5] && !op[2] && funct == 6'b100010)
			ALUControl = 4'b0110;
		if(!op[5] && op[2] || !op[5] && !op[2] && funct == 6'b100010)
			ALUControl = 4'b0110;
		if(!op[5] && !op[2] && funct == 6'b100100)
			ALUControl = 4'b0000;
		if(!op[5] && !op[2] && funct == 6'b100101)
			ALUControl = 4'b0001;
		if(!op[5] && !op[2] && funct == 6'b101010)
			ALUControl = 4'b0111;	

	end
	

endmodule