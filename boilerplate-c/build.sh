#!/bin/bash
# Build C Hello World - Default
gcc main.c -o hello-c-default
ls -lh hello-c-default

# Build C Hello World - Optimized (O2)
gcc -O2 main.c -o hello-c-o2
ls -lh hello-c-o2

# Build C Hello World - Optimized for size (Os)
gcc -Os main.c -o hello-c-os
ls -lh hello-c-os

# Build C Hello World - Optimized for size + Strip
gcc -Os main.c -o hello-c-os-stripped
strip hello-c-os-stripped
ls -lh hello-c-os-stripped

# Build C Hello World - Static
gcc -static -Os main.c -o hello-c-static
ls -lh hello-c-static
