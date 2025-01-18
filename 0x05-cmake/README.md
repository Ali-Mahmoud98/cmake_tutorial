# Target Dependencies - PUBLIC, INTERFACE AND PRIVATE

Here we will explore the keywords like `PUBLIC`, and `PRIVATE`.
The `cmake` example below contains a project which is made up of two libraries.
The `libmath` library which going to provide some mathematical capabilities to our application, and the `libstats` library is going to be depending on the math library and we setup that dependency using the `target_link_libraries` command and then we have a final executable binary it is going to be dependent on the `libstats` library. we setup that dependency using the `target_link_libraries`.

What are the `PUBLIC`, and `PRIVATE` mean and how would you use them on your `cmake` project?. the whole goal of your `cmake` project is going to be **building targets** a **target** is a logical unit in your application  so for example you might have your application made up **dozens of libraries** and each of those libraries is going to be a **target** and your source code is going to be organized into a logical units to give birth to those binaries.

Targets are a way to logically group those piece of source code to give birth to those libraries or binaries.

```cmake
cmake_minimun_required(VERSION 3.20)
project(Rooster)

# the math library
add_library(libmath STATIC src/maths/supermath.cpp)
target_include_directories(libmath PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/src/maths/include)

# the stats library
add_library(libstats STATIC src/stats/stats.cpp)
target_include_directories(libstats PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/src/stats/include)
target_link_libraries(libstats PRIVATE libmath)

# the executable target
add_executable(rooster src/main.cpp)
target_link_libraries(rooster PUBLIC libstats)
```

**NOTE:** the math, stats, and rooster are targets, and each one of math and stats is a logical unit in our application binary *(executable)*. To build that binary we can organize our binary code into logical chunks and one the driving forces behind that is that these logical chunks may be used with other part of the application.

Suppose you have a lot of executable binaries in our application and it is possible to make them all somehow depend on our libraries, for example we may have `executable1`, `executable2`, and `executable3`:
* `executable1` depend on the math library.
* `executable2` depends on the stats library.
* `executable3` depends on math and stats libraries.

Each executable is a target in `cmake` . When you setup a target dependencies you will use keywords `PUBLIC`, `INTERFACE`, and `PRIVATE` .

Each target is going to have a bunch of properties associated with it and it is possible for a target to propagate its properties down to other targets that depend on it.

**NOTE:** each target is going to have a bunch of properties associated with it, (e.g. our math target possible to have *defines* related this math library, *compiler flags* specific to this math library, and *include path* ).

**NOTE:** it is possible to have different targets use different compiler flags.

In our `rooster` target which depends on `math` target, it is possible to get the included path from the `math` library without having to set up the include path on our rooster target and **this is crucial** to understand.

When it comes to use `PUBLIC`, `INTERFACE`, and `PRIVATE` keywords, you have to:
* Think from the prospective of the **owner** of the property.
* Think from the prospective of the **consumer** of the property.
You can think about the `PUBLIC`, `INTERFACE`, and `PRIVATE` keywords in this example as the following:

**OWNER Prospective:**
1. look at the `math` library which `stats` library depend on it, and `rooster` target depend on `stats` library.
2. if we set up the property like *include path* as `PUBLIC` in the math target, other targets that depend on the `math` target will have this property inherited and they will be able to use it. **This is what the public keyword does**.
3. Using `INTERFAC` means that the property (e.g. *include path*) can be used by other targets that may depend on me(`math`) but I am not going to use this property myself. 
4. In this case `math` library is the owner of the *include path* property.
5. If `math` library made the *include path* property as `PRIVATE`, it **will not pass the property to other targets** that depend on the `math` target.
6. If you make a `math` library *include path* property as `INTERFACE` this means that you do not want the `math` library to use the property and you want other targets to use that property.

**CONSUMER Prospective:**
1. We may say that the `stats` library depends on the `math` library, and if the `math` library used the `PUBLIC` keyword on the *include path* property, it means that the `stats` library is going to getting this property.
2. If the `stats` library used `PUBLIC` to get the property of the `math` library, it means that is going to get every thing the `math` library provides, and its is going to to pass it down to other targets that may depend on it.
3. If `stats` used `INTERFACE` when getting a property from `math`, it means that the `stats` will get the the property and `stats` will not use the property, but it(`stats`) will pass the property to a target will depend on it(`stats`).
4. If `stats` used `PUBLIC` when getting a property from `math`, it means the `stats` will use the property and will pass it to another target.

---

### **Target Properties and Scope**

| **Property**                 | **PRIVATE**                                                                                   | **INTERFACE**                                                                    | **PUBLIC**                                                   |
| ---------------------------- | --------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- | ------------------------------------------------------------ |
| **Include Directories**      | Used **only by the owner target**. Not propagated to targets depending on it.                 | Used **only by dependent targets**. The owner target does not use this property. | Used by **both the owner target** and all dependent targets. |
| **Compile Definitions**      | Apply **only to the owner target**. Not propagated to dependent targets.                      | Apply **only to dependent targets**. Owner target does not use them.             | Apply to **both the owner target** and dependent targets.    |
| **Compile Options**          | Apply **only to the owner target**. Not propagated.                                           | Apply **only to dependent targets**. Owner target does not use them.             | Apply to **both the owner target** and dependent targets.    |
| **Linked Libraries**         | Linked **only to the owner target**. Dependent targets will not link against these libraries. | Dependent targets link against these libraries, but the owner target does not.   | Linked by **both the owner target** and dependent targets.   |
| **Preprocessor Definitions** | Apply **only to the owner target**.                                                           | Apply **only to dependent targets**.                                             | Apply to **both the owner target** and dependent targets.    |
| **Compiler Features**        | Affect **only the owner target**.                                                             | Affect **only dependent targets**.                                               | Affect **both the owner target** and dependent targets.      |

