### **CMake: `message` Command, Project Mode, and Script Mode**

**`CMake`** is a versatile tool used for managing build systems and automating tasks. This guide explains two fundamental aspects of **`CMake`**: the `message` command and the distinction between Project Mode and Script Mode. Below is an organized explanation with a table of contents for clarity.
The `message` command can be used as learning tool.

---

### **Table of Contents**

1. [The `message` Command in CMake](https://chatgpt.com/c/678ddf47-6d98-8005-ad1a-7758a5dd741d#1-the-message-command-in-cmake)
    
    - [Introduction](https://chatgpt.com/c/678ddf47-6d98-8005-ad1a-7758a5dd741d#introduction)
    - [Syntax](https://chatgpt.com/c/678ddf47-6d98-8005-ad1a-7758a5dd741d#syntax)
    - [Modes of `message`](https://chatgpt.com/c/678ddf47-6d98-8005-ad1a-7758a5dd741d#modes-of-message)
    - [Use Cases](https://chatgpt.com/c/678ddf47-6d98-8005-ad1a-7758a5dd741d#use-cases)
    - [Best Practices](https://chatgpt.com/c/678ddf47-6d98-8005-ad1a-7758a5dd741d#best-practices)
2. [CMake Modes: Project and Script](https://chatgpt.com/c/678ddf47-6d98-8005-ad1a-7758a5dd741d#2-cmake-modes-project-and-script)
    
    - [1. Project Mode](https://chatgpt.com/c/678ddf47-6d98-8005-ad1a-7758a5dd741d#1-project-mode)
        
        - [Key Features](https://chatgpt.com/c/678ddf47-6d98-8005-ad1a-7758a5dd741d#key-features)
        - [Usage and Example](https://chatgpt.com/c/678ddf47-6d98-8005-ad1a-7758a5dd741d#usage-and-example)
        - [Common Use Cases](https://chatgpt.com/c/678ddf47-6d98-8005-ad1a-7758a5dd741d#common-use-cases)
    - [2. Script Mode](https://chatgpt.com/c/678ddf47-6d98-8005-ad1a-7758a5dd741d#2-script-mode)
        
        - [Key Features](https://chatgpt.com/c/678ddf47-6d98-8005-ad1a-7758a5dd741d#key-features-1)
        - [Usage and Example](https://chatgpt.com/c/678ddf47-6d98-8005-ad1a-7758a5dd741d#usage-and-example-1)
        - [Common Use Cases](https://chatgpt.com/c/678ddf47-6d98-8005-ad1a-7758a5dd741d#common-use-cases-1)
3. [Comparison of Project and Script Modes](https://chatgpt.com/c/678ddf47-6d98-8005-ad1a-7758a5dd741d#3-comparison-of-project-and-script-modes)
    

---

### **1. The `message` Command in CMake**

#### **Introduction**

The `message` command in `**CMake**` is used to output messages during the configuration process. It helps developers communicate progress, debugging information, or errors to the user.

#### **Syntax**

```cmake
message([<mode>] "message text")
```

- `<mode>`: Specifies the message type (optional).
- `"message text"`: The content of the message.

#### **Modes of `message`**

1. **STATUS**: For general information (default priority).  
    Example: `message(STATUS "Configuring project...")`
2. **WARNING**: For non-critical issues.  
    Example: `message(WARNING "Default values used.")`
3. **AUTHOR_WARNING**: Warnings for project authors.  
    Example: `message(AUTHOR_WARNING "Feature is deprecated.")`
4. **SEND_ERROR**: Outputs an error and stops processing the `CMakeLists.txt` file.  
    Example: `message(SEND_ERROR "Critical dependency missing.")`
5. **FATAL_ERROR**: Immediately halts the configuration process.  
    Example: `message(FATAL_ERROR "Unsupported platform!")`
6. **DEPRECATION**: Warns about deprecated functionality.  
    Example: `message(DEPRECATION "This feature will be removed.")`

#### **Use Cases**

- **Progress Updates**:
    
    ```cmake
    message(STATUS "Finding dependencies...")
    ```
    
- **Debugging Information**:
    
    ```cmake
    message(STATUS "CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")
    ```
    
- **Error Handling**:
    
    ```cmake
    if (NOT EXISTS ${CMAKE_SOURCE_DIR}/file.txt)
        message(FATAL_ERROR "file.txt not found!")
    endif()
    ```
    

#### **Best Practices**

- Use `STATUS` for non-critical messages.
- Reserve `WARNING` or `ERROR` modes for actionable issues.
- Ensure error messages are clear and concise.

---

### **2. CMake Modes: Project and Script**

CMake operates in **two distinct modes**: **Project Mode** and **Script Mode**. These modes determine how CMake processes input files and are suited for different purposes.

---

#### **1. Project Mode**

##### **Key Features**

- **Build System Generation**: Produces build files like Makefiles or Visual Studio solutions.
- **Targets**: Define and configure executables, libraries, and custom commands.
- **Multi-Platform Support**: Handles platform-specific tools and dependencies.

##### **Usage and Example**

Run CMake to generate build files:

```bash
cmake -S <source_dir> -B <build_dir>
cmake --build <build_dir>
```

Example `CMakeLists.txt`:

```cmake
cmake_minimum_required(VERSION 3.20)
project(MyProject LANGUAGES CXX)

add_executable(MyApp main.cpp)
```

##### **Common Use Cases**

- Managing software builds across platforms.
- Setting up project-specific configurations and dependencies.

---

#### **2. Script Mode**

##### **Key Features**

- **Scripting Environment**: Executes `.cmake` scripts directly.
- **Task Automation**: Perform custom tasks like file manipulation or system checks.
- **No Build System Generation**: Does not create Makefiles or other build files.

##### **Usage and Example**

Run a script using the `-P` flag:

```bash
cmake -P script.cmake
```

Example Script (`example.cmake`):

```cmake
message(STATUS "Running a script...")
file(WRITE "output.txt" "Generated by CMake script.\n")
message(STATUS "File created: output.txt")
```

##### **Common Use Cases**

- Writing custom deployment or configuration scripts.
- Testing configurations or automating small tasks.

---

### **3. Comparison of Project and Script Modes**

|Feature|Project Mode|Script Mode|
|---|---|---|
|**Purpose**|Generate build files for a project.|Execute custom scripts.|
|**Input**|`CMakeLists.txt`.|`.cmake` files.|
|**Output**|Build system files (e.g., Makefiles).|Depends on script logic.|
|**Command Example**|`cmake -S . -B build`|`cmake -P script.cmake`|
