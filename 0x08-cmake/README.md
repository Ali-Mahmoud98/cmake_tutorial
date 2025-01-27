# CMake list and option commands

CMake provides robust features to work with **lists** and **options**, which are widely used for configuring and managing project settings, handling multiple items, and making the build system flexible.

**EXAMPLE:** [list_option.cmake](./list_option.cmake)

---

## **1. Lists in CMake**
CMake lists are a single string where individual elements are separated by semicolons (`;`). Lists are used to store and manipulate multiple items like filenames, directories, or configuration options.

### **Creating a List**
You can create a list using the `set()` command:
```cmake
set(MY_LIST item1 item2 item3)
# Equivalent to: set(MY_LIST "item1;item2;item3")
```

### **Accessing List Elements**
To access specific elements, use the `list(GET)` command:
```cmake
list(GET MY_LIST 0 first_element) # Gets the first element (item1)
message("First Element: ${first_element}")
```

### **Manipulating Lists**
CMake provides several commands for modifying and handling lists:

#### **Adding Elements**
```cmake
list(APPEND MY_LIST item4 item5)
# MY_LIST = "item1;item2;item3;item4;item5"
```

#### **Prepending Elements**
```cmake
list(INSERT MY_LIST 0 new_item)
# MY_LIST = "new_item;item1;item2;item3;item4;item5"
```

#### **Removing Elements**
```cmake
list(REMOVE_ITEM MY_LIST item2 item3)
# MY_LIST = "new_item;item1;item4;item5"
```

#### **Finding an Element**
```cmake
list(FIND MY_LIST item4 index)
if(NOT index EQUAL -1)
    message("item4 found at index: ${index}")
else()
    message("item4 not found")
endif()
```

#### **Getting List Length**
```cmake
list(LENGTH MY_LIST length)
message("List Length: ${length}")
```

#### **Slicing a List**
```cmake
list(SUBLIST MY_LIST 1 3 sub_list)
# Extracts a sublist starting at index 1 with 3 elements
message("Sublist: ${sub_list}")
```

### **Using Lists in Loops**
Lists are commonly used in loops:
```cmake
foreach(item IN LISTS MY_LIST)
    message("List Item: ${item}")
endforeach()
```

---

## **2. Options in CMake**
CMake options are simple ON/OFF toggles used for conditional configurations and settings in your build system. They are useful for enabling/disabling features during the build process.

### **Defining an Option**
The `option()` command is used to declare an option:
```cmake
option(MY_OPTION "Enable feature X" OFF)
```
- **`MY_OPTION`**: The name of the option variable.
- **Description**: Explains the purpose of the option.
- **Default Value**: `ON` or `OFF`.

### **Using Options**
After declaring an option, you can use it in conditional statements:
```cmake
if(MY_OPTION)
    message("Feature X is enabled")
else()
    message("Feature X is disabled")
endif()
```

### **Overriding an Option**
Options can be set when invoking `cmake` using `-D`:
```bash
cmake -DMY_OPTION=ON ..
```

---

## **Examples Combining Lists and Options**
### **Example: Using an Option to Control a List**
```cmake
option(ENABLE_MODULES "Enable specific modules" ON)

if(ENABLE_MODULES)
    set(MODULES_LIST module1 module2 module3)
else()
    set(MODULES_LIST module1)
endif()

foreach(module IN LISTS MODULES_LIST)
    message("Building: ${module}")
endforeach()
```

---

## **Key Takeaways**
### **Lists**:
- Store and manage multiple items (filenames, configurations, etc.).
- Provide commands for adding, removing, finding, and slicing elements.
- Useful in loops for iterating over multiple items.

### **Options**:
- Simple ON/OFF variables for conditional configurations.
- Default to `ON` or `OFF` but can be overridden during configuration with `-D`.
- Perfect for toggling features, enabling modules, or controlling build settings. 

By combining **lists** and **options**, you can create flexible, scalable, and user-friendly build systems in CMake.
