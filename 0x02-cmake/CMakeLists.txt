cmake_minimum_required(VERSION 3.22.1)

project(MultiFileCMakeExample)

set(SOURCES
    main.cpp
    src/math_operations.cpp
    src/string_operations.cpp
)

### NOT RECOMMENDED
# There is a method put not recommended to tell the cmake go and scan a directory and find all .cpp files
# file(GLOB SOURCES "src/*.cpp")
# add_executable(MultiFileCMakeExample main.cpp ${SOURCES})
# READ: https://stackoverflow.com/questions/1027247/is-it-better-to-specify-source-files-with-glob-or-each-file-individually-in-cmak/1060061#1060061
###

add_executable(MultiFileCMakeExample ${SOURCES})

target_compile_features(MultiFileCMakeExample PRIVATE cxx_std_20)

# you have to tell cmake where your header files are going to live
target_include_directories(MultiFileCMakeExample PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/inc)
