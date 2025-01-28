# To run this command use: cmake -P loops.cmake

# Define a list of names
set(names "Name1" "Name2" "Name3" "Name4" "Name5")

# Iterate through the list of names using a foreach loop
foreach(name ${names})
    message("Hello, ${name}!")
endforeach()

message("----------------")

list(LENGTH names names_length)

set(counter 0)

# Iterate through the list of names using a while loop
while(counter LESS names_length)
    list(GET names ${counter} name)
    message("Hello, ${name}!")
    math(EXPR counter "${counter} + 1")
endwhile()
