`timescale 1ns / 1ps

module square_mapping_4(element, square_element);
  input [3:0] element;
  output [3:0] square_element;
  reg [3:0] square_element_;
	 
  always @(*)
    begin
      case (element)
        4'b0000:  square_element_ = 4'b0000;
        4'b0001:  square_element_ = 4'b0001;
        4'b0010:  square_element_ = 4'b0100;
        4'b0011:  square_element_ = 4'b0101;
        4'b0100:  square_element_ = 4'b0011;
        4'b0101:  square_element_ = 4'b0010;
        4'b0110:  square_element_ = 4'b0111;
        4'b0111:  square_element_ = 4'b0110;
        4'b1000:  square_element_ = 4'b1100;
        4'b1001:  square_element_ = 4'b1101;
        4'b1010:  square_element_ = 4'b1000;
        4'b1011:  square_element_ = 4'b1001;
        4'b1100:  square_element_ = 4'b1111;
        4'b1101:  square_element_ = 4'b1110;
        4'b1110:  square_element_ = 4'b1011;
        4'b1111:  square_element_ = 4'b1010; 
      endcase
    end
	 
	 assign square_element = square_element_;
	 
endmodule 