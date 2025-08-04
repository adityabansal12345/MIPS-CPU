module DATAMEM(
	input [31:0] out,
	input dataMemWrite,
	input [31:0] regOut2,
	input clk, 
	input [10:0] counter,
	output reg[31:0] readDATAMEM);
		
	
	reg[31:0] DATAM [1023:0];
	
	always@(posedge clk)begin
			if(dataMemWrite)begin
				DATAM[out] <= regOut2;
			end
	end	

	always@(negedge clk)begin
		if(counter <1056 && counter > 1024)begin
			
			readDATAMEM <= DATAM[out];
		end
	end
	
endmodule 