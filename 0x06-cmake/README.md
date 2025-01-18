# Organizing `CMake` Projects

This project demonstrates how to structure and manage `CMake` projects by partitioning code into smaller, logical units using two common methods: the `include` command and the `add_subdirectory` command. This modular approach is especially useful for larger projects with complex build configurations.


**Examples:**
* [1-example](./1-example/): Example of using `include`
* [2-example](./2-example/): Example of using `add_subdirectory`

---

## Table of Contents
1. [Introduction](#introduction)
2. [How `include` Works](#how-include-works)
3. [How `add_subdirectory` Works](#how-add-subdirectory-works)
4. [Difference Between `include` and `add_subdirectory`](#difference-between-include-and-add-subdirectory)
5. [Project Structure using `include`](#project-structure-using-include)
6. [Project Structure using `add_subdirectory`](#project-structure-using-add_subdirectory)
7. [Setup and Usage](#setup-and-usage)
8. [Key Takeaways](#key-takeaways)
9. [Best Practices](#best-practices)

---

## Introduction

As `CMake` projects grow, managing everything in a single `CMakeLists.txt` file becomes challenging. This project shows how to split the build configuration into modular files for better maintainability, readability, and scalability. Each library or module is isolated in its own `.cmake` file, and these files can be included in the main `CMakeLists.txt` using the `include` command or added as sub-directories using `add_subdirectory`.

`CMake` provides a way to partition our `cmake` code into small pieces that we can then include in other `cmake` files. we have two common approaches to this in the `cmake`:
* using `include`
* using `add_subdirectory`

---

## How `include` Works

The `include` command in `CMake` allows you to:
- Split build logic into smaller files (e.g., for libraries or modules).
- Include these files in the main `CMakeLists.txt` at the point where the `include` command is called.
- This is similar to `#include` in C/C++.

Example:
```cmake
# In CMakeLists.txt
include(math.cmake)
include(stats.cmake)
```

This approach directly copies the contents of the included `.cmake` files into the main `CMakeLists.txt` file at the point of inclusion. The `include` command is useful when dealing with smaller, independent configurations that don't require separate directory management.

---

## How `add_subdirectory` Works

The `add_subdirectory` command is another way to modularization a `CMake` project:
- It allows you to include an entire directory and its `CMakeLists.txt` configuration into your build process.
- This is useful for larger projects or libraries where a separate directory and its build logic should be maintained independently.

Example:
```cmake
# In CMakeLists.txt
add_subdirectory(src/maths)
add_subdirectory(src/stats)
```

This will cause `CMake` to process the `CMakeLists.txt` files in the `src/maths/` and `src/stats/` directories, handling them as sub-projects. This is ideal when there are more complex setups or when you want to structure the project with multiple sub-modules.

---
## Difference Between `include` and `add_subdirectory`

While both `include` and `add_subdirectory` allow you to modularization a `CMake` project, they serve different purposes and are suited to different scenarios. Here's a comparison:

| **Feature**                  | **`include`**                              | **`add_subdirectory`**                          |
|------------------------------|--------------------------------------------|-------------------------------------------------|
| **Purpose**                   | Include smaller configuration files into a main `CMakeLists.txt` file. | Include and process an entire subdirectory with its own `CMakeLists.txt` file. |
| **Directory Structure**       | No separate directory management, just included files. | Creates a logical subdirectory in the project structure. |
| **When to Use**               | For simple, smaller pieces of logic, often used for specific libraries or modules. | For larger projects or libraries with their own build setup and dependencies. |
| **Scope**                     | Only includes the contents of the file at the point of inclusion. | Adds the entire directory structure and its associated `CMakeLists.txt` files into the build. |
| **Dependencies**              | Typically used when dependencies are simple and local to the project. | Best for handling complex dependencies that require separate compilation and configuration. |
| **Example**                   | `include(math.cmake)`                     | `add_subdirectory(src/maths)`                   |

### Example 1: Using `include`

For a simple project, where the configuration for libraries is minimal and doesn't require additional directory-level management, `include` is often sufficient:

```cmake
# In CMakeLists.txt
include(src/maths/math.cmake)
include(src/stats/stats.cmake)
```

In this case, the logic inside `math.cmake` and `stats.cmake` will be directly included into the main `CMakeLists.txt` file. This is a quick and easy way to manage configuration when the libraries don't require complex setups.

### Example 2: Using `add_subdirectory`

When you have a more complex project, especially when working with third-party libraries or multi-level dependencies, `add_subdirectory` is more appropriate:

```cmake
# In CMakeLists.txt
add_subdirectory(src/maths)
add_subdirectory(src/stats)
```

In this case, the `src/maths` and `src/stats` directories will be treated as independent sub-projects. Each directory will contain its own `CMakeLists.txt` file, and `CMake` will handle them as separate parts of the build process. This is ideal when those directories contain more detailed build logic or dependencies.

---
## Project Structure using `include`

The project is organized as follows:

```
Project/
├── CMakeLists.txt         # Main build file
└── src/
    ├── main.cpp           # Main application entry point
    ├── maths/
    │   ├── supermath.cpp
    │   ├── math.cmake             # Math library logic
    │   └── include/
    │       └── supermath.h
    └── stats/
        ├── stats.cpp
        ├── stats.cmake            # Stats library logic
        └── include/
            └── stats.h
```

### Description:

- **`CMakeLists.txt`**: Main build configuration, includes `math.cmake` and `stats.cmake` using `include` or `add_subdirectory`.
- **`math.cmake`**: Contains build logic for the math library.
- **`stats.cmake`**: Contains build logic for the stats library.
- **`src/`**: Contains source and header files for the application, math library, and stats library.

## Project Structure using `add_subdirectory`

Here we will be setting up separate files containing our `cmake` code, but they are not going to be simple scripts,
they are going to be actual `CMakeLists.txt` files that wrap around the logical component of the `math` and `stats` libraries.

The project is organized as follows:

```
Project/
├── CMakeLists.txt         # Main build file
└── src/
    ├── main.cpp           # Main application entry point
    ├── maths/
    │   ├── supermath.cpp
    │   ├── CMakeLists.txt             # Math library logic
    │   └── include/
    │       └── supermath.h
    └── stats/
        ├── stats.cpp
        ├── CMakeLists.txt           # Stats library logic
        └── include/
            └── stats.h
```

---

## Setup and Usage

### 1. Clone the Repository

```bash
git clone <repository-url>
cd Project
```

### 2. Build the Project

```bash
mkdir build
cd build
cmake ..
cmake --build .
```

### 3. Run the Application

```bash
./rooster
```

---

## Key Takeaways

1. **Use the `include` Command**:
   - Simplifies the structure of large `CMake` projects.
   - Modularizes build logic by placing it in separate `.cmake` files.
   - Works well for independent or smaller components.

2. **Use the `add_subdirectory` Command**:
   - Ideal for handling more complex libraries or subprojects.
   - Keeps project structure clear, especially when managing submodules or multi-level dependencies.

3. **Organize by Logical Units**:
   - Create `.cmake` files or directories for each library or module.
   - Keep `CMakeLists.txt` concise and focused on high-level project configuration.

4. **Avoid Path Confusion**:
   - Use relative paths in `.cmake` files to maintain consistency across directories.

5. **Ensure Proper Dependencies**:
   - Link libraries and executables correctly using `target_link_libraries`.

---

## Best Practices

- **Keep CMake Modular**: Limit each `.cmake` file or subdirectory to logic specific to a single library or module.
- **Use Meaningful Names**: Name `.cmake` files clearly to reflect their purpose.
- **Document Your Code**: Add comments in `CMakeLists.txt` and `.cmake` files to explain the build logic.
- **Test Your Setup**: Regularly build and test your project to catch configuration issues early.

---

By using the `include` and `add_subdirectory` commands, you can build cleaner, more maintainable, and modular `CMake` projects. Each approach has its strengths and can be chosen depending on the scale and structure of your project.
