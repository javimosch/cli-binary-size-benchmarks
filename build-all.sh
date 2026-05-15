#!/bin/bash
# Master build script for all language boilerplates
# This builds Hello World in different languages and compares binary sizes

echo "=========================================="
echo "Building all language boilerplates..."
echo "=========================================="

# Build Go
echo ""
echo "=== Building Go ==="
cd boilerplate-go
chmod +x build.sh
./build.sh
cd ..

# Build Rust
echo ""
echo "=== Building Rust ==="
cd boilerplate-rust
chmod +x build.sh
./build.sh
cd ..

# Build Zig
echo ""
echo "=== Building Zig ==="
cd boilerplate-zig
chmod +x build.sh
./build.sh
cd ..

# Build C
echo ""
echo "=== Building C ==="
cd boilerplate-c
chmod +x build.sh
./build.sh
cd ..

echo ""
echo "=========================================="
echo "Binary Size Comparison"
echo "=========================================="

# Collect all built binaries
echo ""
echo "All binaries:"
echo ""

# Go binaries
if [ -f boilerplate-go/hello-go-default ]; then
    ls -lh boilerplate-go/hello-go-default
fi
if [ -f boilerplate-go/hello-go-optimized ]; then
    ls -lh boilerplate-go/hello-go-optimized
fi

# Rust binaries
if [ -f boilerplate-rust/hello-rust-default ]; then
    ls -lh boilerplate-rust/hello-rust-default
fi
if [ -f boilerplate-rust/hello-rust-stripped ]; then
    ls -lh boilerplate-rust/hello-rust-stripped
fi

# Zig binaries
if [ -f boilerplate-zig/hello-zig-debug ]; then
    ls -lh boilerplate-zig/hello-zig-debug
fi
if [ -f boilerplate-zig/hello-zig-release-fast ]; then
    ls -lh boilerplate-zig/hello-zig-release-fast
fi
if [ -f boilerplate-zig/hello-zig-release-safe ]; then
    ls -lh boilerplate-zig/hello-zig-release-safe
fi
if [ -f boilerplate-zig/hello-zig-release-small ]; then
    ls -lh boilerplate-zig/hello-zig-release-small
fi
if [ -f boilerplate-zig/hello-zig-release-small-stripped ]; then
    ls -lh boilerplate-zig/hello-zig-release-small-stripped
fi

# C binaries
if [ -f boilerplate-c/hello-c-default ]; then
    ls -lh boilerplate-c/hello-c-default
fi
if [ -f boilerplate-c/hello-c-o2 ]; then
    ls -lh boilerplate-c/hello-c-o2
fi
if [ -f boilerplate-c/hello-c-os ]; then
    ls -lh boilerplate-c/hello-c-os
fi
if [ -f boilerplate-c/hello-c-os-stripped ]; then
    ls -lh boilerplate-c/hello-c-os-stripped
fi
if [ -f boilerplate-c/hello-c-static ]; then
    ls -lh boilerplate-c/hello-c-static
fi

echo ""
echo "=========================================="
echo "Build complete!"
echo "=========================================="
