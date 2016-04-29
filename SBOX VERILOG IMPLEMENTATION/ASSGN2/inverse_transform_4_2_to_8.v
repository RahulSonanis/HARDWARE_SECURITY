`timescale 1ns / 1ps

module inverse_transform_4_2_to_8(in,out);
    input [7:0] in;
    output [7:0] out;

    reg [7:0] A1;
    reg [7:0] B1;

    integer i,j;

    reg [0:7] invT [0:7];

    initial begin
        invT[0] = 8'b00100100;
        invT[1] = 8'b11101110;
        invT[2] = 8'b10100100;
        invT[3] = 8'b01011010;
        invT[4] = 8'b10110010;
        invT[5] = 8'b01110010;
        invT[6] = 8'b10110000;
        invT[7] = 8'b01010001;
    end

    always @(*) 
    begin      
        A1 = in;
        B1 = 0;
        for(i = 0 ; i < 8 ; i=i+1) 
        begin
            for(j = 0 ; j < 8 ; j=j+1) 
            begin
              // $display("invT[i][j] = %b && A1[j] = %b",invT[i][j],A1[j]);
              // B1[i] = B1[i] ^ (invT[i][j] & A1[j]);
				  B1[7-i] = B1[7-i] ^ (invT[i][j] & A1[7-j]);
              // $display("B1[i] = %b",B1[i]);
            end
         // $display("Final B1[i] = %b\n\n",B1[i]);
        end
       // out=B1;
    end
     assign out = B1;
     
endmodule 