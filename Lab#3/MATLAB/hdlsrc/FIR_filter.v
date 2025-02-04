// -------------------------------------------------------------
//
// Module: FIR_filter
// Generated by MATLAB(R) 9.12 and Filter Design HDL Coder 3.1.11.
// Generated on: 2022-11-29 10:56:03
// -------------------------------------------------------------

// -------------------------------------------------------------
// HDL Code Generation Options:
//
// Name: FIR_filter
// SerialPartition: 64
// TargetLanguage: Verilog
// TestBenchStimulus: 
// TestBenchUserStimulus:  User data, length 240745
// ErrorMargin: 0

// -------------------------------------------------------------
// HDL Implementation    : Fully Serial
// Folding Factor        : 64
// -------------------------------------------------------------
// Filter Settings:
//
// Discrete-Time FIR Filter (real)
// -------------------------------
// Filter Structure  : Direct-Form FIR
// Filter Length     : 64
// Stable            : Yes
// Linear Phase      : Yes (Type 2)
// Arithmetic        : fixed
// Numerator         : s16,16 -> [-5.000000e-01 5.000000e-01)
// Input             : s24,23 -> [-1 1)
// Filter Internals  : Specify Precision
//   Output          : s32,30 -> [-2 2)
//   Product         : s31,31 -> [-5.000000e-01 5.000000e-01)
//   Accumulator     : s33,31 -> [-2 2)
//   Round Mode      : convergent
//   Overflow Mode   : wrap
// -------------------------------------------------------------




