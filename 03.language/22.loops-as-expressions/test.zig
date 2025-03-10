const expect = @import("std").testing.expect;

fn rangeHasNumber(begin: usize, end: usize, number: usize) bool {
    var i = begin;
    return while (i < end) : (i += 1) {
        if (i == number) {
            break true;
        }
    } else false;
}

test "while loop expression (fail)" {
    try expect(rangeHasNumber(0, 10, 13));
}

test "while loop expression (success)" {
    try expect(rangeHasNumber(0, 15, 13));
}
