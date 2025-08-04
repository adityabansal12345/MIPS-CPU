module display(
	input clk,
	output reg[7:0] ones,
	output reg[7:0] tens);
	wire [31:0] value;
	datapath u9 (.clk(clk), .value(value));
	reg[3:0] units;
	reg[3:0] tens1;

	function [7:0] decode_7seg;
			input[5:0] val;
			begin
				case(val)
					4'd0: decode_7seg = 7'b0000001;
                	4'd1: decode_7seg = 7'b1001111;
                	4'd2: decode_7seg = 7'b0010010;
                	4'd3: decode_7seg = 7'b0000110;
                	4'd4: decode_7seg = 7'b1001100;
                	4'd5: decode_7seg = 7'b0100100;
                	4'd6: decode_7seg = 7'b0100000;
                	4'd7: decode_7seg = 7'b0001111;
                	4'd8: decode_7seg = 7'b0000000;
                	4'd9: decode_7seg = 7'b0000100;
                	default: decode_7seg = 7'b1111111;  // all off
				endcase
			end
	endfunction
	always@(*)begin
		units = value % 10;
		tens1 = value%100/ 10;
	
		ones= ~decode_7seg(units);
		tens = ~decode_7seg(tens1);
		end	

endmodule

//when writing code
// use 32 bits of 1 to set end of code
// use 32 bits of 0 to indicate that the value of the instruction before is the thing that you want to set.
// there are some registers preset in the register file, change those.

	