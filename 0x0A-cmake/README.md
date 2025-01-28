# CMake loops

In CMake, loops are used to iterate over lists or perform repetitive tasks. CMake provides two main types of loops:

1. **`foreach` Loop**: Iterates over a list of items.
2. **`while` Loop**: Repeats a block of code as long as a condition is true.

Let’s explore each type of loop in detail, with examples.

---

### 1. `foreach` Loop

* [**Foreach Loop - Cmake Documentation**](https://cmake.org/cmake/help/latest/command/foreach.html)

The `foreach` loop is used to iterate over a list of items. It is particularly useful when you need to perform the same operation on multiple items, such as files in a directory or targets in a project.

#### Syntax
```cmake
foreach(loop_var IN [LISTS list1] [ITEMS item1 item2 ...])
    # Code to execute for each item
endforeach()
```

- `loop_var`: The variable that takes the value of each item in the list.
- `LISTS`: Specifies a list variable to iterate over.
- `ITEMS`: Specifies individual items to iterate over.

#### Example 1: Iterate Over a List
```cmake
set(MY_LIST "apple" "banana" "cherry")

foreach(FRUIT IN LISTS MY_LIST)
    message("Fruit: ${FRUIT}")
endforeach()
```

**Output**:
```
Fruit: apple
Fruit: banana
Fruit: cherry
```

#### Example 2: Iterate Over Items
```cmake
foreach(NUMBER IN ITEMS 1 2 3 4 5)
    message("Number: ${NUMBER}")
endforeach()
```

**Output**:
```
Number: 1
Number: 2
Number: 3
Number: 4
Number: 5
```

#### Example 3: Nested `foreach` Loops
```cmake
set(FRUITS "apple" "banana")
set(COLORS "red" "yellow")

foreach(FRUIT IN LISTS FRUITS)
    foreach(COLOR IN LISTS COLORS)
        message("${FRUIT} is ${COLOR}")
    endforeach()
endforeach()
```

**Output**:
```
apple is red
apple is yellow
banana is red
banana is yellow
```

---

### 2. `while` Loop

The `while` loop repeats a block of code as long as a condition is true. It is useful for tasks that require repeated execution until a specific condition is met.

#### Syntax
```cmake
while(condition)
    # Code to execute while the condition is true
endwhile()
```

- `condition`: A CMake expression that evaluates to `true` or `false`.

#### Example 1: Simple Counter
```cmake
set(COUNTER 0)

while(COUNTER LESS 5)
    message("Counter: ${COUNTER}")
    math(EXPR COUNTER "${COUNTER} + 1")
endwhile()
```

**Output**:
```
Counter: 0
Counter: 1
Counter: 2
Counter: 3
Counter: 4
```

#### Example 2: Iterate Until a Condition is Met
```cmake
set(VALUE 10)

while(VALUE GREATER 0)
    message("Value: ${VALUE}")
    math(EXPR VALUE "${VALUE} - 2")
endwhile()
```

**Output**:
```
Value: 10
Value: 8
Value: 6
Value: 4
Value: 2
```

---

### Combining Loops with Other CMake Features

#### Example: Generate Source Files
You can use a loop to generate source files or targets dynamically.

```cmake
set(SOURCES "main.cpp" "utils.cpp" "math.cpp")

foreach(SOURCE IN LISTS SOURCES)
    add_executable(${SOURCE}_exec ${SOURCE})
endforeach()
```

This creates three executables: `main.cpp_exec`, `utils.cpp_exec`, and `math.cpp_exec`.

#### Example: Process Files in a Directory
You can use a loop to process files in a directory.

```cmake
file(GLOB MY_FILES "*.txt")

foreach(FILE IN LISTS MY_FILES)
    message("Processing file: ${FILE}")
endforeach()
```

This lists all `.txt` files in the current directory and processes them.

---

### Summary

- **`foreach` Loop**:
  - Iterates over a list of items.
  - Useful for processing multiple items, such as files or targets.
  - Supports nested loops for more complex scenarios.

- **`while` Loop**:
  - Repeats a block of code as long as a condition is true.
  - Useful for tasks that require repeated execution until a condition is met.

- **Use Cases**:
  - Generating multiple targets or files.
  - Processing lists of items.
  - Implementing custom logic with conditions.

Loops are a powerful feature in CMake that allow you to automate repetitive tasks and make your build scripts more dynamic and flexible.
