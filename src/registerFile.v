module registerFile(
	input[4:0] reg1,
	input clk,
	input[4:0] reg2,
	input[4:0] wb,
	input[31:0] wbValue,
	input regWrite,
	input [10:0] counter,
	output reg[31:0] regOut1,
	output reg[31:0] regOut2);
	
	integer i;
	reg[31:0] regFile [31:0];
	initial begin
		for(i = 0; i<32; i= i+1)begin
			regFile[i] = 32'b0;			
		end	
		regFile[1] = 1'b1;
		regFile[6] = 1'b1;
		regFile[5] = 2'b10;
	end
	always@(posedge clk)begin
			if(counter <1056 && counter > 1024)begin
				if(regWrite)begin		
					regFile[wb] <= wbValue;
				end
		end
	end

	always@(negedge clk)begin
		
		regOut1 <= regFile[reg1];//check if the address is being used in binary or decimal
		regOut2 <= regFile[reg2];
		
		
	end
	
endmodule