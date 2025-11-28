module Halfadder (input A,B,
                    output carry,sum);

    assign sum = A ^ B;
    assign carry = A & B;
    
endmodule