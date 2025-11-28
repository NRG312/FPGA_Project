module alu(input[7:0] A, input[7:0] B,input[7:0] alu_op,output logic Flag_Z, Flag_N, output logic[7:0] result);

parameter ADD = 8'b00000010;
parameter SUB = 8'b00000011;
parameter AND = 8'b00000100;
parameter OR = 8'b00000101;
parameter MOV = 8'b00000110;


always@(*) begin
case(alu_op)
    ADD:
        result = A + B;
    SUB:
        result = A - B;
    AND:
        result = A & B;
    OR:
        result = A | B;
    MOV:
        result = B;

endcase

//ustawienie flag
Flag_Z = (result == 8'b0); //Zero
Flag_N = result[7]; //MSB //Negative //jesli najstarszy bit 1 to ujemny
end
endmodule

//na pozniej na wszelki
// Przykładowy fragment ALU z wszystkimi flagami:
// always @(*) begin
//     case(op)
//         4'b0010: {carry_flag, result} = A + B;   // ADD
//         4'b0011: {carry_flag, result} = A - B;   // SUB
//     endcase

//     zero_flag = (result == 8'b0);
//     negative_flag = result[7];
//     overflow_flag = (A[7] == B[7]) && (result[7] != A[7]);
// end