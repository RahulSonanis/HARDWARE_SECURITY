`timescale 1ns / 1ps

module inverse_in_4_2(element,inverse_element);
  // gamma_0 = element[3:0] gamma_1 = element[7:4]
  input [7:0] element;
  output [7:0] inverse_element;

  wire[3:0] tau = 4'b0001;
  wire[3:0] mu = 4'b1001;
  wire[3:0] temporary, temporary_tau, mu_squared_gamma_1, addition_1, first_addition, inverse_first_addition;
  wire[3:0] gamma_1_tau, second_addition;
  wire[3:0] delta_0, delta_1;
  wire[3:0] squared_gamma_0, squared_gamma_1;

  //////////////////////////////////////////////////////////////////////
  square_mapping_4 s1(element[3:0], squared_gamma_0);
  square_mapping_4 s2(element[7:4], squared_gamma_1); 
  multiplication_in_4 m1(element[3:0],element[7:4],temporary);
  multiplication_in_4 m2(temporary,tau,temporary_tau);
  multiplication_in_4 m3(squared_gamma_1,mu, mu_squared_gamma_1);
  addition_in_4 add1(squared_gamma_0,temporary_tau,addition_1);
  addition_in_4 add2(addition_1,mu_squared_gamma_1,first_addition);
  inverse_mapping_4 inv1(first_addition,inverse_first_addition);
  multiplication_in_4 m4(tau,element[7:4],gamma_1_tau);
  addition_in_4 add3(element[3:0], gamma_1_tau, second_addition); 
  multiplication_in_4 m5(inverse_first_addition,second_addition,inverse_element[3:0]);
  /////////////////////////////////////////////////////////////////////////
  multiplication_in_4 m6(inverse_first_addition,element[7:4],inverse_element[7:4]);
  
  //////////////////////////////////////////////////////////////////////////

endmodule 