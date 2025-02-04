# CMake - Dependency Management: FetchContent

**EXAMPLE: [CMake - Dependency Management: `FetchContent`](https://github.com/rutura/CMakeSeries/tree/main/Ep021)**

In this one, we're going to talk about an important topic in software development, which is using third-party dependencies in C++. This is a very painful topic in C++.

If you're writing your application using the C++ standard library and don't need to bring in external dependencies, you're good. However, the moment you need to bring in a third-party library, you'll face one of the main problems of C++: using third-party dependencies.

Suppose you are writing your application and at some point you need to bring bring in `GUI` library for example lets say you want to use something like `Qt GUI` or something as simple as `SFML`, how do you do that?

* **The Usual Way or Manual Way:**

The usual way to do this is to manually fetch those dependencies, build them on your local machine, and then integrate them into your project. This is a very error-prone process. Many people who give up on C++ give up for this reason.

* **Fetch Content:**

Luckily, C++ provides a way to fetch dependencies using the `fetch_content` module. This module helps you bring in dependencies and use them in your project.

To use `fetch_content`, you need to include the module and then declare the dependency you want to fetch. You specify the name of the dependency, the repository where it's located, and the tag of the release you want to use.

# **📌 What is `FetchContent` in CMake?**
`FetchContent` is a CMake **module** that allows you to:
✅ **Download** external dependencies (Git repositories, tarballs, URLs).  
✅ **Include them directly** in your project.  
✅ **Avoid manual installation** of dependencies.  
✅ **Ensure version control** for dependencies.  

---

# **📌 Why Use `FetchContent` Instead of Other Methods?**
### **Comparison: Different Ways to Manage Dependencies**
| Method | Pros | Cons |
|--------|------|------|
| **Manual Installation** | No extra CMake complexity | Requires users to install dependencies manually |
| **FindPackage()** | Uses installed system libraries | Requires the library to be pre-installed |
| **FetchContent** ✅ | Automatically downloads, builds, and integrates dependencies | Slightly increases build time (but only on first run) |
| **ExternalProject_Add** | More flexible, supports more complex builds | Harder to integrate, requires separate builds |

---

# **📌 How to Use `FetchContent` in CMake**
### **Step 1: Include `FetchContent`**
To use `FetchContent`, you **must include** the module:
```cmake
include(FetchContent)
```
This loads the module and makes its functions available.

---

### **Step 2: Declare a Dependency**
Use `FetchContent_Declare()` to specify:
- The **dependency name**
- The **Git repository URL** or other download method
- The **version (commit, tag, or branch)**

**Example: Fetching `fmt` (a popular C++ formatting library)**
```cmake
FetchContent_Declare(
    fmt
    GIT_REPOSITORY https://github.com/fmtlib/fmt.git
    GIT_TAG 10.1.0  # Use a specific version (recommended)
)
```
> **✅ Best Practice:** Always specify a version (`GIT_TAG`) to ensure builds are **reproducible**.

---

### **Step 3: Download and Make It Available**
```cmake
FetchContent_MakeAvailable(fmt)
```
This **downloads, configures, and builds** the dependency **inside your project**.

---

### **Step 4: Link the Dependency to Your Project**
After fetching the dependency, you can link it to your target:
```cmake
add_executable(my_project main.cpp)
target_link_libraries(my_project PRIVATE fmt)
```
Now, `my_project` **can use `fmt`** without requiring manual installation.

---

# **📌 Full Example: Using `FetchContent`**
```cmake
cmake_minimum_required(VERSION 3.14)  # FetchContent requires at least CMake 3.14
project(FetchExample)

include(FetchContent)  # Load FetchContent module

# Declare fmt as a dependency
FetchContent_Declare(
    fmt
    GIT_REPOSITORY https://github.com/fmtlib/fmt.git
    GIT_TAG 10.1.0  # Ensure reproducibility
)

# Fetch and make available
FetchContent_MakeAvailable(fmt)

# Create an executable
add_executable(my_project main.cpp)

# Link fmt to my_project
target_link_libraries(my_project PRIVATE fmt)
```
Now you can use `fmt` in `main.cpp`:
```cpp
#include <fmt/core.h>

int main() {
    fmt::print("Hello, FetchContent!\n");
}
```

---

# **📌 Advanced `FetchContent` Features**
## **1️⃣ Checking If Content Is Already Fetched**
Fetching content **multiple times** can be inefficient. To check if it's already been fetched:
```cmake
FetchContent_GetProperties(fmt)
if(NOT fmt_POPULATED)
    FetchContent_Populate(fmt)
    add_subdirectory(${fmt_SOURCE_DIR} ${fmt_BINARY_DIR})
endif()
```
- `FetchContent_GetProperties(fmt)`: Checks if `fmt` is already included.
- `FetchContent_Populate(fmt)`: Fetches `fmt` **only if necessary**.
- `add_subdirectory()`: Manually adds the library if needed.

---

## **2️⃣ Using `FetchContent_Declare()` for Multiple Dependencies**
You can **declare multiple dependencies** like this:
```cmake
FetchContent_Declare(
    spdlog
    GIT_REPOSITORY https://github.com/gabime/spdlog.git
    GIT_TAG v1.11.0
)

FetchContent_Declare(
    json
    GIT_REPOSITORY https://github.com/nlohmann/json.git
    GIT_TAG v3.11.2
)

FetchContent_MakeAvailable(spdlog json)
```
Now, both **`spdlog`** and **`json`** will be available.

---

## **3️⃣ Fetching from a URL Instead of Git**
You can also fetch a **tarball/zip file** instead of cloning a Git repo:
```cmake
FetchContent_Declare(
    example_lib
    URL https://example.com/some_library.zip
)
FetchContent_MakeAvailable(example_lib)
```

---

# **📌 Pros & Cons of `FetchContent`**
| ✅ **Pros** | ❌ **Cons** |
|------------|------------|
| No need for system-wide installation | Requires an internet connection for the first build |
| Works across all platforms (Windows, Linux, macOS) | Can increase initial build time |
| Ensures version consistency across builds | Requires CMake 3.14+ |
| Easy to integrate with existing CMake projects | Not ideal for extremely large dependencies |

---

# **📌 When Should You Use `FetchContent`?**
✅ **Recommended For:**
- Small-to-medium dependencies (like `fmt`, `spdlog`, `json`).
- Projects where you **don’t want** users to manually install dependencies.
- Ensuring **consistent versions** across different machines.

❌ **Not Ideal For:**
- **Huge dependencies** (like Boost or Qt) → Better to use `FindPackage()`.
- Projects where dependencies **should be installed system-wide**.
- Libraries that require **complex build steps**.

---

# **📌 Summary**
| Feature | Description |
|---------|------------|
| **What is `FetchContent`?** | A CMake module to download and integrate dependencies automatically. |
| **Key Functions** | `FetchContent_Declare()`, `FetchContent_MakeAvailable()`, `FetchContent_Populate()`. |
| **Best Practices** | Always specify a `GIT_TAG`, check if dependencies are already fetched. |
| **Alternative to** | `FindPackage()`, `ExternalProject_Add()`, and manual installations. |
| **Ideal for** | Small-to-medium dependencies, keeping builds portable. |

# REFERENCES
* [FetchContent](https://cmake.org/cmake/help/latest/module/FetchContent.html)
* [Using Dependencies Guide](https://cmake.org/cmake/help/latest/guide/using-dependencies/index.html)
