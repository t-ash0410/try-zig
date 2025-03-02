const constant: i32 = 2;
var variable: i32 = 5000;

const inferred_constant = @as(i32, 5);
var inferred_variable = @as(i32, 5000);

const undefined_constant: i32 = undefined;
var undefined_variable: i32 = undefined;
