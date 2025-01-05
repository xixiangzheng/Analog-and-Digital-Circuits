module MAX3 (
    input   [7:0]         num1, num2, num3,
    output  [7:0]         max
);
// Your codes should start from here.

wire [7:0] max1;

MAX2 max2_1 (
    .num1(num1),
    .num2(num2),
    .max(max1)
);

MAX2 max2_2 (
    .num1(max1),
    .num2(num3),
    .max(max)
);

// End of your codes.
endmodule