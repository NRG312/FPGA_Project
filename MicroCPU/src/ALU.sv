module alu(input[1:0] alu_op, input[7:0] R1, input[7:0] R2, output logic[7:0] result);

parameter ADD = 2'b01;
parameter SUB = 2'b10;

always@(*) begin
    
    case(alu_op)
        2'b01: result = R1 + R2;
        2'b10: result = R1 - R2;
    endcase
end
endmodule