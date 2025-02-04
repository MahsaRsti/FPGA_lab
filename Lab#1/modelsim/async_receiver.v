module async_receiver(
  rst,
  clk,
  RxD,
  RxD_data_ready,
  RxD_data  // data received, valid only (for one clock cycle) when RxD_data_ready is asserted
);
  input rst, clk, RxD;
  output reg RxD_data_ready;
  output reg [7:0] RxD_data = 0;

  parameter ClkFrequency = 50000000;
  parameter Baud = 115200;
  parameter Oversampling = 4;  // needs to be a power of 2

  ////////////////////////////////
  //place your code here
  wire RxDTick, RxD_busy;
  reg [1:0] count = 0;
  reg [3:0] RxD_state = 0;
  BaudTickGen #(ClkFrequency, Baud, Oversampling) tickgen(.clk(clk), .enable(RxD_busy), .tick(RxDTick));

  assign RxD_busy = ~RxD_data_ready;

  always @(posedge clk) begin
    RxD_data_ready <= 1'b0;
    if(rst) begin RxD_data_ready <= 1'b0; RxD_state <= 4'b0000; RxD_data <= 0; end
    else begin
      if(count == Oversampling) begin count <= 0; end

      if(RxDTick & count < Oversampling) begin count <= count + 1; end
      if(RxDTick & count == Oversampling / 2 - 1) begin
        case(RxD_state)
          4'b0000: begin if(!RxD) RxD_state <= 4'b0010; RxD_data_ready <= 1'b0; end  // start bit
          4'b0010:  begin RxD_state <= 4'b0011; RxD_data[0] <= RxD; end // bit 0
          4'b0011:  begin RxD_state <= 4'b0100; RxD_data[1] <= RxD; end // bit 1
          4'b0100:  begin RxD_state <= 4'b0101; RxD_data[2] <= RxD; end // bit 2
          4'b0101:  begin RxD_state <= 4'b0110; RxD_data[3] <= RxD; end // bit 3
          4'b0110:  begin RxD_state <= 4'b0111; RxD_data[4] <= RxD; end // bit 4
          4'b0111:  begin RxD_state <= 4'b1000; RxD_data[5] <= RxD; end // bit 5
          4'b1000:  begin RxD_state <= 4'b1001; RxD_data[6] <= RxD; end // bit 6
          4'b1001:  begin RxD_state <= 4'b1010; RxD_data[7] <= RxD; end // bit 7
          4'b1010:  begin RxD_state <= 4'b0000; RxD_data_ready <= 1'b1; end  // data ready
          default: RxD_state <= 4'b0000;
        endcase  
      end
    end
  end
  ////////////////////////////////
endmodule