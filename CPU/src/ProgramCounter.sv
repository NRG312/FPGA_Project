module programCounter(input clk,input halted, input reset, input jump/*skok bezwarunkowy*/, input[2:0] jump_addr,input jump_Z/*skok jesli zero*/,input flag_Z/*flaga z ALU*/, output logic[7:0] pc);

initial begin
    pc = 8'b0;
end

always @(posedge clk or posedge reset) begin
    if(!halted) begin
    if (reset) begin
        pc <= 8'b0;
    end else if(jump) begin
        pc <= jump_addr;
    end else if(jump_Z && flag_Z) begin
        pc <= jump_addr;
    end else begin
        pc <= pc + 1'b1;
    end
    end
end


endmodule