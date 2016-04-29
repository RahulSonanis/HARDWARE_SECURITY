 `timescale 1ns / 1ps

module tb;
    // Inputs
    reg [7:0] A;
    // Outputs
    wire [7:0] B;

    // Instantiate the Unit Under Test (UUT)
    sbox uut(
      .inp_block(A),
      .out_block(B)
    );

    initial begin
        // Apply Inputs
       
        A = 8'b00001110;
        #1000  
        $display ("A = %b && B = %b",A,B); 
    end  
       
endmodule
