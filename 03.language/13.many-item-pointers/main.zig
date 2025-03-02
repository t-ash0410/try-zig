const std = @import("std");

pub fn main() void {
    var buffer: [100]u8 = [_]u8{1} ** 100;
    std.debug.print("buffer: {any}\n", .{buffer}); // buffer: { 1, 1, 1, 1, 1, .... }

    const buffer_ptr: *[100]u8 = &buffer;
    const buffer_many_ptr: [*]u8 = buffer_ptr;
    const first_elem_ptr: *u8 = @ptrCast(buffer_many_ptr);
    std.debug.print("first_elem_ptr: {any}\n", .{first_elem_ptr}); // u8@7ff7bd612c78
}
