module decoder(input[7:0] opcode,output logic[7:0] alu_op, output logic reg_write, output logic ram_write);

parameter NOP = 8'b00000001;
parameter ADD = 8'b00000010;
parameter SUB = 8'b00000011;
parameter AND = 8'b00000100;
parameter OR = 8'b00000101;
parameter MOVE = 8'b00000111;
parameter LOAD = 8'b00001000;
parameter STORE = 8'b00001001;
parameter PUSH = 8'b00001011;
parameter POP = 8'b00001100;
parameter HALT = 8'b00001101;

//musze dodac jeszcze jmp itp nie dodalem ich i potrzebne beda zmienne by potem program counter wiedzial ze jest jmp itp
always@(*) begin
    alu_op = NOP;
    reg_write = 0;
    ram_write = 0;
    case(opcode)
        8'b00000001: begin
        reg_write = 0;
        ram_write = 0; 
        end
        8'b00000010: begin
        alu_op = ADD;
        reg_write = 1;
        ram_write = 0; 
        end
        8'b00000011: begin
        alu_op = SUB;
        reg_write = 1;
        ram_write = 0; 
        end
        8'b00000100: begin
        alu_op = AND;
        reg_write = 1;
        ram_write = 0; 
        end
        8'b00000101: begin
        alu_op = OR;
        reg_write = 1;
        ram_write = 0; 
        end
        8'b00000111: begin
        alu_op = MOVE;
        reg_write = 1;
        ram_write = 0; 
        end
        8'b00001000: begin //LOAD
        reg_write = 1;
        ram_write = 0;  
        end
        8'b00001001: begin //STORE
        reg_write = 0;
        ram_write = 1;
        end
        8'b00001011: begin //PUSH
        reg_write = 0;
        ram_write = 1; 
        end
        8'b00001100: begin //POP
        reg_write = 1;
        ram_write = 0; 
        end
        8'b00001101: begin //HALT
        reg_write = 0;
        ram_write = 0; 
        end
        //sposob 2
        // ADD: alu_op = ADD; itp;

    endcase
end
endmodule