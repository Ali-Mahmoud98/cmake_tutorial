cmake_minimum_required(VERSION 3.20)
project(Rooster)

# Specify C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# The math library
add_library(libmath STATIC src/maths/supermath.cpp)
target_include_directories(libmath PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/src/maths/include)

# The stats library
add_library(libstats STATIC src/stats/stats.cpp)
target_include_directories(libstats PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/src/stats/include)
target_link_libraries(libstats PRIVATE libmath)

# The executable target
add_executable(rooster src/main.cpp)
target_link_libraries(rooster PUBLIC libstats)
