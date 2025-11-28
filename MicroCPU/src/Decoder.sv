module decoder(input[3:0] opcode, output logic[1:0] alu_op, output logic reg_write, output logic reg_read, output logic mem_write, output logic mem_read);

parameter ADD = 2'b01;
parameter SUB = 2'b10;

always@(*) begin
    case(opcode)
        4'b0001: begin
            reg_write = 0;
            reg_read = 0;
            mem_write = 1;
            mem_read = 1;
            alu_op = ADD;
        end
        4'b0010: begin
            reg_write = 1;
            reg_read = 1;
            mem_write = 0;
            mem_read = 0;
            alu_op = SUB;
        end
    endcase
end
endmodule


//PRZYPOMINAJKA
//jesli zmienne znajduja sie poza blokiem proceduralnym jak(always,intial,assign)
//to musze przypisac assign do zmiennej ajk wyzej bo jest tylko w case(przypisanie ciagle kombinacyjne)
//jesli jest np w always to jest przypisanie proceduralne