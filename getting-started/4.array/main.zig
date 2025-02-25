const std = @import("std");

const a = [5]u8{ 1, 2, 3, 4, 5 };
const b = [_]u8{ 1, 2, 3, 4, 5 };
// const c = []u8{ 1, 2, 3, 4, 5 }; // Build error: expected type '[_]u8', found '[]u8'

const array = [_]u8{ 'h', 'e', 'l', 'l', 'o' };
// const array = [_]u8{ "h", "e", "l", "l", "o" }; // Build error: expected type 'u8', found '*const [1:0]u8'
const length = array.len;

pub fn main() void {
    std.debug.print("Hello, {s}: {d}!\n", .{ "a[0]", a[0] }); // Hello, a[0]: 1!
    std.debug.print("Hello, {s}: {d}!\n", .{ "b[0]", b[0] }); // Hello, b[0]: 1!
    std.debug.print("Hello, {s}: {d}!\n", .{ "array[0]", array[0] }); // Hello, array[0]: 104!
    std.debug.print("Hello, {s}: {c}!\n", .{ "array[0]", array[0] }); // Hello, array[0]: h!
    std.debug.print("Hello, {s}: {any}!\n", .{ "array", array }); // Hello, array: { 104, 101, 108, 108, 111 }!
    std.debug.print("Hello, {s}: {s}!\n", .{ "array", array }); // Hello, array: hello!
    std.debug.print("Hello, {s}: {d}!\n", .{ "length", length }); // Hello, length: 5!
}
