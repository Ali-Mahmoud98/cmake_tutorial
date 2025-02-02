# Clang Format

### [**Clang 21.0.0git documentation**](https://clang.llvm.org/docs/ClangFormat.html)

## Explaination of `CMakeLists.txt`:

### **CMakeLists.txt Breakdown**

```cmake
#[=[
     Exploring CMake's Custom Targets, custom modules and code formatting with clang-format
#]=]
```
#### **1. Multi-Line Comment**
- The `#[=[ ... #]=]` syntax is used for multi-line comments in CMake.
- It explains that this `CMakeLists.txt` file is meant to:
  - Explore **custom CMake targets**.
  - Use **custom CMake modules**.
  - Implement **code formatting** using `clang-format`.

---

```cmake
cmake_minimum_required(VERSION 3.21) # At least version 3.21 is required for C++23
```
#### **2. Specify the Minimum CMake Version**
- **Purpose:** Ensures that the project is built with **at least** CMake version **3.21**.
- **Why 3.21?**
  - This version introduces better support for **C++23** and modern CMake features.
  - If a user has an older version, CMake will stop and display an error.

---

```cmake
project(CustomTargets) # Replace with your project name
```
#### **3. Define the Project**
- **`project(CustomTargets)`** defines the project name as `CustomTargets`.
- This name is used internally by CMake to identify the project.

---

```cmake
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
```
#### **4. Add a Custom CMake Modules Directory**
- **What it does:** Appends the `cmake/` directory inside the project folder to the `CMAKE_MODULE_PATH`.
- **Why?**
  - This allows CMake to find custom `.cmake` files (such as `ClangFormat.cmake`).
  - If this line were missing, CMake wouldn’t be able to locate custom modules.

---

```cmake
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
```
#### **5. Set the C++ Standard**
- **`set(CMAKE_CXX_STANDARD 23)`**
  - Specifies that the project should use **C++23**.
- **`set(CMAKE_CXX_STANDARD_REQUIRED ON)`**
  - Ensures that **C++23 is mandatory**.
  - Without this line, the compiler **might** fall back to an older standard if it doesn't fully support C++23.

---

```cmake
add_executable(rooster main.cpp person.cpp)
```
#### **6. Create an Executable Target**
- **`add_executable(rooster main.cpp person.cpp)`**
  - Creates an **executable** named `rooster`.
  - This executable is built from **two source files**: `main.cpp` and `person.cpp`.

---

```cmake
target_include_directories(rooster PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
```
#### **7. Set Include Directories**
- **`target_include_directories(rooster PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})`**
  - Ensures that `rooster` can include header files from the **current source directory**.
  - **Why `PRIVATE`?**
    - `PRIVATE` means that these include directories **only affect** `rooster` and **not** any other targets that might depend on it.

---

```cmake
include(ClangFormat)
```
#### **8. Include the ClangFormat Module**
- **What it does:** Loads the `ClangFormat.cmake` script.
- **How does it find `ClangFormat.cmake`?**
  - Because of the earlier `list(APPEND CMAKE_MODULE_PATH ...)`, CMake will look in `cmake/` and find `ClangFormat.cmake`.

---

```cmake
add_clang_format_target(format-code ${PROJECT_SOURCE_DIR})
```
#### **9. Add a Clang Format Custom Target**
- **What it does:** Calls the `add_clang_format_target` function (which is defined in `ClangFormat.cmake`).
- **Parameters:**
  - `format-code`: The name of the custom target.
  - `${PROJECT_SOURCE_DIR}`: The directory to apply formatting to (i.e., the entire project).

---

```cmake
# add_dependencies(rooster format-code)
```
#### **10. Optional: Make Code Formatting a Build Dependency**
- **What this line would do (if uncommented):**
  - Ensures that the `rooster` target **depends on** `format-code`.
  - This means **CMake would run `clang-format` before compiling** `rooster`.

- **Why is it commented out?**
  - Because it might be **undesirable** to force formatting every time the project is built.
  - Instead, the user can manually run:
    ```sh
    cmake --build . --target format-code
    ```
    to format the code.

## Explaination of `ClangFormat.cmake`

