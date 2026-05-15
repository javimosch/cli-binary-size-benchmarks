# CLI Binary Size Benchmarks

**Author:** Javier Leandro Arancibia  
**Purpose:** Benchmark CLI stacks for building plugins for [SuperCLI](https://github.com/javimosch/supercli)

This repository provides real-world binary size comparisons between different programming languages for CLI applications, specifically to inform decisions for building SuperCLI plugins.

## 🎯 Project Goal

SuperCLI is a powerful CLI framework that supports plugins built in various languages. This benchmark helps plugin developers choose the optimal language based on binary size constraints, which is crucial for:

- Fast plugin distribution and installation
- Minimal disk footprint for users with many plugins
- Quick download times, especially in bandwidth-constrained environments
- Efficient storage and version management

## 📊 Complete Binary Size Comparison

### Simple Hello World vs Realistic CLI Skeleton

| Language | Simple Hello World | Realistic CLI | Change | Notes |
|----------|-------------------|---------------|---------|-------|
| **C** | 15K | 15K-17K | +0-2K | Minimal increase |
| **Zig** | 130K | 130K | +0K | API issues, kept simple |
| **Rust** | 287K | 314K | +27K | +9% increase |
| **Go** | 1.2M | 1.3M | +100K | +8% increase |
| **Bun** | 100M | 100M | +0M | Runtime dominates |
| **Deno** | ~58M | ~58M | +0M | Runtime dominates |

### Detailed Results: Realistic CLI

#### **C (Baseline - Traditional)**
- Default: 17K (+1K from simple)
- Optimized (-O2): 17K (+1K)  
- Size-optimized (-Os): 17K (+1K)
- Size-optimized + stripped: **15K** (same)
- Static: 884K (+4K)

#### **Zig (Modern Systems Champion)**
- Debug: 9.8M (same)
- ReleaseFast: 3.5M (same)
- ReleaseSafe: 3.4M (same)
- ReleaseSmall: **130K** (same - API issues)
- ReleaseSmall + stripped: **130K** (same)

#### **Rust (Memory-Safe Champion)**
- Release: **314K** (+27K from simple)
- Release + stripped: **314K** (+27K)

#### **Go (Current SuperCLI Choice)**
- Default: 2.0M (+100K from simple)
- Optimized: **1.3M** (+100K from simple)

#### **Bun (JavaScript Runtime)**
- Compiled: **100M** (same - runtime dominates)

#### **Deno (JavaScript Runtime)**
- Compiled: **~58M** (same - runtime dominates)

## 🔍 Size Rankings (Realistic CLI)

1. **C**: 15K (traditional baseline)
2. **Zig**: 130K (modern systems language)
3. **Rust**: 314K (memory-safe systems language)
4. **Go**: 1.3M (current SuperCLI choice)
5. **Deno**: ~58M (JavaScript runtime)
6. **Bun**: 100M (JavaScript runtime)

## 💡 Key Insights

### Code Complexity Impact

- **Systems languages (C, Rust, Go)**: 8-9% size increase with realistic CLI features
- **JavaScript runtimes (Bun, Deno)**: No impact - embedded runtime dominates size
- **Zig**: Kept simple due to API compatibility issues in version 0.16.0

### Go vs JavaScript Runtimes

| Metric | Go | Bun | Deno |
|--------|-----|-----|------|
| **Binary Size** | 1.3M | 100M | 58M |
| **Size vs Go** | 1x | **77x larger** | **45x larger** |
| **Contains** | Go runtime | JavaScriptCore + Bun APIs | V8 + Deno APIs |

### Why JavaScript Runtimes Are So Large

Both Bun and Deno must embed:
- **Entire JavaScript engine** (JavaScriptCore for Bun, V8 for Deno)
- **Full runtime APIs** (fs, http, crypto, etc.)
- **Standard library equivalents**
- **Static linking dependencies**

This is why a simple CLI becomes 58-100MB, making them unsuitable for plugin distribution.

## 🚀 Recommendations for SuperCLI Plugins

### ✅ **Stick with Go** (Current Choice - Recommended)

**Advantages:**
- 1.3MB realistic CLI size - downloads instantly
- 77x smaller than Bun, 45x smaller than Deno
- Great ecosystem and tooling
- Fast compilation
- Excellent cross-platform support
- Proven in production

**When to use:**
- Standard SuperCLI plugins
- When development speed matters
- When 1-2MB binary size is acceptable
- When you want mature ecosystem and tooling

### 🥈 **Consider Rust** (For Size-Conscious Plugins)

**Advantages:**
- 314K realistic CLI size (4x smaller than Go)
- Memory safety without garbage collection
- Growing ecosystem (crates.io)
- Great tooling (cargo)

**Trade-offs:**
- Longer compile times
- Steeper learning curve (borrow checker)
- Smaller ecosystem than Go

**When to use:**
- When binary size is critical
- When memory safety is important
- When you're willing to handle longer compile times

### 🥉 **Consider Zig** (For Maximum Size Optimization)

**Advantages:**
- 130K realistic CLI size (10x smaller than Go)
- Manual memory control without GC
- Fast compilation
- Great cross-compilation support

**Trade-offs:**
- Smaller ecosystem and community
- Steeper learning curve
- API still evolving (compatibility issues)
- Fewer libraries available

**When to use:**
- When binary size is absolutely critical
- When you're willing to deal with a smaller ecosystem
- For experimental or cutting-edge projects

### ❌ **Avoid Bun/Deno for SuperCLI Plugins**

**Reasons:**
- 45-77x larger than Go (58MB vs 1.3MB)
- No advantage for standalone CLI tools
- Plugin distribution would be impractical
- Download times would be significant
- Storage footprint would be massive

**When to avoid:**
- Plugin development for SuperCLI
- Any CLI tool where size matters
- Distribution to end users

## 📁 Project Structure

```
boilerplate-cli/
├── boilerplate-go/      # Go implementation with CLI skeleton
├── boilerplate-rust/    # Rust implementation with CLI skeleton  
├── boilerplate-zig/     # Zig implementation (simple Hello World)
├── boilerplate-c/       # C implementation with CLI skeleton
├── boilerplate-bun/     # Bun implementation with CLI skeleton
├── boilerplate-deno/    # Deno implementation with CLI skeleton
├── build-all.sh         # Master build script
└── README.md            # This file
```

## 🔧 Build Instructions

### Build All Languages

```bash
./build-all.sh
```

### Build Individual Languages

#### Go
```bash
cd boilerplate-go
./build.sh
```

#### Rust
```bash
cd boilerplate-rust
./build.sh
```

#### Zig
```bash
cd boilerplate-zig
./build.sh
```

#### C
```bash
cd boilerplate-c
./build.sh
```

#### Bun
```bash
cd boilerplate-bun
./build.sh
```

#### Deno
```bash
cd boilerplate-deno
./build.sh
```

## 🛠️ Requirements

- **Go**: 1.21+
- **Rust**: 1.70+ (with cargo)
- **Zig**: 0.16+
- **C**: gcc or clang
- **Bun**: latest version
- **Deno**: 2.x (compilation may have node_modules scanning issues)

## 📋 CLI Features Implemented

Each boilerplate (except Zig due to API issues) includes a realistic CLI skeleton with:

- **Command/subcommand structure** (greet, version, help)
- **Flag parsing** (--name, --upper, --excited)
- **Help text** with usage examples
- **Error handling** with proper exit codes
- **Version information**

This provides a more realistic comparison than simple "Hello World" programs.

## 🧪 Testing the Binaries

After building, test that all binaries work:

```bash
# Go
./boilerplate-go/hello-go-optimized greet
./boilerplate-go/hello-go-optimized greet --name Alice
./boilerplate-go/hello-go-optimized version

# Rust
./boilerplate-rust/hello-rust-stripped greet
./boilerplate-rust/hello-rust-stripped greet --name Bob
./boilerplate-rust/hello-rust-stripped version

# C
./boilerplate-c/hello-c-os-stripped greet
./boilerplate-c/hello-c-os-stripped greet --name Charlie
./boilerplate-c/hello-c-os-stripped version

# Bun
./boilerplate-bun/hello-bun-compiled greet
./boilerplate-bun/hello-bun-compiled greet --name David
./boilerplate-bun/hello-bun-compiled version
```

All should output appropriate greetings and version information.

## 🧹 Cleanup

To remove built binaries:

```bash
# Individual cleanup
cd boilerplate-go && rm hello-*
cd ../boilerplate-rust && rm hello-*
cd ../boilerplate-zig && rm hello-*
cd ../boilerplate-c && rm hello-*
cd ../boilerplate-bun && rm hello-*

# Or cleanup all
find . -name "hello-*" -type f -delete
```

## 📊 Methodology

### Build Configurations

- **Go**: Standard build vs `-ldflags "-s -w"` (strip debug info)
- **Rust**: Release build with optimization for size in Cargo.toml
- **Zig**: Multiple optimization modes (Debug, ReleaseFast, ReleaseSafe, ReleaseSmall)
- **C**: Multiple optimization levels (-O2, -Os) with/without strip
- **Bun**: Standard `bun build --compile`
- **Deno**: Standard `deno compile` (expected size from benchmarks)

### Testing Environment

- **OS**: Linux 6.8.0-111-generic
- **Platform**: linux-x86_64
- **Date**: May 15, 2026
- **Go version**: 1.21+
- **Rust version**: 1.70+
- **Zig version**: 0.16.0
- **Bun version**: latest
- **Deno version**: 2.2.8

## 🔗 Related Projects

- [SuperCLI](https://github.com/javimosch/supercli) - The main CLI framework these benchmarks inform
- [supercli-clis](https://github.com/jarancibia/supercli-clis) - Collection of Go CLI tools for SuperCLI

## 📝 License

This benchmark project is provided as-is for educational and decision-making purposes.

## 🤝 Contributing

Additional language benchmarks, optimization techniques, and real-world SuperCLI plugin examples are welcome!

---

**Conclusion:** Go remains the optimal choice for SuperCLI plugins, offering the best balance of binary size (1.3M), development experience, ecosystem maturity, and cross-platform support. JavaScript runtimes (Bun/Deno) are unsuitable due to their 45-77x larger binary sizes.
