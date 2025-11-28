module counterBinary(output logic[3:0] counter, input clk, input reset);

always_ff @(posedge clk or posedge reset) begin
    if(reset) begin
        counter <= 0;
    end else begin
        counter <= counter + 1;
    end

end


endmodule