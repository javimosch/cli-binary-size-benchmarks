#!/bin/bash
# Build Go Hello World - Default
go build -o hello-go-default main.go
ls -lh hello-go-default

# Build Go Hello World - Optimized
go build -ldflags "-s -w" -o hello-go-optimized main.go
ls -lh hello-go-optimized
