# Define the stats library
add_library(libstats STATIC
    ${CMAKE_CURRENT_SOURCE_DIR}/src/stats/stats.cpp
)

# Include directories for the stats library
target_include_directories(libstats PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/src/stats/include
)

# Link the stats library to the math library
target_link_libraries(libstats PRIVATE libmath)
