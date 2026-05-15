#!/bin/bash
# Build Zig Hello World - Debug
zig build-exe main.zig -femit-bin=hello-zig-debug
ls -lh hello-zig-debug

# Build Zig Hello World - ReleaseFast
zig build-exe main.zig -femit-bin=hello-zig-release-fast -O ReleaseFast
ls -lh hello-zig-release-fast

# Build Zig Hello World - ReleaseSafe
zig build-exe main.zig -femit-bin=hello-zig-release-safe -O ReleaseSafe
ls -lh hello-zig-release-safe

# Build Zig Hello World - ReleaseSmall (optimized for size)
zig build-exe main.zig -femit-bin=hello-zig-release-small -O ReleaseSmall
ls -lh hello-zig-release-small

# Build Zig Hello World - ReleaseSmall + Strip
zig build-exe main.zig -femit-bin=hello-zig-release-small-stripped -O ReleaseSmall
strip hello-zig-release-small-stripped
ls -lh hello-zig-release-small-stripped
