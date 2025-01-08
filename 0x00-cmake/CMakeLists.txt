cmake_minimum_required(VERSION 3.22.1)

# project(AddProg)

# you can add version, description, languages
project(AddProg
        VERSION 1.0.0
        DESCRIPTION "Addition program"
        LANGUAGES CXX)

# add_executable(<executableName> <sources>)
add_executable(add main.cpp)

# set_target_properties(<target> PROPERTIES <property> <value>)
# set_target_properties(add
#         PROPERTIES
#         CXX_STANDARD 20
#         CXX_STANDARD_REQUIRED ON
#         CXX_EXTENSIONS OFF)

target_compile_features(add PRIVATE cxx_std_20)
