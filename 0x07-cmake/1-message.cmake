# Script can be RUN by typing "cmake -P 1-message.cmake"

message("Hello World")

message("----------------")

message([=[Hello
    World,
        Bracket Arguments
]=])

# Multiple lines comments
#[=[
    This is a multiple line comment in cmake
    message("Hello from comment, I will not be printed")
#]=]

message("----------------")

message("Hello World\nScape Sequences")

message("----------------")

message("Hello World...
    Without using Escape Sequences characters
")

message("----------------")

# Variables
message("CMAKE VERSION : ${CMAKE_VERSION}")

message("----------------")
