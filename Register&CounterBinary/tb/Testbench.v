module testbench;

//counter binary
wire[3:0] counter;
reg clkCount = 0;
reg resetCou = 1;
//register
reg[7:0] D = 8'b0;
wire[7:0] Q;
reg clkReg = 0;
reg resetReg = 1;

always #10 clkReg = ~clkReg;
always #30 clkCount = ~clkCount;


counterBinary testCount(.counter(counter), .clk(clkCount), .reset(resetCou));

Register testReg(.D(D),.Q(Q),.clk(clkReg),.reset(resetReg));

// initial begin
//     #30 resetCou = 0;
//     #500 $finish;
// end

// initial begin 
//     $monitor("Time - %0t ns, counter = %b",$time ,counter);
// end
// Counter binary wyzej

initial begin
    #15 resetReg = 0;
end

initial begin

    $monitor("Q = %b", Q);
    #30 D = 8'b01100010;

    #500 $finish;

end

endmodule