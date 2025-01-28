# CMake Macros

CMake macros are reusable blocks of code similar to functions, but they differ significantly in terms of behavior, especially when it comes to variable scoping and argument handling. Macros can simplify your CMake scripts by allowing repetitive tasks to be defined once and reused throughout your project.

* [**Macros - Cmake Documentation**](https://cmake.org/cmake/help/latest/command/macro.html)

---

### Syntax of a Macro

```cmake
macro(<name> [arg1 [arg2 ...]])
    # Commands to execute
endmacro()
```

- `<name>`: The name of the macro.
- `[arg1, arg2, ...]`: Optional arguments passed to the macro.

---

### Key Characteristics of CMake Macros

1. **Global Variable Scope**:
   - Unlike functions, macros do not create a new scope. Variables defined or modified inside a macro affect the global scope or the scope where the macro was called.

2. **Argument Handling**:
   - Macro arguments are treated as plain text substitutions, making them less predictable than functions.
   - Arguments are accessed by their names or using variables like `${ARGC}`, `${ARGV}`, `${ARGV0}`, etc.

3. **Code Substitution**:
   - A macro essentially performs a text substitution of its contents into the call site, which can lead to unexpected behavior if not carefully managed.

4. **Less Encapsulation**:
   - Macros do not isolate changes to variables or commands, making them less suitable for modular or complex code.

---

### Example 1: A Simple Macro
```cmake
macro(print_message msg)
    message("Message: ${msg}")
endmacro()

# Usage
print_message("Hello, CMake!")
```

Output:
```
Message: Hello, CMake!
```

---

### Example 2: Accessing All Arguments
```cmake
macro(show_args)
    message("Number of arguments: ${ARGC}")
    message("All arguments: ${ARGV}")
    foreach(arg IN LISTS ARGV)
        message("Argument: ${arg}")
    endforeach()
endmacro()

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

### Example 3: Variable Scope Issue
```cmake
macro(set_variable)
    set(MY_VAR "Global Value")
endmacro()

set_variable()
message("MY_VAR: ${MY_VAR}")
```

Output:
```
MY_VAR: Global Value
```

> Note: The variable `MY_VAR` is modified in the calling scope because macros do not create a new variable scope.

---

### Comparison Between Functions and Macros

| Feature                       | Function                                       | Macro                                         |
|-------------------------------|-----------------------------------------------|-----------------------------------------------|
| **Scope**                     | Creates a local scope for variables           | Inherits and modifies the calling scope       |
| **Encapsulation**             | Changes are isolated to the function          | Changes affect the calling scope globally     |
| **Argument Handling**         | Explicit and predictable                      | Plain text substitution (less predictable)    |
| **Use Case**                  | Recommended for modular, reusable code        | Suitable for simple, repetitive tasks         |
| **Complexity Handling**       | Suitable for complex logic                    | Difficult to use in complex scenarios         |
| **Return Values**             | Can return values using `PARENT_SCOPE`        | No direct return mechanism                    |
| **Performance**               | Slightly slower due to scope creation         | Faster due to simple text substitution        |
| **Debugging**                 | Easier to debug (isolated scope and logic)    | Harder to debug due to global scope changes   |

---

### NOTE

Use **functions** for most scenarios, especially when modularity, maintainability, and predictable behavior are important. Reserve **macros** for very simple, repetitive tasks where scope isolation is not a concern. If you're working on a specific project (e.g., in embedded Linux or Thunder), let me know, and I can provide tailored examples!
