# CMake minimum version requirement
cmake_minimum_required(VERSION 3.10)

# Project name
project(MyProject)

# Default executable name
set(DEFAULT_EXEC_NAME "my_program")

# Check if EXEC_NAME is provided via -D
if(DEFINED EXEC_NAME)
    message(STATUS "Using provided executable name: ${EXEC_NAME}")
    set(EXECUTABLE_NAME ${EXEC_NAME})
else()
    message(STATUS "No executable name provided. Using default: ${DEFAULT_EXEC_NAME}")
    set(EXECUTABLE_NAME ${DEFAULT_EXEC_NAME})
endif()

if(EXEC_NAME)
    message("Hello - EXEC_NAME is defined using -D flag")
endif()


# Add executable
add_executable(${EXECUTABLE_NAME} main.cpp)

# Print the final executable name
message(STATUS "Executable name: ${EXECUTABLE_NAME}")
