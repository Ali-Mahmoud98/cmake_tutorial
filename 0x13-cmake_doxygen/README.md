# CMake - Generating the documentation with Doxygen: Doxyfile

CMake is widely used for managing the build process of C++ projects, and Doxygen is a popular tool for generating documentation from annotated source code. When using Doxygen in a CMake-based project, you typically configure a **Doxyfile**, which is a configuration file that dictates how Doxygen generates documentation.

### RESOURCES:
* [DOXYGEN Documentation](https://www.doxygen.nl/manual/index.html)

---

### **1. What is Doxygen?**
Doxygen is a tool that extracts comments from source code (C, C++, Python, Java, etc.) and generates documentation in various formats such as HTML, PDF, and LaTeX. By adding structured comments (using `///`, `/** */`, or `/*! */`), developers can create user-friendly documentation directly from code.

---

### **2. What is a Doxyfile?**
A **Doxyfile** is a configuration file that tells Doxygen how to generate documentation. It defines various parameters, such as input files, output formats, and additional options.

The Doxyfile can be generated using the following command:
```sh
doxygen -g Doxyfile
```
This creates a template Doxyfile that you can modify to fit your project’s needs.

### COMMANDS:
```bash
cmake . -B build
# to generate the documentation run:
cmake --build build -t documentation

# build the project
cmake --build build

# run the program
./build/rooster

# run tests
./build/test/unit_tests
```
