cmake_minimum_required(VERSION 3.22.1)

project(HelloApp
    VERSION 1.0.0
    DESCRIPTION "Hello App"
    LANGUAGES CXX
)

add_executable(HelloApp main.cpp
    src/dog.cpp
    src/log.cpp
    src/operations.cpp
)

target_include_directories(HelloApp PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/inc)

target_compile_features(HelloApp PRIVATE cxx_std_20)
