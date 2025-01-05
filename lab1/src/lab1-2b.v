module MAX3 (
    input       [7:0]         num1, num2, num3,
    output reg  [7:0]         max
);
// Your codes should start from here.

always @(*) begin
    if (num1 > num2)
        max = num1;
    else 
        max = num2;
        
    if (max < num3)
        max = num3;
end

// End of your codes.
endmodule