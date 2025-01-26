# Script can be RUN by typing "cmake -P 2-variables.cmake"

set(var_1 "Variable 1")
set([[var_2]] "Variable 2")
set("var_3" "Variable 3") # Not recommended

message("var_1: ${var_1}")
message("var_2: ${var_2}")
message("var_3: ${var_3}")

message("----------------")

# variable references
set(one abc) # abc
set(two ${one}de) # abcde
set(three ${two} fg) # abcde;fg
set(three2 "${two} fg") # abcde;fg
set(four thre) # thre
set(five ${${four}e}) # abcde;fg

message("one: ${one}")
message("two: ${two}")
message("three: ${three}")
message("three2: ${three2}")
message("four: ${four}")
message("five: ${five}")

message("----------------")

# environment variables
message("1st: $ENV{PATH}")
set(ENV{PATH} "/home/user1/Desktop")
# NOT: your own environment variables will affect the running cmake instance.
#+ They will not affect the system.
message("2nd: $ENV{PATH}")
message("PWD: $ENV{PWD}")

message("----------------")
# Cache variable: one of the types of variables you can define in cmake
set(CACHE_VAR "The Value" CACHE STRING "This is a cache variable")
message("CACHE_VAR: ${CACHE_VAR}")

message("----------------")
# Cmake defined variables
message(${CMAKE_VERSION}) # prints cmake version
message(${CMAKE_COMMAND}) # prints cmake executable path
message(${CMAKE_CURRENT_LIST_FILE}) # prints current location of list file
# message(${CMAKE_CXX_COMPILER})
message(STATUS "C Compiler: ${CMAKE_C_COMPILER}") # the value of ${CMAKE_C_COMPILER} will not printed
message(STATUS "C++ Compiler: ${CMAKE_CXX_COMPILER}") # the value of ${CMAKE_CXX_COMPILER} will not printed
message(STATUS "C++ Compiler Version: ${CMAKE_CXX_COMPILER_VERSION}") # the value of ${CMAKE_CXX_COMPILER_VERSION} will not printed
message(STATUS "C++ Standard: ${CMAKE_CXX_STANDARD}") # the value of ${CMAKE_CXX_STANDARD} will not printed
# The issue is that the script is being executed in Script Mode using cmake -P,
#+ which does not initialize or configure a build system. In Script Mode, CMake
#+ does not set or populate build-related variables like CMAKE_C_COMPILER,
#+ CMAKE_CXX_COMPILER, CMAKE_CXX_COMPILER_VERSION, or CMAKE_CXX_STANDARD
#+ because these variables are tied to Project Mode (used to generate build systems).

# Key Difference Between Script Mode and Project Mode:
# => Script Mode (cmake -P): Executes the script without creating or configuring a project. 
#+ Variables related to compilers and build configurations are not set.
# => Project Mode (cmake -S <source_dir> -B <build_dir>): Configures the build environment,
#+ detects compilers, and sets variables like CMAKE_C_COMPILER and CMAKE_CXX_COMPILER.
