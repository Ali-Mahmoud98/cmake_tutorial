# Targets : Executables, Binaries , C++ Standars and More

Here we will focus on cmake targets and explore different kinds of targets you can set up with your cmake projects. A two examples will be provided:
* [example1](./example1/): Building a C++ Project as a single target
* [example2](./example2/): Building a C++ Project with Modular Library Targets

## Useful TIPS:
* To see the all the cmake varaiables that you can use in cmake, run:
```bash
cmake --help-variable-list
```
* To see the all the cmake varaiables that and there values, run:
```bash
cmake --system-information info.txt
vi info.txt
```
* To set a cmake variable, when you run cmake, run:
```bash
# cmake -D"variable_name"="value" ..
cmake -DCMAKE_CXX_STANDARD=20 ..
```
* To set a cmake variable in CMakeLists.txt you can use `set` command:
```bash
set(CMAKE_CXX_STANDARD 20)
```
