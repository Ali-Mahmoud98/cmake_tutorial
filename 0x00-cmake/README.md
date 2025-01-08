# Getting Started with CMake

## What is CMake?

CMake is a cross-platform, open-source software tool designed to manage the build process in a compiler-independent manner. It acts as a build system generator, creating native build scripts for a variety of platforms and environments, such as Makefiles for Unix-based systems or Visual Studio project files for Windows.

**NOTE:** Cmake is build system generator and not a build system.

## Why Use CMake?

C++ projects often need to be built on multiple platforms using different compilers and tools. Managing platform-specific build configurations manually can be error-prone and time-consuming. CMake simplifies this process by providing a unified, declarative way to specify how a project is structured. It automates the generation of platform-specific build files, ensuring consistency and reducing complexity across development environments.

## Building Without CMake

If you'd like to build a simple C++ program manually without CMake, you can use the following commands:

### On Linux
```bash
g++ -std=c++20 main.cpp -o main
./main
```

### On Windows (with MinGW or a similar environment)
```powershell
g++ -std=c++20 main.cpp -o main
.\main
```

### On Windows (using Developer PowerShell for Visual Studio 2019 or newer)
```powershell
cl.exe /Zi /std:c++latest main.cpp /EHsc /Fe:main.exe
.\main
```

### Why Not Build This Way?

While this approach works for simple projects, it becomes unmanageable as projects grow in complexity. Differences in compilers, operating systems, and dependencies require different configurations and commands. Manually maintaining these builds for various platforms can quickly lead to errors and inconsistencies.

CMake addresses this by allowing developers to define their project structure and build requirements in a single `CMakeLists.txt` file. From this file, CMake generates the appropriate build files for the target environment, making the build process seamless and reproducible across all platforms.

### Build the project using cmake:
```bash
mkdir build # creating a directory to store the build files
cd build # switching to the build directory
cmake .. # generating the build files and using CMakeLists.txt in the parent directory
make # compiling the project
```

**NOTE:** Using Cmake you will be able to generate the build files and compile the project for multiple platforms (e.g. you will use same `CMakeLists.txt` for Linux, Windows).

### Example files:
* [main.cpp](./main.cpp)
* [CMakeLists.txt](./CMakeLists.txt)
* [generate.sh](./generate.sh): if you use Linux you can run this script to make a directory and generate the build files inside it.
