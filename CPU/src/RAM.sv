module ram(input[2:0] addr,input clk, input[7:0] data_in, output logic[7:0] data_out);

logic[7:0] memory[0:15];

initial begin//test dla assemblera
    memory[0] = 2;
    memory[1] = 3;
end

always @(posedge clk) begin
    memory[addr] <= data_in;
    data_out <= data_in;
end

endmodule