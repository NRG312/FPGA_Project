module testbench;

reg A, B;
wire sum,carry;

Halfadder alu(.A(A),.B(B),.carry(carry),.sum(sum));

initial begin
    $monitor("A=%b B=%b | sum=%b carry=%b", A, B, sum, carry);

    A = 0; B = 1; #10;
    $finish;
end

endmodule