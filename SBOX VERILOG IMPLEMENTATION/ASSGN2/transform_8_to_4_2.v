`timescale 1ns / 1ps

module transform_8_to_4_2(in,out);
    input [7:0] in;
    output [7:0] out;
    reg [7:0] A1;
    reg [7:0] B1;
    integer i,j;

    reg [0:7] T [0:7];
  
    initial begin
        T[0]  = 8'b10100000;
        T[1]  = 8'b10101100;
        T[2]  = 8'b11010010;
        T[3]  = 8'b01110000;
        T[4]  = 8'b11000110;
        T[5]  = 8'b01010010;
        T[6]  = 8'b00001010;
        T[7]  = 8'b11011101;
    end
     
    always @(*)
    begin      
        A1 = in;
        B1 = 0;
        for(i = 0 ; i < 8 ; i=i+1) 
        begin 
            for(j = 0 ; j < 8 ; j=j+1) 
            begin
              //$display("T[i][j] = %b && A1[j] = %b",T[i][j],A1[j]);
                B1[7-i] = B1[7-i] ^ (T[i][j] & A1[7-j]);
              // $display("B1[i] = %b",B1[i]);
            end
            //$display("Final B1[i] = %b\n\n",B1[i]);
        end
    end
     assign out = B1;

endmodule 