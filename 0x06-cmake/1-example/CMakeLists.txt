cmake_minimum_required(VERSION 3.20)
project(Rooster)

# Specify C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# The math library
include(src/maths/maths.cmake)

# The stats library
include(src/stats/stats.cmake)

###############################
# NOTE: include just copy the code inside maths.cmake and paste it here (like "macros" and "#include" in "C").
#+  If you opened the "maths.cmake" or "stats.cmake" file, you will see that you setting up things from the
#+  prospective of the location where the main "CMakeLists.txt" is located.
###############################

add_executable(rooster src/main.cpp)
target_link_libraries(rooster PUBLIC libstats)
