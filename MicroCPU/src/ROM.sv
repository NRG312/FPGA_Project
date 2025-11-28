module rom(input[1:0] bits, output logic[7:0] out);
logic[7:0] memory[0:7]; //8 instrukcji po 8 bitow
initial begin
    memory[0] = 8'b0001_0110; //ADD R1,R2
    memory[1] = 8'b0010_1001; //SUB R2,R2
end
    assign out = memory[bits]; //tutaj wybierana instrukcja podajac bits
endmodule



//opcode czyli 0000RRRR  4 zera to beda odpowiadac za instrukcje czyli np ADD 0001 itp/ RRRR to rejestry ktore beda pobierane z procka i wysylane do alu
//memory[0][3:0] memory jest 8 bitowe out jest 4 bitowy to uwzglednia sie 4 najmlodsze bity czyli 3:0