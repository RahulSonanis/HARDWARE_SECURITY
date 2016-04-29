`timescale 1ns / 1ps

module inverse_mapping_4(element, inverse_element);
  input [3:0] element;
  output [3:0] inverse_element;
  reg [3:0] inverse_element_;
  
  always @(*)
    begin
    
      case (element)
        4'b0000:  inverse_element_ = 4'b0000;
        4'b0001:  inverse_element_ = 4'b0001;
        4'b0010:  inverse_element_ = 4'b1001;
        4'b0011:  inverse_element_ = 4'b1110;
        4'b0100:  inverse_element_ = 4'b1101;
        4'b0101:  inverse_element_ = 4'b1011;
        4'b0110:  inverse_element_ = 4'b0111;
        4'b0111:  inverse_element_ = 4'b0110;
        4'b1000:  inverse_element_ = 4'b1111;
        4'b1001:  inverse_element_ = 4'b0010;
        4'b1010:  inverse_element_ = 4'b1100;
        4'b1011:  inverse_element_ = 4'b0101;
        4'b1100:  inverse_element_ = 4'b1010;
        4'b1101:  inverse_element_ = 4'b0100;
        4'b1110:  inverse_element_ = 4'b0011;
        4'b1111:  inverse_element_ = 4'b1000;
      endcase
    end
   
   assign inverse_element = inverse_element_;
   
endmodule 