`timescale 1 ns / 1 ns

module FIR_filter
               (
                clk,
                clk_enable,
                reset,
                filter_in,
                filter_out
                );

  input   clk; 
  input   clk_enable; 
  input   reset; 
  input   signed [23:0] filter_in; //sfix24_En23
  output  signed [31:0] filter_out; //sfix32_En30

////////////////////////////////////////////////////////////////
//Module Architecture: FIR_filter
////////////////////////////////////////////////////////////////
  // Local Functions
  // Type Definitions
  // Constants
  parameter signed [15:0] coeff1 = 16'b1111111101111101; //sfix16_En16
  parameter signed [15:0] coeff2 = 16'b1111111010110101; //sfix16_En16
  parameter signed [15:0] coeff3 = 16'b1111110111011110; //sfix16_En16
  parameter signed [15:0] coeff4 = 16'b1111110101001101; //sfix16_En16
  parameter signed [15:0] coeff5 = 16'b1111110110011111; //sfix16_En16
  parameter signed [15:0] coeff6 = 16'b1111111011001111; //sfix16_En16
  parameter signed [15:0] coeff7 = 16'b0000000010001011; //sfix16_En16
  parameter signed [15:0] coeff8 = 16'b0000000111011001; //sfix16_En16
  parameter signed [15:0] coeff9 = 16'b0000001000000000; //sfix16_En16
  parameter signed [15:0] coeff10 = 16'b0000000010110101; //sfix16_En16
  parameter signed [15:0] coeff11 = 16'b1111111011000010; //sfix16_En16
  parameter signed [15:0] coeff12 = 16'b1111110101100011; //sfix16_En16
  parameter signed [15:0] coeff13 = 16'b1111110110111110; //sfix16_En16
  parameter signed [15:0] coeff14 = 16'b1111111111010011; //sfix16_En16
  parameter signed [15:0] coeff15 = 16'b0000001001110101; //sfix16_En16
  parameter signed [15:0] coeff16 = 16'b0000001110111111; //sfix16_En16
  parameter signed [15:0] coeff17 = 16'b0000001001111110; //sfix16_En16
  parameter signed [15:0] coeff18 = 16'b1111111100010011; //sfix16_En16
  parameter signed [15:0] coeff19 = 16'b1111101110100011; //sfix16_En16
  parameter signed [15:0] coeff20 = 16'b1111101010111101; //sfix16_En16
  parameter signed [15:0] coeff21 = 16'b1111110110101110; //sfix16_En16
  parameter signed [15:0] coeff22 = 16'b0000001100100000; //sfix16_En16
  parameter signed [15:0] coeff23 = 16'b0000011110010111; //sfix16_En16
  parameter signed [15:0] coeff24 = 16'b0000011101011010; //sfix16_En16
  parameter signed [15:0] coeff25 = 16'b0000000100110100; //sfix16_En16
  parameter signed [15:0] coeff26 = 16'b1111011111110000; //sfix16_En16
  parameter signed [15:0] coeff27 = 16'b1111000110100010; //sfix16_En16
  parameter signed [15:0] coeff28 = 16'b1111010010010011; //sfix16_En16
  parameter signed [15:0] coeff29 = 16'b0000001110000110; //sfix16_En16
  parameter signed [15:0] coeff30 = 16'b0001101101100010; //sfix16_En16
  parameter signed [15:0] coeff31 = 16'b0011001111101111; //sfix16_En16
  parameter signed [15:0] coeff32 = 16'b0100001101110101; //sfix16_En16
  parameter signed [15:0] coeff33 = 16'b0100001101110101; //sfix16_En16
  parameter signed [15:0] coeff34 = 16'b0011001111101111; //sfix16_En16
  parameter signed [15:0] coeff35 = 16'b0001101101100010; //sfix16_En16
  parameter signed [15:0] coeff36 = 16'b0000001110000110; //sfix16_En16
  parameter signed [15:0] coeff37 = 16'b1111010010010011; //sfix16_En16
  parameter signed [15:0] coeff38 = 16'b1111000110100010; //sfix16_En16
  parameter signed [15:0] coeff39 = 16'b1111011111110000; //sfix16_En16
  parameter signed [15:0] coeff40 = 16'b0000000100110100; //sfix16_En16
  parameter signed [15:0] coeff41 = 16'b0000011101011010; //sfix16_En16
  parameter signed [15:0] coeff42 = 16'b0000011110010111; //sfix16_En16
  parameter signed [15:0] coeff43 = 16'b0000001100100000; //sfix16_En16
  parameter signed [15:0] coeff44 = 16'b1111110110101110; //sfix16_En16
  parameter signed [15:0] coeff45 = 16'b1111101010111101; //sfix16_En16
  parameter signed [15:0] coeff46 = 16'b1111101110100011; //sfix16_En16
  parameter signed [15:0] coeff47 = 16'b1111111100010011; //sfix16_En16
  parameter signed [15:0] coeff48 = 16'b0000001001111110; //sfix16_En16
  parameter signed [15:0] coeff49 = 16'b0000001110111111; //sfix16_En16
  parameter signed [15:0] coeff50 = 16'b0000001001110101; //sfix16_En16
  parameter signed [15:0] coeff51 = 16'b1111111111010011; //sfix16_En16
  parameter signed [15:0] coeff52 = 16'b1111110110111110; //sfix16_En16
  parameter signed [15:0] coeff53 = 16'b1111110101100011; //sfix16_En16
  parameter signed [15:0] coeff54 = 16'b1111111011000010; //sfix16_En16
  parameter signed [15:0] coeff55 = 16'b0000000010110101; //sfix16_En16
  parameter signed [15:0] coeff56 = 16'b0000001000000000; //sfix16_En16
  parameter signed [15:0] coeff57 = 16'b0000000111011001; //sfix16_En16
  parameter signed [15:0] coeff58 = 16'b0000000010001011; //sfix16_En16
  parameter signed [15:0] coeff59 = 16'b1111111011001111; //sfix16_En16
  parameter signed [15:0] coeff60 = 16'b1111110110011111; //sfix16_En16
  parameter signed [15:0] coeff61 = 16'b1111110101001101; //sfix16_En16
  parameter signed [15:0] coeff62 = 16'b1111110111011110; //sfix16_En16
  parameter signed [15:0] coeff63 = 16'b1111111010110101; //sfix16_En16
  parameter signed [15:0] coeff64 = 16'b1111111101111101; //sfix16_En16

  // Signals
  reg  [5:0] cur_count; // ufix6
  wire phase_63; // boolean
  wire phase_0; // boolean
  reg  signed [23:0] delay_pipeline [0:63] ; // sfix24_En23
  wire signed [23:0] inputmux_1; // sfix24_En23
  reg  signed [32:0] acc_final; // sfix33_En31
  reg  signed [32:0] acc_out_1; // sfix33_En31
  wire signed [30:0] product_1; // sfix31_En31
  wire signed [15:0] product_1_mux; // sfix16_En16
  wire signed [39:0] mul_temp; // sfix40_En39
  wire signed [32:0] prod_typeconvert_1; // sfix33_En31
  wire signed [32:0] acc_sum_1; // sfix33_En31
  wire signed [32:0] acc_in_1; // sfix33_En31
  wire signed [32:0] add_signext; // sfix33_En31
  wire signed [32:0] add_signext_1; // sfix33_En31
  wire signed [33:0] add_temp; // sfix34_En31
  wire signed [31:0] output_typeconvert; // sfix32_En30
  reg  signed [31:0] output_register; // sfix32_En30

  // Block Statements
  always @ (posedge clk or posedge reset)
    begin: Counter_process
      if (reset == 1'b1) begin
        cur_count <= 6'b111111;
      end
      else begin
        if (clk_enable == 1'b1) begin
          if (cur_count >= 6'b111111) begin
            cur_count <= 6'b000000;
          end
          else begin
            cur_count <= cur_count + 6'b000001;
          end
        end
      end
    end // Counter_process

  assign  phase_63 = (cur_count == 6'b111111 && clk_enable == 1'b1) ? 1'b1 : 1'b0;

  assign  phase_0 = (cur_count == 6'b000000 && clk_enable == 1'b1) ? 1'b1 : 1'b0;

  always @( posedge clk or posedge reset)
    begin: Delay_Pipeline_process
      if (reset == 1'b1) begin
        delay_pipeline[0] <= 0;
        delay_pipeline[1] <= 0;
        delay_pipeline[2] <= 0;
        delay_pipeline[3] <= 0;
        delay_pipeline[4] <= 0;
        delay_pipeline[5] <= 0;
        delay_pipeline[6] <= 0;
        delay_pipeline[7] <= 0;
        delay_pipeline[8] <= 0;
        delay_pipeline[9] <= 0;
        delay_pipeline[10] <= 0;
        delay_pipeline[11] <= 0;
        delay_pipeline[12] <= 0;
        delay_pipeline[13] <= 0;
        delay_pipeline[14] <= 0;
        delay_pipeline[15] <= 0;
        delay_pipeline[16] <= 0;
        delay_pipeline[17] <= 0;
        delay_pipeline[18] <= 0;
        delay_pipeline[19] <= 0;
        delay_pipeline[20] <= 0;
        delay_pipeline[21] <= 0;
        delay_pipeline[22] <= 0;
        delay_pipeline[23] <= 0;
        delay_pipeline[24] <= 0;
        delay_pipeline[25] <= 0;
        delay_pipeline[26] <= 0;
        delay_pipeline[27] <= 0;
        delay_pipeline[28] <= 0;
        delay_pipeline[29] <= 0;
        delay_pipeline[30] <= 0;
        delay_pipeline[31] <= 0;
        delay_pipeline[32] <= 0;
        delay_pipeline[33] <= 0;
        delay_pipeline[34] <= 0;
        delay_pipeline[35] <= 0;
        delay_pipeline[36] <= 0;
        delay_pipeline[37] <= 0;
        delay_pipeline[38] <= 0;
        delay_pipeline[39] <= 0;
        delay_pipeline[40] <= 0;
        delay_pipeline[41] <= 0;
        delay_pipeline[42] <= 0;
        delay_pipeline[43] <= 0;
        delay_pipeline[44] <= 0;
        delay_pipeline[45] <= 0;
        delay_pipeline[46] <= 0;
        delay_pipeline[47] <= 0;
        delay_pipeline[48] <= 0;
        delay_pipeline[49] <= 0;
        delay_pipeline[50] <= 0;
        delay_pipeline[51] <= 0;
        delay_pipeline[52] <= 0;
        delay_pipeline[53] <= 0;
        delay_pipeline[54] <= 0;
        delay_pipeline[55] <= 0;
        delay_pipeline[56] <= 0;
        delay_pipeline[57] <= 0;
        delay_pipeline[58] <= 0;
        delay_pipeline[59] <= 0;
        delay_pipeline[60] <= 0;
        delay_pipeline[61] <= 0;
        delay_pipeline[62] <= 0;
        delay_pipeline[63] <= 0;
      end
      else begin
        if (phase_63 == 1'b1) begin
          delay_pipeline[0] <= filter_in;
          delay_pipeline[1] <= delay_pipeline[0];
          delay_pipeline[2] <= delay_pipeline[1];
          delay_pipeline[3] <= delay_pipeline[2];
          delay_pipeline[4] <= delay_pipeline[3];
          delay_pipeline[5] <= delay_pipeline[4];
          delay_pipeline[6] <= delay_pipeline[5];
          delay_pipeline[7] <= delay_pipeline[6];
          delay_pipeline[8] <= delay_pipeline[7];
          delay_pipeline[9] <= delay_pipeline[8];
          delay_pipeline[10] <= delay_pipeline[9];
          delay_pipeline[11] <= delay_pipeline[10];
          delay_pipeline[12] <= delay_pipeline[11];
          delay_pipeline[13] <= delay_pipeline[12];
          delay_pipeline[14] <= delay_pipeline[13];
          delay_pipeline[15] <= delay_pipeline[14];
          delay_pipeline[16] <= delay_pipeline[15];
          delay_pipeline[17] <= delay_pipeline[16];
          delay_pipeline[18] <= delay_pipeline[17];
          delay_pipeline[19] <= delay_pipeline[18];
          delay_pipeline[20] <= delay_pipeline[19];
          delay_pipeline[21] <= delay_pipeline[20];
          delay_pipeline[22] <= delay_pipeline[21];
          delay_pipeline[23] <= delay_pipeline[22];
          delay_pipeline[24] <= delay_pipeline[23];
          delay_pipeline[25] <= delay_pipeline[24];
          delay_pipeline[26] <= delay_pipeline[25];
          delay_pipeline[27] <= delay_pipeline[26];
          delay_pipeline[28] <= delay_pipeline[27];
          delay_pipeline[29] <= delay_pipeline[28];
          delay_pipeline[30] <= delay_pipeline[29];
          delay_pipeline[31] <= delay_pipeline[30];
          delay_pipeline[32] <= delay_pipeline[31];
          delay_pipeline[33] <= delay_pipeline[32];
          delay_pipeline[34] <= delay_pipeline[33];
          delay_pipeline[35] <= delay_pipeline[34];
          delay_pipeline[36] <= delay_pipeline[35];
          delay_pipeline[37] <= delay_pipeline[36];
          delay_pipeline[38] <= delay_pipeline[37];
          delay_pipeline[39] <= delay_pipeline[38];
          delay_pipeline[40] <= delay_pipeline[39];
          delay_pipeline[41] <= delay_pipeline[40];
          delay_pipeline[42] <= delay_pipeline[41];
          delay_pipeline[43] <= delay_pipeline[42];
          delay_pipeline[44] <= delay_pipeline[43];
          delay_pipeline[45] <= delay_pipeline[44];
          delay_pipeline[46] <= delay_pipeline[45];
          delay_pipeline[47] <= delay_pipeline[46];
          delay_pipeline[48] <= delay_pipeline[47];
          delay_pipeline[49] <= delay_pipeline[48];
          delay_pipeline[50] <= delay_pipeline[49];
          delay_pipeline[51] <= delay_pipeline[50];
          delay_pipeline[52] <= delay_pipeline[51];
          delay_pipeline[53] <= delay_pipeline[52];
          delay_pipeline[54] <= delay_pipeline[53];
          delay_pipeline[55] <= delay_pipeline[54];
          delay_pipeline[56] <= delay_pipeline[55];
          delay_pipeline[57] <= delay_pipeline[56];
          delay_pipeline[58] <= delay_pipeline[57];
          delay_pipeline[59] <= delay_pipeline[58];
          delay_pipeline[60] <= delay_pipeline[59];
          delay_pipeline[61] <= delay_pipeline[60];
          delay_pipeline[62] <= delay_pipeline[61];
          delay_pipeline[63] <= delay_pipeline[62];
        end
      end
    end // Delay_Pipeline_process


  assign inputmux_1 = (cur_count == 6'b000000) ? delay_pipeline[0] :
                     (cur_count == 6'b000001) ? delay_pipeline[1] :
                     (cur_count == 6'b000010) ? delay_pipeline[2] :
                     (cur_count == 6'b000011) ? delay_pipeline[3] :
                     (cur_count == 6'b000100) ? delay_pipeline[4] :
                     (cur_count == 6'b000101) ? delay_pipeline[5] :
                     (cur_count == 6'b000110) ? delay_pipeline[6] :
                     (cur_count == 6'b000111) ? delay_pipeline[7] :
                     (cur_count == 6'b001000) ? delay_pipeline[8] :
                     (cur_count == 6'b001001) ? delay_pipeline[9] :
                     (cur_count == 6'b001010) ? delay_pipeline[10] :
                     (cur_count == 6'b001011) ? delay_pipeline[11] :
                     (cur_count == 6'b001100) ? delay_pipeline[12] :
                     (cur_count == 6'b001101) ? delay_pipeline[13] :
                     (cur_count == 6'b001110) ? delay_pipeline[14] :
                     (cur_count == 6'b001111) ? delay_pipeline[15] :
                     (cur_count == 6'b010000) ? delay_pipeline[16] :
                     (cur_count == 6'b010001) ? delay_pipeline[17] :
                     (cur_count == 6'b010010) ? delay_pipeline[18] :
                     (cur_count == 6'b010011) ? delay_pipeline[19] :
                     (cur_count == 6'b010100) ? delay_pipeline[20] :
                     (cur_count == 6'b010101) ? delay_pipeline[21] :
                     (cur_count == 6'b010110) ? delay_pipeline[22] :
                     (cur_count == 6'b010111) ? delay_pipeline[23] :
                     (cur_count == 6'b011000) ? delay_pipeline[24] :
                     (cur_count == 6'b011001) ? delay_pipeline[25] :
                     (cur_count == 6'b011010) ? delay_pipeline[26] :
                     (cur_count == 6'b011011) ? delay_pipeline[27] :
                     (cur_count == 6'b011100) ? delay_pipeline[28] :
                     (cur_count == 6'b011101) ? delay_pipeline[29] :
                     (cur_count == 6'b011110) ? delay_pipeline[30] :
                     (cur_count == 6'b011111) ? delay_pipeline[31] :
                     (cur_count == 6'b100000) ? delay_pipeline[32] :
                     (cur_count == 6'b100001) ? delay_pipeline[33] :
                     (cur_count == 6'b100010) ? delay_pipeline[34] :
                     (cur_count == 6'b100011) ? delay_pipeline[35] :
                     (cur_count == 6'b100100) ? delay_pipeline[36] :
                     (cur_count == 6'b100101) ? delay_pipeline[37] :
                     (cur_count == 6'b100110) ? delay_pipeline[38] :
                     (cur_count == 6'b100111) ? delay_pipeline[39] :
                     (cur_count == 6'b101000) ? delay_pipeline[40] :
                     (cur_count == 6'b101001) ? delay_pipeline[41] :
                     (cur_count == 6'b101010) ? delay_pipeline[42] :
                     (cur_count == 6'b101011) ? delay_pipeline[43] :
                     (cur_count == 6'b101100) ? delay_pipeline[44] :
                     (cur_count == 6'b101101) ? delay_pipeline[45] :
                     (cur_count == 6'b101110) ? delay_pipeline[46] :
                     (cur_count == 6'b101111) ? delay_pipeline[47] :
                     (cur_count == 6'b110000) ? delay_pipeline[48] :
                     (cur_count == 6'b110001) ? delay_pipeline[49] :
                     (cur_count == 6'b110010) ? delay_pipeline[50] :
                     (cur_count == 6'b110011) ? delay_pipeline[51] :
                     (cur_count == 6'b110100) ? delay_pipeline[52] :
                     (cur_count == 6'b110101) ? delay_pipeline[53] :
                     (cur_count == 6'b110110) ? delay_pipeline[54] :
                     (cur_count == 6'b110111) ? delay_pipeline[55] :
                     (cur_count == 6'b111000) ? delay_pipeline[56] :
                     (cur_count == 6'b111001) ? delay_pipeline[57] :
                     (cur_count == 6'b111010) ? delay_pipeline[58] :
                     (cur_count == 6'b111011) ? delay_pipeline[59] :
                     (cur_count == 6'b111100) ? delay_pipeline[60] :
                     (cur_count == 6'b111101) ? delay_pipeline[61] :
                     (cur_count == 6'b111110) ? delay_pipeline[62] :
                     delay_pipeline[63];

  //   ------------------ Serial partition # 1 ------------------

  assign product_1_mux = (cur_count == 6'b000000) ? coeff1 :
                        (cur_count == 6'b000001) ? coeff2 :
                        (cur_count == 6'b000010) ? coeff3 :
                        (cur_count == 6'b000011) ? coeff4 :
                        (cur_count == 6'b000100) ? coeff5 :
                        (cur_count == 6'b000101) ? coeff6 :
                        (cur_count == 6'b000110) ? coeff7 :
                        (cur_count == 6'b000111) ? coeff8 :
                        (cur_count == 6'b001000) ? coeff9 :
                        (cur_count == 6'b001001) ? coeff10 :
                        (cur_count == 6'b001010) ? coeff11 :
                        (cur_count == 6'b001011) ? coeff12 :
                        (cur_count == 6'b001100) ? coeff13 :
                        (cur_count == 6'b001101) ? coeff14 :
                        (cur_count == 6'b001110) ? coeff15 :
                        (cur_count == 6'b001111) ? coeff16 :
                        (cur_count == 6'b010000) ? coeff17 :
                        (cur_count == 6'b010001) ? coeff18 :
                        (cur_count == 6'b010010) ? coeff19 :
                        (cur_count == 6'b010011) ? coeff20 :
                        (cur_count == 6'b010100) ? coeff21 :
                        (cur_count == 6'b010101) ? coeff22 :
                        (cur_count == 6'b010110) ? coeff23 :
                        (cur_count == 6'b010111) ? coeff24 :
                        (cur_count == 6'b011000) ? coeff25 :
                        (cur_count == 6'b011001) ? coeff26 :
                        (cur_count == 6'b011010) ? coeff27 :
                        (cur_count == 6'b011011) ? coeff28 :
                        (cur_count == 6'b011100) ? coeff29 :
                        (cur_count == 6'b011101) ? coeff30 :
                        (cur_count == 6'b011110) ? coeff31 :
                        (cur_count == 6'b011111) ? coeff32 :
                        (cur_count == 6'b100000) ? coeff33 :
                        (cur_count == 6'b100001) ? coeff34 :
                        (cur_count == 6'b100010) ? coeff35 :
                        (cur_count == 6'b100011) ? coeff36 :
                        (cur_count == 6'b100100) ? coeff37 :
                        (cur_count == 6'b100101) ? coeff38 :
                        (cur_count == 6'b100110) ? coeff39 :
                        (cur_count == 6'b100111) ? coeff40 :
                        (cur_count == 6'b101000) ? coeff41 :
                        (cur_count == 6'b101001) ? coeff42 :
                        (cur_count == 6'b101010) ? coeff43 :
                        (cur_count == 6'b101011) ? coeff44 :
                        (cur_count == 6'b101100) ? coeff45 :
                        (cur_count == 6'b101101) ? coeff46 :
                        (cur_count == 6'b101110) ? coeff47 :
                        (cur_count == 6'b101111) ? coeff48 :
                        (cur_count == 6'b110000) ? coeff49 :
                        (cur_count == 6'b110001) ? coeff50 :
                        (cur_count == 6'b110010) ? coeff51 :
                        (cur_count == 6'b110011) ? coeff52 :
                        (cur_count == 6'b110100) ? coeff53 :
                        (cur_count == 6'b110101) ? coeff54 :
                        (cur_count == 6'b110110) ? coeff55 :
                        (cur_count == 6'b110111) ? coeff56 :
                        (cur_count == 6'b111000) ? coeff57 :
                        (cur_count == 6'b111001) ? coeff58 :
                        (cur_count == 6'b111010) ? coeff59 :
                        (cur_count == 6'b111011) ? coeff60 :
                        (cur_count == 6'b111100) ? coeff61 :
                        (cur_count == 6'b111101) ? coeff62 :
                        (cur_count == 6'b111110) ? coeff63 :
                        coeff64;
  assign mul_temp = inputmux_1 * product_1_mux;
  assign product_1 = (mul_temp[38:0] + {mul_temp[8], {7{~mul_temp[8]}}})>>>8;

  assign prod_typeconvert_1 = $signed({{2{product_1[30]}}, product_1});

  assign add_signext = prod_typeconvert_1;
  assign add_signext_1 = acc_out_1;
  assign add_temp = add_signext + add_signext_1;
  assign acc_sum_1 = add_temp[32:0];

  assign acc_in_1 = (phase_0 == 1'b1) ? prod_typeconvert_1 :
                   acc_sum_1;

  always @ (posedge clk or posedge reset)
    begin: Acc_reg_1_process
      if (reset == 1'b1) begin
        acc_out_1 <= 0;
      end
      else begin
        if (clk_enable == 1'b1) begin
          acc_out_1 <= acc_in_1;
        end
      end
    end // Acc_reg_1_process

  always @ (posedge clk or posedge reset)
    begin: Finalsum_reg_process
      if (reset == 1'b1) begin
        acc_final <= 0;
      end
      else begin
        if (phase_0 == 1'b1) begin
          acc_final <= acc_out_1;
        end
      end
    end // Finalsum_reg_process

  assign output_typeconvert = (acc_final[32:0] + acc_final[1])>>>1;

  always @ (posedge clk or posedge reset)
    begin: Output_Register_process
      if (reset == 1'b1) begin
        output_register <= 0;
      end
      else begin
        if (phase_63 == 1'b1) begin
          output_register <= output_typeconvert;
        end
      end
    end // Output_Register_process

  // Assignment Statements
  assign filter_out = output_register;
endmodule  // FIR_filter
