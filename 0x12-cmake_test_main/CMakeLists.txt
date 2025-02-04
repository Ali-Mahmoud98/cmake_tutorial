cmake_minimum_required(VERSION 3.22.1)

project(CalculatorProj)

enable_testing()

list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_subdirectory(src)

add_executable(rooster main.cpp)
target_link_libraries(rooster PRIVATE run_app)

add_subdirectory(test)
