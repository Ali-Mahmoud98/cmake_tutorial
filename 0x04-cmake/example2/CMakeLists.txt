cmake_minimum_required(VERSION 3.22.1)

project(HelloApp
    VERSION 1.0.0
    DESCRIPTION "Hello App"
    LANGUAGES CXX
)

# NOTE1: It is possible to set c++ standard at the different levels.
#+ It is possible to set c++ standard for your project in a global level
#+ and make each target pick that up and use it.
#+ one way to do that through cmake variables: (to set variables in cmake you can use cmake `set` command in your CMakeLists.txt file)
set(CMAKE_CXX_STANDARD 20) # Default c++ standard for targets
set(CMAKE_CXX_STANDARD_REQUIRED ON) # make c++20 a hard requirement
# If you did the 2 above line you can comment the lines that have comment messages "target level -> see NOTE1"

# >>>>>> build the dependencies then build what depends on them <<<<<<
# build static library "operations"
add_library(operations STATIC src/operations.cpp)
target_include_directories(operations PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/inc)
# target_compile_features(operations PUBLIC cxx_std_20) # target level -> see NOTE1

# build dynamic or shared library "logger"
add_library(logger SHARED logger/src/log.cpp)
target_include_directories(logger PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/logger/inc)
# target_compile_features(logger PUBLIC cxx_std_20) # target level -> see NOTE1

add_executable(HelloApp main.cpp
    src/dog.cpp
)

target_include_directories(HelloApp PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/inc)
# target_compile_features(HelloApp PUBLIC cxx_std_20) # target level -> see NOTE1
target_link_libraries(HelloApp PUBLIC operations logger)
