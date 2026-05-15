#!/bin/bash
# Build Bun Hello World - Compile to standalone binary
bun build --compile main.ts --outfile hello-bun-compiled
ls -lh hello-bun-compiled
