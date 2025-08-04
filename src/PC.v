module PC (
	input clk,
	input[9:0] newPC,
	input[10:0] counter,
	output reg[9:0] IFAddress);
	
	reg[9:0] currentAddress;
	initial begin
		currentAddress = 0;
	end
	
	always@(posedge clk)begin	
			
		if(counter <1056 && counter > 1024)begin
			currentAddress <= newPC;
		end
		
	end
	always@(negedge clk)begin
		IFAddress <= currentAddress;
	end 

endmodule
//write on posedge, reads on negedge