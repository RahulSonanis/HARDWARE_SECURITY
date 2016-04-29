`timescale 1ns / 1ps

module sbox(inp_block,out_block);   
    input [7:0] inp_block;

    output [7:0] out_block;

    wire [7:0] transform_block;
    wire [7:0] inverse_block;
    wire [7:0] temp_block;
     
    transform_8_to_4_2 t1(inp_block[7:0],transform_block[7:0]);
    inverse_in_4_2 i1(transform_block[7:0],inverse_block[7:0]);    
	 inverse_transform_4_2_to_8 it1(inverse_block[7:0],temp_block[7:0]);
    affine_transform a1(temp_block[7:0],out_block[7:0]);
    //inverse_transform_4_2_to_8 it1(temp_block[7:0],out_block[7:0]);
     
     /*
    transform_8_to_4_2 t2(inp_block[15:8],transform_block[15:8]);
    inverse_in_4_2 i2(transform_block[15:8],inverse_block[15:8]);
    affine_transform a2(inverse_block[15:8],temp_block[15:8]);
    inverse_transform_4_2_to_8 it2(temp_block[15:8],out_block[15:8]);
    

    transform_8_to_4_2 t3(inp_block[23:16],transform_block[23:16]);
    inverse_in_4_2 i3(transform_block[23:16],inverse_block[23:16]);
    affine_transform a3(inverse_block[23:16],temp_block[23:16]);
    inverse_transform_4_2_to_8 it3(temp_block[23:16],out_block[23:16]);
    

    transform_8_to_4_2 t4(inp_block[31:24],transform_block[31:24]);
    inverse_in_4_2 i4(transform_block[31:24],inverse_block[31:24]);
    affine_transform a4(inverse_block[31:24],temp_block[31:24]);
    inverse_transform_4_2_to_8 it4(temp_block[31:24],out_block[31:24]);
    

    transform_8_to_4_2 t5(inp_block[39:32],transform_block[39:32]);
    inverse_in_4_2 i5(transform_block[39:32],inverse_block[39:32]);
    affine_transform a5(inverse_block[39:32],temp_block[39:32]);
    inverse_transform_4_2_to_8 it5(temp_block[39:32],out_block[39:32]);
    

    transform_8_to_4_2 t6(inp_block[47:40],transform_block[47:40]);
    inverse_in_4_2 i6(transform_block[47:40],inverse_block[47:40]);
    affine_transform a6(inverse_block[47:40],temp_block[47:40]);
    inverse_transform_4_2_to_8 it6(temp_block[47:40],out_block[47:40]);
    

    transform_8_to_4_2 t7(inp_block[55:48],transform_block[55:48]);
    inverse_in_4_2 i7(transform_block[55:48],inverse_block[55:48]);
    affine_transform a7(inverse_block[55:48],temp_block[55:48]);
    inverse_transform_4_2_to_8 it7(temp_block[55:48],out_block[55:48]);
    

    transform_8_to_4_2 t8(inp_block[63:56],transform_block[63:56]);
    inverse_in_4_2 i8(transform_block[63:56],inverse_block[63:56]);
    affine_transform a8(inverse_block[63:56],temp_block[63:56]);
    inverse_transform_4_2_to_8 it8(temp_block[63:56],out_block[63:56]);
    

    transform_8_to_4_2 t9(inp_block[71:64],transform_block[71:64]);
    inverse_in_4_2 i9(transform_block[71:64],inverse_block[71:64]);
    affine_transform a9(inverse_block[71:64],temp_block[71:64]);
    inverse_transform_4_2_to_8 it9(temp_block[71:64],out_block[71:64]);
    

    transform_8_to_4_2 t10(inp_block[79:72],transform_block[79:72]);
    inverse_in_4_2 i10(transform_block[79:72],inverse_block[79:72]);
    affine_transform a10(inverse_block[79:72],temp_block[79:72]);
    inverse_transform_4_2_to_8 it10(temp_block[79:72],out_block[79:72]);
    

    transform_8_to_4_2 t11(inp_block[87:80],transform_block[87:80]);
    inverse_in_4_2 i11(transform_block[87:80],inverse_block[87:80]);
    affine_transform a11(inverse_block[87:80],temp_block[87:80]);
    inverse_transform_4_2_to_8 it11(temp_block[87:80],out_block[87:80]);
    

    transform_8_to_4_2 t12(inp_block[95:88],transform_block[95:88]);
    inverse_in_4_2 i12(transform_block[95:88],inverse_block[95:88]);
    affine_transform a12(inverse_block[95:88],temp_block[95:88]);
    inverse_transform_4_2_to_8 it12(temp_block[95:88],out_block[95:88]);
    

    transform_8_to_4_2 t13(inp_block[103:96],transform_block[103:96]);
    inverse_in_4_2 i13(transform_block[103:96],inverse_block[103:96]);
    affine_transform a13(inverse_block[103:96],temp_block[103:96]);
    inverse_transform_4_2_to_8 it13(temp_block[103:96],out_block[103:96]);
    

    transform_8_to_4_2 t14(inp_block[111:104],transform_block[111:104]);
    inverse_in_4_2 i14(transform_block[111:104],inverse_block[111:104]);
     affine_transform a14(inverse_block[111:104],temp_block[111:104]);
    inverse_transform_4_2_to_8 it14(temp_block[111:104],out_block[111:104]);
    

    transform_8_to_4_2 t15(inp_block[119:112],transform_block[119:112]);
    inverse_in_4_2 i15(transform_block[119:112],inverse_block[119:112]);
     affine_transform a15(inverse_block[119:112],temp_block[119:112]);
    inverse_transform_4_2_to_8 it15(temp_block[119:112],out_block[119:112]);
    

    transform_8_to_4_2 t16(inp_block[127:120],transform_block[127:120]);
    inverse_in_4_2 i16(transform_block[127:120],inverse_block[127:120]);
     affine_transform a16(inverse_block[127:120],temp_block[127:120]);
    inverse_transform_4_2_to_8 it16(temp_block[127:120],out_block[127:120]);
     */
endmodule 