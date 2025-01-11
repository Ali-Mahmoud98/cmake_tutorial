# Library Targets in CMake

CMake allows developers to organize and structure large projects by using **library targets**. These targets encapsulate specific functionalities, making projects more modular, maintainable, and scalable.

In the this example we want to extract the operations feature into a static library and let this library loaded into our own binary executable to be used to do
things.

---

## Table of Contents

1. [Introduction](#introduction)  
2. [Single Target Approach](#single-target-approach)  
3. [Challenges in Large Projects](#challenges-in-large-projects)  
4. [Using Library Targets](#using-library-targets)  
5. [Types of Libraries and How to Create Them](#types-of-libraries-and-how-to-create-them)  
6. [Example: Refactoring with Library Targets](#example-refactoring-with-library-targets)  
7. [Benefits of Library Targets](#benefits-of-library-targets)  
8. [Conclusion](#conclusion)  

---

## 1. Introduction

In CMake, **targets** represent buildable components such as executables and libraries. For smaller projects, it's common to wrap everything into a single target, like an executable. However, for larger projects, organizing the code into separate **library targets** improves modularity and maintainability.

---

## 2. Single Target Approach

In smaller projects, a single target is often used to build the entire application. For example:

```cmake
add_executable(HelloApp main.cpp
    src/dog.cpp
    src/log.cpp
    src/operations.cpp
)
```

Here:
- **`HelloApp`** is the target representing the final executable.
- All source files (`main.cpp`, `dog.cpp`, `log.cpp`, and `operations.cpp`) are directly included in this target.
- The primary goal is to produce a single executable binary.

While this approach is straightforward, it can become problematic as the project grows.

---

## 3. Challenges in Large Projects

As projects grow, using a single target leads to several challenges:
- **Code Duplication**: Reusing functionality across different parts of the project becomes difficult.
- **Build Times**: Changes to one file might require rebuilding the entire target.
- **Limited Modularization**: Lack of clear boundaries between different components of the codebase.
- **Dependency Management**: Managing dependencies becomes complex without a modular structure.

---

## 4. Using Library Targets

To address these challenges, CMake allows you to define **library targets**. A library target encapsulates a subset of functionality, making it reusable and easier to manage.

### Example: Adding a Library Target
```cmake
add_library(LogLibrary src/log.cpp)
```

This creates a library target named `LogLibrary` from the `src/log.cpp` source file.

---

## 5. Types of Libraries and How to Create Them

### 5.1. Static Libraries

Static libraries are archives (`.a` on Linux/macOS or `.lib` on Windows) that are linked at **build time**. These libraries are directly included in the final executable, making it self-contained.

#### Creating a Static Library
Use `add_library` with the `STATIC` keyword:
```cmake
add_library(DogLibrary STATIC src/dog.cpp)
```

When building the project, this creates a static library file (`libDogLibrary.a` or `DogLibrary.lib`).

#### Linking a Static Library
Link the library to an executable:
```cmake
target_link_libraries(HelloApp PRIVATE DogLibrary)
```

---

### 5.2. Shared Libraries

Shared libraries (`.so` on Linux/macOS or `.dll` on Windows) are linked at **runtime**. The final executable depends on the shared library file being present during execution.

#### Creating a Shared Library
Use `add_library` with the `SHARED` keyword:
```cmake
add_library(LogLibrary SHARED src/log.cpp)
```

When building the project, this creates a shared library file (`libLogLibrary.so` or `LogLibrary.dll`).

#### Linking a Shared Library
Link the library to an executable:
```cmake
target_link_libraries(HelloApp PRIVATE LogLibrary)
```

---

### 5.3. Interface Libraries

Interface libraries do not contain any compiled code. Instead, they define **build properties** (like include directories or compile options) that can be shared with other targets.

#### Creating an Interface Library
Use `add_library` with the `INTERFACE` keyword:
```cmake
add_library(OperationsLibrary INTERFACE)
target_include_directories(OperationsLibrary INTERFACE include/)
```

#### Linking an Interface Library
Link the library to another target:
```cmake
target_link_libraries(HelloApp PRIVATE OperationsLibrary)
```

Interface libraries are ideal for managing header-only libraries or shared configurations.

---

## 6. Example: Refactoring with Library Targets

Let’s refactor the single target example into modular library targets.

### Before: Single Target
```cmake
add_executable(HelloApp main.cpp
    src/dog.cpp
    src/log.cpp
    src/operations.cpp
)
```

### After: Modular Library Targets
```cmake
# Define static and shared libraries
add_library(DogLibrary STATIC src/dog.cpp)
add_library(LogLibrary SHARED src/log.cpp)

# Define an interface library for shared configurations
add_library(OperationsLibrary INTERFACE)
target_include_directories(OperationsLibrary INTERFACE include/)

# Define the main executable
add_executable(HelloApp main.cpp)

# Link libraries to the executable
target_link_libraries(HelloApp PRIVATE DogLibrary LogLibrary OperationsLibrary)
```

---

## 7. Benefits of Library Targets

Using library targets provides several advantages:
- **Code Reusability**: Libraries can be linked to multiple targets without duplicating code.
- **Faster Build Times**: Only modified libraries need to be rebuilt.
- **Clearer Code Structure**: Each library target encapsulates specific functionality.
- **Flexible Linking**: Choose between static, shared, and interface libraries based on project requirements.
- **Better Dependency Management**: Dependencies are scoped to individual targets, reducing conflicts.

---

## 8. Conclusion

Library targets are essential for managing large CMake projects. By dividing code into modular static, shared, or interface libraries, you can achieve better scalability, maintainability, and reuse.

### Key Takeaways:
- Use **static libraries** for self-contained executables.
- Use **shared libraries** for dynamic linking and reducing executable size.
- Use **interface libraries** for header-only code or shared configurations.

Organize your project with library targets to improve your build system and codebase structure!