---

### **Explanation of Properties**

1. **Include Directories (`target_include_directories`)**:
    
    - **PRIVATE**: The include directories are only for the target itself.
    - **INTERFACE**: The target doesn’t use the directories but passes them to its dependents.
    - **PUBLIC**: Both the target and its dependents use the directories.
2. **Compile Definitions (`target_compile_definitions`)**:
    
    - **PRIVATE**: Definitions are only used by the target itself.
    - **INTERFACE**: Definitions are passed to dependents but not used by the target.
    - **PUBLIC**: Definitions are used by both the target and its dependents.
3. **Compile Options (`target_compile_options`)**:
    
    - **PRIVATE**: Options are only applied to the target.
    - **INTERFACE**: Options are passed to dependents but not used by the target.
    - **PUBLIC**: Options are applied to both the target and its dependents.
4. **Linked Libraries (`target_link_libraries`)**:
    
    - **PRIVATE**: The target links with the library, but dependents don’t.
    - **INTERFACE**: The library is linked by dependents but not by the target.
    - **PUBLIC**: Both the target and its dependents link with the library.
5. **Preprocessor Definitions**:
    
    - Behave similarly to compile definitions but are specifically for preprocessor macros.
6. **Compiler Features**:
    
    - Specify the features (e.g., `cxx_std_17`) required. Their scope depends on the keyword.

---

### **Example of Each Property in CMake**

```cmake
# Math Library
add_library(mathlib STATIC math.cpp)
target_include_directories(mathlib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
target_compile_definitions(mathlib PRIVATE MATHLIB_DEBUG=1)
target_compile_options(mathlib PUBLIC -Wall)

# Stats Library
add_library(statslib STATIC stats.cpp)
target_include_directories(statslib INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}/include)
target_link_libraries(statslib PUBLIC mathlib)

# Executable
add_executable(main main.cpp)
target_link_libraries(main PRIVATE statslib)
```

---

### **1. Include Directories (`target_include_directories`)**

- **Purpose**: Specifies the directories that should be added to the compiler's include search path for the target.
- **Effect**:
    - **PRIVATE**: Only the target uses these include directories.
    - **INTERFACE**: Only targets that depend on this target use these directories.
    - **PUBLIC**: Both the target and its dependent targets use these directories.
- **Example**:
    
    ```cmake
    target_include_directories(mathlib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/include)
    ```
    
    Here, `mathlib` uses the include directory, and any target depending on `mathlib` will also use it.

---

### **2. Compile Definitions (`target_compile_definitions`)**

- **Purpose**: Specifies preprocessor macros or definitions that are passed to the compiler.
- **Effect**:
    - **PRIVATE**: Definitions are only used when compiling the target itself.
    - **INTERFACE**: Definitions are not used by the target but are passed to dependent targets.
    - **PUBLIC**: Definitions are used by both the target and dependent targets.
- **Example**:
    
    ```cmake
    target_compile_definitions(mathlib PRIVATE MATHLIB_DEBUG=1)
    ```
    
    The macro `MATHLIB_DEBUG` is defined only for compiling `mathlib`.

---

### **3. Compile Options (`target_compile_options`)**

- **Purpose**: Specifies additional flags or options to pass to the compiler.
- **Effect**:
    - **PRIVATE**: Options affect only the target itself.
    - **INTERFACE**: Options are passed to dependent targets but not used by the target.
    - **PUBLIC**: Options affect both the target and dependent targets.
- **Example**:
    
    ```cmake
    target_compile_options(mathlib PUBLIC -Wall)
    ```
    
    Enables `-Wall` warnings for `mathlib` and all targets that depend on `mathlib`.

---

### **4. Linked Libraries (`target_link_libraries`)**

- **Purpose**: Specifies libraries to link with the target. It controls the propagation of the link information to dependent targets.
- **Effect**:
    - **PRIVATE**: Only the target links against these libraries.
    - **INTERFACE**: Dependent targets link against these libraries, but the target itself does not.
    - **PUBLIC**: Both the target and its dependents link against these libraries.
- **Example**:
    
    ```cmake
    target_link_libraries(statslib PRIVATE mathlib)
    ```
    
    The `statslib` links with `mathlib`, but targets depending on `statslib` do not automatically link with `mathlib`.

---

### **5. Preprocessor Definitions**

- **Purpose**: Similar to compile definitions, they define macros that are used in preprocessor directives (e.g., `#ifdef` and `#define`).
- **Behavior**:
    - Follows the same **PRIVATE**, **INTERFACE**, and **PUBLIC** rules as `target_compile_definitions`.
- **Example**:
    
    ```cmake
    target_compile_definitions(mathlib PUBLIC USE_FAST_MATH)
    ```
    
    This makes the `USE_FAST_MATH` macro available for `mathlib` and all its dependent targets.

---

### **6. Compiler Features (`target_compile_features`)**

- **Purpose**: Specifies language features required for the target (e.g., C++11, C++17).
- **Effect**:
    - **PRIVATE**: The feature is only enforced for the target.
    - **INTERFACE**: The feature is required by dependent targets but not by the target itself.
    - **PUBLIC**: Both the target and its dependents must support the feature.
- **Example**:
    
    ```cmake
    target_compile_features(mathlib PUBLIC cxx_std_17)
    ```
    
    Requires `mathlib` and all its dependents to use at least C++17.

---

### **Why These Properties Matter**

These properties allow you to:

1. **Control Information Flow**: Decide whether properties like include directories or compile options are visible to dependent targets.
2. **Promote Reusability**: Make targets modular and reusable by encapsulating dependencies and configurations.
3. **Minimize Redundancy**: Avoid repeating properties in multiple targets by propagating them as needed.

---