This file defines a **custom CMake function** to create a **formatting target** that automatically applies `clang-format` to all `.cpp` and `.h` files in the project.

### **Code Breakdown**
#### **1. Define a Function**
```cmake
function(add_clang_format_target TARGET_NAME SOURCE_DIR)
```
- **What it does:** Defines a **CMake function** called `add_clang_format_target`.
- **Parameters:**
  - `TARGET_NAME`: The name of the **custom target** (e.g., `format-code`).
  - `SOURCE_DIR`: The **directory** where source files are located.

- **Why use a function?**
  - Functions make it **easy to reuse** this logic for multiple projects.
  - Instead of duplicating commands, you can just call:
    ```cmake
    add_clang_format_target(format-code ${PROJECT_SOURCE_DIR})
    ```

---

#### **2. Find the `clang-format` Executable**
```cmake
find_program(CLANG-FORMAT_PATH clang-format REQUIRED)
```
- **What it does:** Searches for the `clang-format` executable on the system and stores its path in `CLANG-FORMAT_PATH`.
- **Why `REQUIRED`?**
  - If `clang-format` is **not installed**, CMake will **stop with an error**.

- **Example Output:**
  - If found: `CLANG-FORMAT_PATH = /usr/bin/clang-format`
  - If not found: CMake will show an error like:
    ```
    CMake Error: Cannot find program "clang-format"
    ```

---

#### **3. Collect All Source Files**
```cmake
file(GLOB_RECURSE FORMAT_SOURCES
    LIST_DIRECTORIES false
    "${SOURCE_DIR}/*.cpp"
    "${SOURCE_DIR}/*.h"
)
```
- **What it does:** Finds **all** `.cpp` and `.h` files **recursively** in `SOURCE_DIR`.
- **Breakdown:**
  - `GLOB_RECURSE`: Searches in **subdirectories** as well.
  - `LIST_DIRECTORIES false`: Ensures **only files** are selected (not folders).
  - `"${SOURCE_DIR}/*.cpp"`: Includes all `.cpp` files.
  - `"${SOURCE_DIR}/*.h"`: Includes all `.h` files.

- **Example Output (if `SOURCE_DIR = src/`):**
  ```
  FORMAT_SOURCES = src/main.cpp src/utils/helper.cpp src/utils/helper.h
  ```

- **Why not use `file(GLOB)` instead of `GLOB_RECURSE`?**
  - `file(GLOB)` only looks in **one directory**, while `GLOB_RECURSE` searches **subdirectories** too.

---

#### **4. Create a Custom Target**
```cmake
add_custom_target(${TARGET_NAME}
    COMMAND ${CLANG-FORMAT_PATH} -i ${FORMAT_SOURCES}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMENT "Running clang-format on ${SOURCE_DIR} sources"
)
```
##### **What is a Custom Target?**
- A **custom target** in CMake is a command that runs **when manually invoked**.
- Unlike executables or libraries, custom targets **don't produce files**—they run commands.

##### **Breakdown**
| Command | Explanation |
|---------|------------|
| **`add_custom_target(${TARGET_NAME} ... )`** | Creates a new **custom target** with the given name (`format-code`). |
| **`COMMAND ${CLANG-FORMAT_PATH} -i ${FORMAT_SOURCES}`** | Runs `clang-format -i` on all source files (modifies files **in place**). |
| **`WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}`** | Runs the command from the **project root**. |
| **`COMMENT "Running clang-format on ${SOURCE_DIR} sources"`** | Displays this message when running the command. |

---

#### **Example: Running the Target**
If `CMakeLists.txt` includes:
```cmake
add_clang_format_target(format-code ${PROJECT_SOURCE_DIR})
```
Then, after configuring CMake, you can run:
```sh
cmake --build . --target format-code
```
Output:
```
[100%] Running clang-format on /home/user/my_project sources
```
All `.cpp` and `.h` files will be **formatted automatically**.

---

#### **5. Making Formatting a Build Dependency (Optional)**
In `CMakeLists.txt`, this line is **commented out**:
```cmake
# add_dependencies(rooster format-code)
```
- **If uncommented:**
  - `format-code` **must run** before `rooster` is built.
- **If kept commented out:**
  - Formatting is **optional** and must be run manually.
