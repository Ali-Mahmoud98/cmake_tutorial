# CMake - making decisions - the if command

### References:
* [**If/else - Cmake Documentation**](https://cmake.org/cmake/help/latest/command/if.html)

### Basic Syntax of `if` Command

```cmake
if(condition)
    # Code to execute if the condition is true
elseif(another_condition)
    # Code to execute if another_condition is true
else()
    # Code to execute if none of the above conditions are true
endif()
```

### Common Conditions in `if` Command

1. **Variable Evaluation**:
   - Check if a variable is defined: `if(DEFINED VAR_NAME)`
   - Check if a variable is true: `if(VAR_NAME)`
   - Check if a variable is false: `if(NOT VAR_NAME)`

2. **String Comparison**:
   - Check if two strings are equal: `if("${VAR_NAME}" STREQUAL "value")`
   - Check if two strings are not equal: `if(NOT "${VAR_NAME}" STREQUAL "value")`

3. **File Operations**:
   - Check if a file exists: `if(EXISTS path/to/file)`
   - Check if a directory exists: `if(IS_DIRECTORY path/to/directory)`

4. **Logical Operators**:
   - Combine conditions using `AND`, `OR`, and `NOT`.

### Example Using Script Mode

Let's create a simple CMake script that demonstrates the use of the `if` command.

```cmake
# CMake script to demonstrate the if command

# Set some variables
set(MY_VARIABLE "Hello")
set(ANOTHER_VARIABLE "World")
set(ENABLE_FEATURE ON)

# Example 1: Simple variable check
if(MY_VARIABLE)
    message(STATUS "MY_VARIABLE is defined and not empty.")
else()
    message(STATUS "MY_VARIABLE is not defined or empty.")
endif()

# Example 2: String comparison
if("${MY_VARIABLE}" STREQUAL "Hello")
    message(STATUS "MY_VARIABLE is equal to 'Hello'.")
else()
    message(STATUS "MY_VARIABLE is not equal to 'Hello'.")
endif()

# Example 3: Logical operators
if(ENABLE_FEATURE AND "${MY_VARIABLE}" STREQUAL "Hello")
    message(STATUS "Feature is enabled and MY_VARIABLE is 'Hello'.")
else()
    message(STATUS "Feature is not enabled or MY_VARIABLE is not 'Hello'.")
endif()

# Example 4: File existence check
if(EXISTS "${CMAKE_SOURCE_DIR}/CMakeLists.txt")
    message(STATUS "CMakeLists.txt exists in the source directory.")
else()
    message(STATUS "CMakeLists.txt does not exist in the source directory.")
endif()

# Example 5: Nested if-else
if(ANOTHER_VARIABLE)
    if("${ANOTHER_VARIABLE}" STREQUAL "World")
        message(STATUS "ANOTHER_VARIABLE is 'World'.")
    else()
        message(STATUS "ANOTHER_VARIABLE is not 'World'.")
    endif()
else()
    message(STATUS "ANOTHER_VARIABLE is not defined or empty.")
endif()
```

### Explanation of the Script

1. **Variable Check**: The script checks if `MY_VARIABLE` is defined and not empty.
2. **String Comparison**: It compares the value of `MY_VARIABLE` with the string `"Hello"`.
3. **Logical Operators**: It checks if `ENABLE_FEATURE` is `ON` and if `MY_VARIABLE` is `"Hello"`.
4. **File Existence**: It checks if `CMakeLists.txt` exists in the source directory.
5. **Nested `if-else`**: It demonstrates nested `if-else` statements by checking the value of `ANOTHER_VARIABLE`.

### Running the Script

To run this script, save it to a file (e.g., `example.cmake`) and execute it using CMake's script mode:

```bash
cmake -P example.cmake
```

This will output the status messages based on the conditions evaluated in the script.
