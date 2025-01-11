
# CMake: Selecting Compilers

CMake provides a flexible way to select and configure compilers for your project. This guide explains how to choose specific compilers for your build process, either by setting environment variables, specifying compilers manually, or using CMake options.

---

[CMake help](https://cmake.org/cmake/help/latest/manual/cmake.1.html)

## Commands
### On Linux
```bash
cmake --system-information # Not easly readable
cmake --system-information info.txt # will add the output to info.txt
cmake -D CMAKE_CXX_COMPILER=g++ -DCMAKE_C_COMPILER=gcc /cmake/source/dir # specify the compiler, then use the cmake source directory instead "/cmake/source/dir"
```

**NOTE:** The Compiler has to be supported by the generator.

### On Windows:
```powershell
cmake -G"Visual Studio 16 2019" -T"ClangCL" \cmake\source\dir

# to use "cl" compiler with ninja generator
cmake -G "Ninja" -DCMAKE_CXX_COMPILER=cl \cmake\source\dir
cmake -G "MinGW Makefiles" -DCMAKE_CXX_COMPILER=clang++ \cmake\source\dir
```

**NOTE:**
* Ninja generator supports `MSVC`, `gcc`, `g++` and `Clang` compilers.
* MinGW Makefiles generator supports `gcc`, `g++` and `Clang` compilers.
* Visual Studio generator supports `MSVC`, and `Clang` compilers.

## Table of Contents

1. [Introduction](#introduction)  
2. [Default Compiler Selection](#default-compiler-selection)  
3. [Specifying a Compiler Manually](#specifying-a-compiler-manually)  
4. [Using Environment Variables](#using-environment-variables)  
5. [Changing the Compiler After Configuration](#changing-the-compiler-after-configuration)  
6. [Examples](#examples)  
7. [Conclusion](#conclusion)

---

## Introduction

CMake supports various compilers, including **GCC**, **Clang**, **MSVC**, and more. By default, CMake automatically detects and uses the system's default compiler. However, you can override this behavior and explicitly choose a compiler for your project.

---

## Default Compiler Selection

When you run `cmake` without specifying a compiler, it automatically uses the system's default compiler. For example:
- On Linux, it typically uses `gcc` or `clang`.
- On Windows, it uses the MSVC compiler from Visual Studio if available.

Run this command to check the default compiler:
```bash
cmake --version
```

---

## Specifying a Compiler Manually

You can specify a compiler manually during the configuration step using the `-DCMAKE_C_COMPILER` and `-DCMAKE_CXX_COMPILER` options:

```bash
cmake -DCMAKE_C_COMPILER=/path/to/gcc -DCMAKE_CXX_COMPILER=/path/to/g++ .
```

Example with Clang:
```bash
cmake -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ .
```

This tells CMake to use the specified compiler for the project.

---

## Using Environment Variables

Another method is to set environment variables before invoking CMake:

```bash
export CC=/path/to/gcc
export CXX=/path/to/g++
cmake .
```

On Windows (PowerShell):
```powershell
$env:CC="C:\path\to\gcc.exe"
$env:CXX="C:\path\to\g++.exe"
cmake .
```

The environment variables `CC` and `CXX` define the C and C++ compilers, respectively.

---

## Changing the Compiler After Configuration

Once you have configured a CMake project, changing the compiler requires starting a fresh build directory. Delete or recreate your `build` directory and reconfigure with the desired compiler.

For example:
```bash
rm -rf build
mkdir build
cd build
cmake -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ ..
```

---

## Examples

### Example 1: Using GCC
```bash
cmake -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ .
cmake --build .
```

### Example 2: Using Clang
```bash
cmake -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ .
cmake --build .
```

### Example 3: Setting Compilers via Environment Variables
```bash
export CC=gcc
export CXX=g++
cmake .
cmake --build .
```

---
