module ALU (
	input [3:0] ALUOP,
	input [31:0] operand1,
	input [31:0] operand2,
	input clk, 
	output reg [31:0] out,
	output reg zero);
	
	always@(*)begin

		case(ALUOP)
			4'b0010: out = operand1 + operand2;
			4'b0110: out= operand1 - operand2;
			4'b0000: out = operand1 & operand2;
			4'b0001: out = operand1 | operand2;
			4'b0111: begin
						if(operand1 - operand2 > 0)begin
							out = 0;
						end else begin
							out = 1;
						end		
					 end	
			default: out = 0;
		endcase
		if(out == 0)
			zero = 1;
		else 
			zero = 0;

	end

endmodule