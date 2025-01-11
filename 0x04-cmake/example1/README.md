# Example Building a C++ Project as a single target

To build this project, run the following command:
* On Linux:
```bash
mkdir build && cd build && cmake .. && make
# or
# mkdir build && cd build && cmake -G"YourGenerator" .. && cmake --build .

# to delete the build directory
cd .. && rm -rf build
```

* On Windows:
```powershell
mkdir build && cd build && cmake .. && cmake --build .
#or
# mkdir build && cd build && cmake .. && msbuild .\<your solution> # build solution

# to delete the build directory
cd .. && rm -rf build
```
