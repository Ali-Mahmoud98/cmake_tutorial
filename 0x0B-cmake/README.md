# CMake Functions

* [**Functions - Cmake Documentation**](https://cmake.org/cmake/help/latest/command/function.html)

CMake functions are reusable blocks of code designed to perform specific tasks within a CMake project. They allow you to organize, simplify, and modularize your CMake scripts. Functions are similar to macros in CMake, but they have different scoping rules, which makes them more predictable in certain scenarios.

### Syntax of a CMake Function

```cmake
function(<name> [arg1 [arg2 ...]])
    # Commands to execute
endfunction()
```

- `<name>`: The name of the function.
- `[arg1, arg2, ...]`: Optional arguments passed to the function.

### Key Characteristics of CMake Functions

1. **Scoped Variables**: 
   - Variables created inside a function are local to that function unless explicitly marked as global using `set(... PARENT_SCOPE)`.

2. **Argument Handling**:
   - Arguments are accessible through variables like `${ARGC}` (count of arguments), `${ARGV}` (all arguments), and `${ARGV0}`, `${ARGV1}`, etc., for individual arguments.
   - Named arguments can be handled by defining parameter names in the function definition.

3. **Modularity**:
   - Functions make your `CMakeLists.txt` easier to read and maintain by encapsulating reusable code.

4. **Return Behavior**:
   - Unlike macros, functions do not directly modify variables in the parent scope unless explicitly instructed.

---

### Example 1: A Simple Function
```cmake
function(print_message msg)
    message("Message: ${msg}")
endfunction()

# Usage
print_message("Hello, CMake!")
```

Output:
```
Message: Hello, CMake!
```

---

### Example 2: Using All Arguments
```cmake
function(show_args)
    message("Number of arguments: ${ARGC}")
    message("All arguments: ${ARGV}")
    foreach(arg IN LISTS ARGV)
        message("Argument: ${arg}")
    endforeach()
endfunction()

# Usage
show_args(Apple Banana Cherry)
```

Output:
```
Number of arguments: 3
All arguments: Apple;Banana;Cherry
Argument: Apple
Argument: Banana
Argument: Cherry
```

---

### Example 3: Accessing Parent Scope
```cmake
function(set_global_variable)
    set(MY_VAR "Hello from Function" PARENT_SCOPE)
endfunction()

set_global_variable()
message("MY_VAR: ${MY_VAR}")
```

Output:
```
MY_VAR: Hello from Function
```

---

### Functions vs. Macros in CMake

| Feature                   | Function               | Macro                   |
|---------------------------|------------------------|-------------------------|
| **Variable Scope**        | Local                 | Inherits parent's scope |
| **Argument Handling**     | Explicit, predictable | Global, less predictable |
| **Recommended for Reuse** | Yes                   | Not recommended         |

---

### Practical Applications
1. **Encapsulation**: Use functions to group related commands for clarity.
2. **Reusability**: Write once, use multiple times across the project.
3. **Scoping**: Safely work with variables without affecting parent scope unless required.

By effectively using CMake functions, you can build modular and maintainable CMake configurations. If you want examples tailored to a specific context (e.g., for embedded projects or Thunder framework), let me know!
