module testbench();

reg[2:0] sel_ins;
reg[2:0] addr;
reg[1:0] sel_reg;
reg[1:0] save_Mode;
wire[7:0] data_out;
reg clk = 0;
cpu CPU(.sel_ins(sel_ins),.addr(addr),.sel_reg(sel_reg),.saveMode(save_Mode),.out(data_out));

initial begin
    forever #30 clk = ~clk;
end

initial begin
    sel_ins = 3'b001;
    addr = 3'b000;
    sel_reg = 2'b10;
    save_Mode = 2'b01;
    //
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    @(posedge clk);
    $display("Time=%0t | Data out = %b",$time, data_out);
    $finish;
end

endmodule