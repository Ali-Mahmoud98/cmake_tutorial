cmake_minimum_required(VERSION 3.20)
project(Rooster)

# Specify C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# The math library
add_subdirectory(src/maths)

# The stats library
add_subdirectory(src/stats)

add_executable(rooster src/main.cpp)
target_link_libraries(rooster PUBLIC libstats)
