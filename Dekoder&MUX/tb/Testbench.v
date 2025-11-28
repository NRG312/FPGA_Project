module testbench;

//decoder var
reg[1:0] A;
wire[3:0] O;

//MUX var
reg[1:0] S;
reg[3:0] D;
wire Y;

decoder Dec(.A(A),.O(O));
mux Mux(.S(S),.D(D),.Y(Y));

// initial begin

//     $monitor("O = %b", O);
//     A = 2'b10;

//     #500 $finish; //tutaj skonczylem i dziala wszystko

// end

initial begin

    $monitor("D = %b | Y = %b",D,Y);
    S = 2'b01;
    D = 4'b0100;

    #500 $finish;
end

endmodule