`timescale 1ns / 1ps

module affine_transform(in,out);

    input [7:0] in;
    output [7:0] out;
    reg [7:0] X;
    reg [7:0] Y;
    integer i,j;

    reg [0:7] A [0:7];   

	 //reg [7:0] B = 8'b11000110;
	 reg [7:0] B = 8'b01100011;
		
    initial begin
				
				A[0] = 8'b10001111;
				A[1] = 8'b11000111;
				A[2] = 8'b11100011;
				A[3] = 8'b11110001;
				A[4] = 8'b11111000;
				A[5] = 8'b01111100;
				A[6] = 8'b00111110;
				A[7] = 8'b00011111;
				
    end


    always @(*) 
    begin 
	     X = in;	 
        Y = 0;
		  
        // AX
		  
        for(i = 0 ; i < 8 ; i=i+1) 
        begin
            for(j = 0 ; j < 8 ; j=j+1) 
            begin
              //  $display("A[i][j] = %b && X[j] = %b",A[i][j],X[j]);
                //Y[i] = Y[i] ^ (A[i][j] & X[j]);
					 Y[i] = Y[i] ^ (A[i][j] & X[j]);
               // $display("Y[i] = %b",Y[i]);
            end
          // $display("Final Y[i] = %b\n\n",Y[i]);
        end

        // AX + B
        for(i=0 ; i < 8 ; i=i+1)
        begin
            Y[i] = Y[i] ^ B[i];
        end 
          //out = Y;
    end
     assign out = Y;
     
endmodule
