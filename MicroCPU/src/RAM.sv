module Ram(input logic[2:0] addr, input logic[7:0] data_in, input logic clk, input logic write_enable, output logic[7:0] data_out);

logic[7:0] mem[0:7]; //8 komorek po 8 bity
 initial begin
    integer i;
    for (i = 0; i < 8 ; i = i + 1) begin
        mem[i] = 8'b00;
    end
 end
always @(posedge clk) begin
    if (write_enable) begin
        mem[addr] <= data_in; //zapis
    end
end
always_comb
    data_out = mem[addr]; //odczyt 

endmodule