`timescale 1ns / 1ps

module multiplication_in_4(A,B,out);
  input [3:0] A, B;
  output [3:0] out;
  reg [3:0] out_;
  
  always @(*)
    begin
      out_[3] = A[3]*B[0] ^ A[2]*B[1] ^ A[1]*B[2] ^ A[0]*B[3] ^ A[3]*B[3];
      out_[2] = A[3]*B[3] ^ A[3]*B[2] ^ A[2]*B[3] ^ A[2]*B[0] ^ A[1]*B[1] ^ A[0]*B[2];
      out_[1] = A[3]*B[2] ^ A[2]*B[3] ^ A[3]*B[1] ^ A[2]*B[2] ^ A[1]*B[3] ^ A[1]*B[0] ^ A[0]*B[1];
      out_[0] = A[0]*B[0] ^ A[3]*B[1] ^ A[2]*B[2] ^ A[1]*B[3];
    end
  assign out = out_;

endmodule 