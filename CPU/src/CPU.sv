module cpu(output logic[7:0] out);
    
logic[7:0] opcode;
logic[7:0] alu_op;
logic clk = 0;
logic resetCycle;
//ALU
logic[7:0] result;
//decoder
logic reg_write_c;
logic ram_write_c;
logic reg_write;
logic ram_write;
//Program counter
logic reset = 0;
logic jump = 0;
logic[2:0] jump_addr = 3'b0;
logic jump_Z = 0;
//Ram
logic[7:0] data_in;
logic[7:0] data_out;
logic push;
logic pop;
//Stop program
logic halted = 0;
//Main registers
logic flag_Z, flag_N;
logic[7:0] R[0:3];
logic[7:0] pc;//Program counter
logic[7:0] instruction;
logic[1:0] dest;//R1
logic[1:0] src;//R2
logic[2:0] addr;//adress RAM
logic[2:0] SP;//Stack Pointer

//przyklad dest src(0001_0110) opcode 0001, dest 01 czyli R1, src 10 czyli R2

//skonczylem na tym ze rozszerzylem instrukcje do 16 bitow w cpu i decoderze teraz dodac musze instrukcje jmp i przejsc do koljnego zadania
// musze sprawdzic jak rozszrzyc opcode bo nie mam juz miejsca na wiecej instrukcji
//musze dodac do decodera nowe instrukcje i jmp(moze przerobie i zamiast uzywac 12 bitow na instrukcje do 2 ostatnie beda adresem do RAM jesli bede uzyuwal w instrukcji)
// ogarnac modul CPU dla nowych zmiennych od jmp do program countera
//nma koncu test
initial begin
    #10;
    clk = 0;
    forever #30 clk = ~clk;
end
initial begin //testowe zatrzymanie
    #1000 $finish;
end
initial begin
    R[0] = 8'b00000001;
    R[1] = 8'b00000010;
    R[2] = 8'b00000011;
    R[3] = 8'b00000100;
end

rom ROM(.addr(pc),.instruction(instruction));
programCounter ProgramCounter(.clk(clk),.halted(halted),.reset(reset),.jump(jump),.jump_addr(jump_addr),.jump_Z(jump_Z),.flag_Z(flag_Z),.pc(pc));
alu ALU(.A(R[src]),.B(R[dest]),.alu_op(alu_op),.Flag_Z(flag_z),.Flag_N(flag_N),.result(result));
decoder Decoder(.opcode(opcode),.alu_op(alu_op),.reg_write(reg_write),.ram_write(ram_write));
ram RAM(.addr(addr),.clk(clk),.data_in(data_in),.data_out(data_out));

always @(*) begin
    case(src)
    2'b00: out = R[0];
    2'b01: out = R[1];
    2'b10: out = R[2];
    2'b11: out = R[3];
    endcase
end

always_comb begin
    opcode = instruction[15:4]; //Rodzaj operacji

    //domyślnie ustaw
    src = instruction[3:2];//rejestr docelowy(np R1)
    dest = instruction[1:0];//rejestr źródłowy(np R2)
    addr = instruction[2:0];//adres RAM
end

always @(posedge clk) begin

    if(!halted) begin
    reg_write_c <= reg_write;
    ram_write_c <= ram_write;

    if(reg_write_c && ram_write_c == 0) begin
        R[2] <= result;
        resetCycle <= 1;

        if(resetCycle) begin
            reg_write_c <= 0;
            ram_write_c <= 0;
            resetCycle <= 0;
        end
    end else if(ram_write_c && reg_write_c == 0) begin
        data_in <= result;
        out <= data_out;

        resetCycle <= 1;
        if(resetCycle) begin
            reg_write_c <= 0;
            ram_write_c <= 0;
            resetCycle <= 0;
        end
    end
    end
    if(opcode == 4'b1101) begin
        halted <= 1;
    end
end

endmodule

// Cykl działania w skrócie:

// 1️⃣ PC = 0 → ROM daje instrukcję z adresu 0
// 2️⃣ CPU dekoduje instrukcję (opcode = instruction[7:4])
// 3️⃣ Decoder ustawia sygnały (reg_write, ram_write, itp.)
// 4️⃣ ALU wykonuje operację
// 5️⃣ Po zakończeniu, Program Counter zwiększa się (pc = pc + 1)
// 6️⃣ ROM daje następną instrukcję
// 7️⃣ Powtarzaj, aż dojdzie HALT → halted = 1 → PC przestaje się zwiększać