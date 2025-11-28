// module Calculator (input[3:0] A, input[3:0] B, input cin, output[3:0] sum, output cout);
    
//     assign {cout, sum} = A + B + cin; old code

    
    
// endmodule old code

module Calculator(input[3:0] A, input[3:0] B, [1:0] op, output logic[7:0] Y);

always @(*) begin
    case(op)
        2'b00: Y = A + B;
        2'b01: Y = A - B;
        2'b10: Y = A * B;
        2'b11: Y = A / B;
    endcase
end
endmodule
