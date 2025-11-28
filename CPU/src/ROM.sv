module rom(input[7:0] addr, output logic[7:0] instruction);
logic[7:0] instr[0:255];

initial begin
    instr = '{default: 8'b0};
end

initial begin
$readmemh("program.hex", instr);
end

assign instruction = instr[addr];



// initial begin
//     instr[0] = 8'b0001_0110; //NOP(Nic nie robi)
//     instr[1] = 8'b0010_0110; //ADD R1 <- R1 + R2
//     instr[2] = 8'b0011_0110; //SUB R1 <- R1 - R2
//     instr[3] = 8'b0100_0110; //AND R1 <- R1 & R2
//     instr[4] = 8'b0101_0110; //OR  R1 <- R1 | R2
//     instr[5] = 8'b0110_0110; //MOV R1 <- R2
//     instr[6] = 8'b0111_0110; //LOAD R1 <- MEM[addr]
//     instr[7] = 8'b1000_0110; //STORE MEM[addr] <- R1
//     instr[8] = 8'b1001_0110; //JMP addr
//     instr[9] = 8'b1010_0110; // JZ addr if wynik = 0;
//     instr[10] = 8'b1011_0110; // JNS addr if wynik != 0;
//     instr[11] = 8'b1100_0110; // JN addr if ujemny
//     instr[12] = 8'b1101_0110; //HALT zatrzymanie programu
// end

endmodule