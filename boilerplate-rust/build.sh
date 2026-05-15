#!/bin/bash
# Build Rust Hello World - Default release
cargo build --release
cp target/release/boilerplate-rust hello-rust-default
ls -lh hello-rust-default

# Build Rust Hello World - Stripped
strip target/release/boilerplate-rust -o hello-rust-stripped
ls -lh hello-rust-stripped
