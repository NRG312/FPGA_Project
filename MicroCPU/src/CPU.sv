module cpu(input[1:0] sel_prog, input[1:0] sel_reg, input clk, output logic[7:0] out);

logic[7:0] R[0:3]; //4 rejestry 8 bitowe // [0:3] kolejnosc indeksowania tablicy
logic[7:0] instruction;
logic[3:0] op_code;
always_comb op_code = instruction[7:4];
logic[1:0] alu_op;

//ALU
logic[7:0] A;//R1        
logic[7:0] B;//R2
logic[7:0] result;
//ROM
logic reg_read_c,reg_write_c,mem_read_c,mem_write_c;
logic reg_read,reg_write,mem_read,mem_write;
//RAM
reg[2:0] addr = 3'b000;
reg[7:0] data_in;
wire[7:0] data_out;
reg write_enable = 0;
//CPU
logic write_pending = 0;

//
rom ROM(.bits(sel_prog),.out(instruction));
Ram RAM(.addr(addr), .data_in(data_in), .clk(clk),.write_enable(write_enable),.data_out(data_out));
decoder Decoder(.opcode(op_code), .alu_op(alu_op),.reg_write(reg_write), .reg_read(reg_read), .mem_write(mem_write), .mem_read(mem_read));
alu ALU(.alu_op(alu_op), .R1(A), .R2(B), .result(result));

initial begin
    R[0] = 8'b00000001;
    R[1] = 8'b00000010;
    R[2] = 8'b00000011;
    R[3] = 8'b00000100;
end

always_comb begin
    if(^instruction !== 1'bX) begin //jesli w instruction jest X to nie wykona sie if
        A = R[instruction[3:2]]; //R1
        B = R[instruction[1:0]]; //R2
    end else begin
        A = 8'b0;
        B = 8'b0;
    end
end

always @(*) begin //sa 4 rejestry 8 bitowe
out = 0;//trzeba wywolac aby wyzerwoac reszte zmiennych nizej

    case (sel_reg)
        2'b00: out = R[0];
        2'b01: out = R[1];
        2'b10: out = R[2];
        2'b11: out = R[3];
    endcase
end
  
always @(posedge clk) begin
    reg_read_c <= reg_read;
    reg_write_c <= reg_write;
    mem_read_c <= mem_read;
    mem_write_c <= mem_write;

    if(mem_write_c && mem_read_c && write_pending == 0) begin
        addr <= 3'b000;
        data_in <= result;
        write_pending <= 1;
    end else if(write_pending) begin
        write_enable <= 1;
        write_pending <= 0;
    end else begin
        write_enable <= 0;
    end

    if(reg_read_c && reg_write_c) begin
        R[1] <= result;
    end else if(write_enable) begin
        R[1] <= data_out;
    end
    end

//zaleznosc pomiedzy <= i = w <= musi przejsc kilka cykli aby wszystkie wartosci w nich sie zapisaly i przeszly dalej(brak pipline), samo = to przypisanie natychmiastowe(kombinacyjne)
endmodule