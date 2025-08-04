module DATAMEM(
	input [31:0] ADDRESS,
	input writeValidate,
	input [31:0] writeData,
	input clk, 
	input [10:0] counter,
	output reg[31:0] readDATAMEM);
		
	
	reg[31:0] DATAM [1023:0];
	
	always@(posedge clk)begin
			if(writeValidate)begin
				DATAM[ADDRESS] <= writeData;
			end
	end	

	always@(negedge clk)begin
		if(counter <1056 && counter > 1024)begin
			
			readDATAMEM <= DATAM[ADDRESS];
		end
	end
	
endmodule 