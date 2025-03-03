const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe_name = b.option(
        []const u8,
        "exe_name",
        "Name of the executable",
    ) orelse "hello";

    const exe = b.addExecutable(.{
        .name = exe_name,
        .root_source_file = b.path("src/main.zig"),
        .target = b.standardTargetOptions(.{}),
        .optimize = b.standardOptimizeOption(.{}),
    });

    b.installArtifact(exe);

    const run_exe = b.addRunArtifact(exe);

    const run_step = b.step("run", "Run the application");
    run_step.dependOn(&run_exe.step);
}
