# Define the math library
add_library(libmath STATIC
    ${CMAKE_CURRENT_SOURCE_DIR}/src/maths/supermath.cpp
)

# Include directories for the math library
target_include_directories(libmath PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/src/maths/include
)