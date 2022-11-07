module rec_cu(RxD_ready,clk,rst,ff1_Sel,ff1_load,FIR_strt);
input RxD_ready,clk,rst;
output reg ff1_Sel,ff1_load,FIR_strt;

reg [1:0]ns,ps;

parameter [2:0] idle=3'b000,
get_msb=3'b001,
get_lsb=3'b010,
input_valid=3'b011;
always@(posedge clk)begin
    if(rst)
        {ff1_Sel,ff1_load,FIR_strt,ns,ps}<=0;
    else begin
        ps<=ns;
    end
end
always@(*) begin
    case(ps)
    idle:ns=(RxD_ready==1'b1)?get_msb:idle;
    get_msb:ns=get_lsb;
    get_lsb:ns=(RxD_ready==1'b1)?input_valid:get_lsb;
    input_valid:ns=idle;
endcase
end
always@(posedge clk) begin
    {ff1_Sel,ff1_load,FIR_strt}=0;
    case(ps)
    get_msb:{ff1_Sel,ff1_load}=2'b11;
    get_lsb:{ff1_Sel,ff1_load}=2'b01;
    input_valid:{FIR_strt}=1'b1;
    endcase
end
endmodule