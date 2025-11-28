module testbench;

// reg[3:0] A;
// reg[3:0] B;
// reg cin;
// wire[3:0] sum;
// wire cout;

// Calculator alu(.A(A),.B(B),.cin(cin),.sum(sum),.cout(cout));

// initial begin
    
//     $monitor("A = %b B = %b | sum = %b" ,A,B,sum);
//     $monitor("A = %d" ,A);
//     $monitor("A = %h" ,A);

//     //wektory testowe
//     #0 A = 4'b0110; B = 4'b1010; cin = 0;
//     #10 A = 4'b1111; B = 4'b1110; cin = 0;
//     #10 A = 4'b0101; B = 4'b0001; cin = 1;
//     #10 $finish;
// end    old code

reg[3:0] A;
reg[3:0] B;
reg[1:0] op;
wire[7:0] Y;

Calculator alu(.A(A),.B(B),.op(op),.Y(Y));

initial begin

    $monitor("Y = %b", Y);

    A = 4; B = 2;

    op = 2'b00; #10; //dodawanie
    op = 2'b01; #10; //odejmowanie
    op = 2'b10; #10; //mnozenie
    op = 2'b11; #10; //dzielenie
    $finish;
end
endmodule


//# A = 0110 B = 1010 | sum = 0000    takie bylo wyjscie przelicz sobie i zobacz przeniesienia itp
//# A = 1111 B = 1110 | sum = 1101
//# A = 0101 B = 0001 | sum = 0111