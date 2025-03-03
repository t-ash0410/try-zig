const std = @import("std");
const bufPrint = std.fmt.bufPrint;
const expectEqualStrings = std.testing.expectEqualStrings;

test "hex" {
    var b: [10]u8 = undefined;

    try expectEqualStrings(
        "FFFFFFFE",
        try bufPrint(&b, "{X}", .{4294967294}),
    );
    try expectEqualStrings(
        "fffffffe",
        try bufPrint(&b, "{x}", .{4294967294}),
    );
    try expectEqualStrings(
        "0xAAAAAAAA",
        try bufPrint(&b, "0x{X}", .{2863311530}),
    );
    try expectEqualStrings(
        "5a696721",
        try bufPrint(&b, "{}", .{
            std.fmt.fmtSliceHexLower("Zig!"),
        }),
    );
}

test "decimal float" {
    var b: [4]u8 = undefined;
    try expectEqualStrings("16.5", try bufPrint(
        &b,
        "{d}",
        .{16.5},
    ));
}

test "ascii fmt" {
    var b: [1]u8 = undefined;
    try expectEqualStrings("B", try bufPrint(
        &b,
        "{c}",
        .{66},
    ));
}

const fmtIntSizeDec = std.fmt.fmtIntSizeDec;
const fmtIntSizeBin = std.fmt.fmtIntSizeBin;

test "B Bi" {
    var b: [32]u8 = undefined;

    try expectEqualStrings("1B", try bufPrint(&b, "{}", .{fmtIntSizeDec(1)}));
    try expectEqualStrings("1B", try bufPrint(&b, "{}", .{fmtIntSizeBin(1)}));

    try expectEqualStrings("1.024kB", try bufPrint(&b, "{}", .{fmtIntSizeDec(1024)}));
    try expectEqualStrings("1KiB", try bufPrint(&b, "{}", .{fmtIntSizeBin(1024)}));

    try expectEqualStrings(
        "1.073741824GB",
        try bufPrint(&b, "{}", .{fmtIntSizeDec(1024 * 1024 * 1024)}),
    );
    try expectEqualStrings(
        "1GiB",
        try bufPrint(&b, "{}", .{fmtIntSizeBin(1024 * 1024 * 1024)}),
    );
}

test "binary, octal fmt" {
    var b: [8]u8 = undefined;

    try expectEqualStrings(
        "11111110",
        try bufPrint(&b, "{b}", .{254}),
    );
    try expectEqualStrings(
        "376",
        try bufPrint(&b, "{o}", .{254}),
    );
}

test "pointer fmt" {
    var b: [16]u8 = undefined;

    try expectEqualStrings(
        "u8@deadbeef",
        try bufPrint(&b, "{*}", .{@as(*u8, @ptrFromInt(0xDEADBEEF))}),
    );
}

test "scientific" {
    var b: [16]u8 = undefined;

    try expectEqualStrings(
        try bufPrint(&b, "{e}", .{3.14159}),
        "3.14159e0",
    );
}

test "string fmt" {
    var b: [6]u8 = undefined;
    const hello: [*:0]const u8 = "hello!";

    try expectEqualStrings(
        "hello!",
        try bufPrint(&b, "{s}", .{hello}),
    );
}
