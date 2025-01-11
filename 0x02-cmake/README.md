# CMake Multi-File C++ Project: Understanding `PRIVATE`, `PUBLIC`, and `INTERFACE`

This guide provides a comprehensive explanation of how to create and manage a multi-file C++ project using CMake. It also explores the concepts of `PRIVATE`, `PUBLIC`, and `INTERFACE` in CMake, illustrating their effects with practical examples.

---

## Table of Contents
1. [Introduction](#introduction)
2. [Directory Structure](#directory-structure)
3. [Code Files](#code-files)
   - [Main Application](#main-application-mainappmaincpp)
   - [Helper Library](#helper-library-helperlib)
4. [CMake Configuration](#cmake-configuration)
   - [Root `CMakeLists.txt`](#file-cmakeliststxt-root)
   - [`HelperLib` CMake Configuration](#file-helperlibcmakeliststxt)
   - [`MainApp` CMake Configuration](#file-mainappcmakeliststxt)
5. [Understanding `PRIVATE`, `PUBLIC`, and `INTERFACE`](#understanding-private-public-and-interface)
   - [Case 1: Using `PRIVATE` for Include Directories](#case-1-using-private-for-include-directories)
   - [Case 2: Using `PRIVATE` for Compile Features](#case-2-using-private-for-compile-features)
   - [Case 3: Using `INTERFACE`](#case-3-using-interface)
6. [Conclusion](#conclusion)

---

## Introduction

When working on a multi-file C++ project, managing dependencies, include paths, and compiler features across different targets can become complex. CMake simplifies this process by allowing developers to control these properties using `PRIVATE`, `PUBLIC`, and `INTERFACE` scopes.

In this guide, we’ll build a simple multi-file C++ project with the following components:
1. A **Helper Library (`HelperLib`)** for utility functions.
2. A **Main Application (`MainApp`)** that uses the Helper Library.

---

## Directory Structure

Here is the directory structure for our project:

```
workspace/
├── CMakeLists.txt         # Root CMake file
├── MainApp/
│   ├── CMakeLists.txt     # CMake for MainApp
│   └── main.cpp           # Main application code
├── HelperLib/
│   ├── CMakeLists.txt     # CMake for HelperLib
│   ├── helper.h           # Header file for HelperLib
│   └── helper.cpp         # Implementation of HelperLib
```

---

## Code Files

### Main Application: `MainApp/main.cpp`
```cpp
#include <iostream>
#include "helper.h"  // Provided by HelperLib

int main() {
    std::cout << "Sum from HelperLib: " << add(10, 20) << std::endl;
    return 0;
}
```

### Helper Library: `HelperLib`

#### File: `helper.h`
```cpp
#ifndef HELPER_H
#define HELPER_H

int add(int a, int b);

#endif  // HELPER_H
```

#### File: `helper.cpp`
```cpp
#include "helper.h"

int add(int a, int b) {
    return a + b;
}
```

---

## CMake Configuration

### File: `CMakeLists.txt` (Root)
```cmake
cmake_minimum_required(VERSION 3.22)
project(MultiTargetExample)

# Add subdirectories for MainApp and HelperLib
add_subdirectory(HelperLib)
add_subdirectory(MainApp)
```

### File: `HelperLib/CMakeLists.txt`
```cmake
# Define the library project
add_library(HelperLib helper.cpp)

# Make the include directory available to linking targets
target_include_directories(HelperLib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# Enforce C++17 for this library
target_compile_features(HelperLib PUBLIC cxx_std_17)
```

### File: `MainApp/CMakeLists.txt`
```cmake
# Define the executable for the main application
add_executable(MainApp main.cpp)

# Link the HelperLib to MainApp
target_link_libraries(MainApp PRIVATE HelperLib)

# Enforce C++20 for MainApp, without affecting HelperLib
target_compile_features(MainApp PRIVATE cxx_std_20)
```

---

## Understanding `PRIVATE`, `PUBLIC`, and `INTERFACE`

CMake provides three visibility scopes to control how properties (like include directories or compiler features) are applied and propagated between targets.

| **Scope**               | **Behavior**                                                                                   |
|--------------------------|-----------------------------------------------------------------------------------------------|
| **PRIVATE**              | Applies only to the target itself.                                                           |
| **PUBLIC**               | Applies to the target and is propagated to targets that link against it.                     |
| **INTERFACE**            | Applies only to targets that link against it; does not affect the target itself.             |

---

### Case 1: Using `PRIVATE` for Include Directories
```cmake
target_include_directories(HelperLib PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
```
- **Result**:  
  `MainApp` cannot find `helper.h`, and the build fails with a **"file not found" error**.  
  This happens because the include directory is no longer shared with `MainApp`.

---

### Case 2: Using `PRIVATE` for Compile Features
```cmake
target_compile_features(HelperLib PRIVATE cxx_std_17)
```
- **Result**:  
  `HelperLib` continues to use C++17, while `MainApp` is unaffected and can use C++20 or another standard.

---

### Case 3: Using `INTERFACE`
If you change include directories to:
```cmake
target_include_directories(HelperLib INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})
```
- **Result**:  
  `HelperLib` itself doesn’t see the `helper.h` file (build fails), but `MainApp` does.  
  This is because `INTERFACE` makes the directory visible **only to linking targets**.

---

## Conclusion

This guide demonstrates how to structure a multi-file C++ project using CMake and highlights the significance of `PRIVATE`, `PUBLIC`, and `INTERFACE`. By using these scopes effectively:
- You can control property visibility and avoid unnecessary dependencies.
- Ensure modularity and maintainability in your project.

Experimenting with these scopes in your own projects will deepen your understanding of CMake's power in managing multi-target builds.
