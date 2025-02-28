const expect = @import("std").testing.expect;

test "float widening" {
    const a: f16 = 0;
    const b: f32 = a;
    const c: f128 = b;
    try expect(c == @as(f128, a));
}

const floating_point: f64 = 123.0E+77;
const another_float: f64 = 123.0;
const yet_another: f64 = 123.0e+77;

const hex_floating_point: f64 = 0x103.70p-5;
const another_hex_float: f64 = 0x103.70;
const yet_another_hex_float: f64 = 0x103.70P-5;

const light_speed: f64 = 299_792_458.000_000;
const nano_second: f64 = 0.000_000_001;
const more_hex: f64 = 0x1234_5678.9ABC_CDEFp-10;

test "int-float conversion" {
    const a: i32 = 0;
    const b = @as(f32, @floatFromInt(a));
    const c = @as(i32, @intFromFloat(b));
    try expect(c == a);
}

test "int-float conversion 2" {
    const a = @as(i32, @intFromFloat(1.9));
    try expect(a == 1);
}
