const expect = @import("std").testing.expect;

const SomeError = error{Error};

fn switchStatement(x: i8) SomeError!i8 {
    switch (x) {
        -1...1 => {
            return -x;
        },
        10, 100 => {
            return @divExact(x, 10);
        },
        else => {
            return SomeError.Error;
        },
    }
}

test "switch statement" {
    const x: i8 = 10;
    const y = try switchStatement(x);
    try expect(y == 1);
}

test "switch statement 2" {
    const x: i8 = 1;
    const y = try switchStatement(x);
    try expect(y == -1);
}

test "switch statement 3" {
    const x: i8 = 0;
    const y = try switchStatement(x);
    try expect(y == 0);
}

test "switch statement 4" {
    const x: i8 = 101;
    const y = switchStatement(x) catch |err| {
        try expect(err == SomeError.Error);
        return;
    };
    try expect(y == 0); // is never reached
}

test "switch expression" {
    var x: i8 = 10;
    x = switch (x) {
        -1...1 => -x,
        10, 100 => @divExact(x, 10),
        else => x,
    };
    try expect(x == 1);
}
