# CMake Generators

## What are CMake Generators?

In CMake, a *generator* is a tool that determines how CMake will produce the build files for your project. These build files are platform-specific and can include Makefiles, Visual Studio project files, or Ninja build scripts, among others. The generator specifies the tools and environment used to build the project.

Think of a generator as a translator: it converts your `CMakeLists.txt` file into a build system that your computer can understand.

**NOTE:** you can say Generator is a way to tell the cmake which build system it is going use to generate a project for.

* **Build system examples:**
    * **Windows:**
        * Visual Studio
        * Ninja
        * MinGW
    * **Linux:**
        * Ninja
        * Unix Makefiles

* You can see the available generators in `cmake --help`
* To specify a generator: `cmake -G "generator_name" .`

---

## Why Do Generators Matter?

Different platforms and developers use different build systems. For example:
- Linux developers might prefer Makefiles for command-line builds.
- Windows developers may use Visual Studio project files.
- Some developers prefer lightweight tools like Ninja for faster builds.

With CMake, you don’t have to create these build files manually. You just specify a generator, and CMake does the rest!

---

## Common CMake Generators with Real Examples

Here are some popular CMake generators and how to use them:

### 1. **Unix Makefiles (Default on Linux)**

This generator creates `Makefile`-based build files, commonly used on Unix-like systems.

#### Example:
```bash
cmake -G "Unix Makefiles" .
make
./my_project
```

### 2. **Ninja**

Ninja is a lightweight, fast build system, often preferred for large projects.

#### Example:
1. Install Ninja:
   ```bash
   sudo apt install ninja-build
   ```
2. Generate Ninja build files:
   ```bash
   cmake -G "Ninja" .
   ninja
   ./my_project
   ```

### 3. **Visual Studio (Default on Windows)**

For Windows, you can generate Visual Studio project files.

#### Example:
1. Generate project files for Visual Studio 2019:
   ```powershell
   cmake -G "Visual Studio 16 2019" .
   ```
2. Open the project in Visual Studio:
   ```powershell
   start my_project.sln
   ```
3. Build and run your project from within Visual Studio.

### 4. **Xcode (macOS)**

For macOS developers, CMake can generate Xcode project files.

#### Example:
1. Generate Xcode project files:
   ```bash
   cmake -G "Xcode" .
   ```
2. Open the project in Xcode:
   ```bash
   open my_project.xcodeproj
   ```

---

## How to Choose a Generator?

The generator you choose depends on your platform and tools. If you don’t specify a generator, CMake will pick a default based on your operating system. You can always specify a generator explicitly using the `-G` option.

---

## Unified build command
Unified way in which we can run cmake without really caring too about the details of the underlying build system, to make this super clear remember if we run cmake
using a command like `cmake /path/to/source` we are going to generate a build system specific project.

Cmake provides a unified way to run cmake without really caring too about the details of the underlying build system.
```bash
cmake --build /path/to/build/system/project --target <target_name> # "/path/to/build/system/project" is the path where the build system is generated
cmake --build /path/to/build/system/project --target clean
cmake --build /path/to/build/system/project --target help
```

---

## Summary

CMake generators make it easy to create build files for various platforms and environments without worrying about platform-specific details. Whether you’re working on Linux, Windows, or macOS, CMake has a generator that fits your needs.

> **Tip**: Run `cmake --help` to see a list of available generators for your system.

```bash
mkdir build # creating a directory to store the build files
cd build # switching to the build directory
cmake /path/to/source
cmake --build . --target help # see the list of available targets
# note some build systems don't use help command - e.g. Visual Studio

# to run build the project:
cmake --build .
```
