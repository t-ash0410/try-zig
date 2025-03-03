const std = @import("std");
const bufPrint = std.fmt.bufPrint;
const expectEqualStrings = std.testing.expectEqualStrings;

test "position" {
    var b: [3]u8 = undefined;

    try expectEqualStrings(
        "aab",
        try bufPrint(&b, "{0s}{0s}{1s}", .{ "a", "b" }),
    );
}

test "fill, alignment, width" {
    var b: [6]u8 = undefined;

    try expectEqualStrings(
        "hi!  ",
        try bufPrint(&b, "{s: <5}", .{"hi!"}),
    );
    try expectEqualStrings(
        "_hi!__",
        try bufPrint(&b, "{s:_^6}", .{"hi!"}),
    );
    try expectEqualStrings(
        "!hi!",
        try bufPrint(&b, "{s:!>4}", .{"hi!"}),
    );
    try expectEqualStrings(
        "hi!",
        try bufPrint(&b, "{s:!>3}", .{"hi!"}),
    );
}

test "precision" {
    var b: [4]u8 = undefined;

    try expectEqualStrings(
        "3.14",
        try bufPrint(&b, "{d:.2}", .{3.14159}),
    );
}
