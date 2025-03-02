const print = @import("std").debug.print;
const testing = @import("std").testing;

const FileOpenError = error{
    AccessDenied,
    OutOfMemory,
    FileNotFound,
};

const AllocationError = error{OutOfMemory};

test "coerce error from a subset to a superset" {
    const err: FileOpenError = AllocationError.OutOfMemory;
    try testing.expect(err == FileOpenError.OutOfMemory);
}

test "error union" {
    const maybe_error: AllocationError!u16 = 10;
    const no_error: u16 = maybe_error catch 0;
    try testing.expect(@TypeOf(no_error) == u16);
    try testing.expect(no_error == 10);
}

test "error union 2" {
    const maybe_error: AllocationError!u16 = AllocationError.OutOfMemory;
    const yes_error: u16 = maybe_error catch 0;
    try testing.expect(@TypeOf(yes_error) == u16);
    try testing.expect(yes_error == 0);
}

test "error union 3" {
    const maybe_error: AllocationError!u16 = AllocationError.OutOfMemory;
    const yes_error = maybe_error catch 0;
    try testing.expect(@TypeOf(yes_error) == comptime_int);
    try testing.expect(yes_error == 0);
}

fn failingFunction() error{Oops}!void {
    return error.Oops;
}

test "returning an error" {
    failingFunction() catch |err| {
        try testing.expect(err == error.Oops);
        return;
    };
}

fn failFn() error{Oops}!i32 {
    try failingFunction();
    return 12;
}

test "try" {
    const v = failFn() catch |err| {
        try testing.expect(err == error.Oops);
        return;
    };
    try testing.expect(v == 12); // is never reached
}

var problems: u32 = 98;

fn failFnCounter() error{Oops}!void {
    errdefer problems += 1;
    try failingFunction();
}

test "errdefer" {
    failFnCounter() catch |err| {
        try testing.expect(err == error.Oops);
        try testing.expect(problems == 99);
        return;
    };
}

fn createFile() !void {
    return error.AccessDenied;
}

test "inferred error set" {
    // type coercion successfully takes place
    const x: error{AccessDenied}!void = createFile();

    // Zig does not let us ignore error unions via _ = x;
    // we must unwrap it with "try", "catch", or "if" by any means
    _ = x catch {};
}

test "inferred error set 2" {
    // type coercion successfully takes place
    const x: error{AccessDenied}!void = createFile();

    // Zig does not let us ignore error unions via _ = x;
    // we must unwrap it with "try", "catch", or "if" by any means
    x catch |err| {
        try testing.expect(err == error.AccessDenied);
    };
}

const A = error{ NotDir, PathNotFound };
const B = error{ OutOfMemory, PathNotFound };
const C = A || B;
