# To run script use: cmake -P functions.cmake

function(ModifyGlobalVariable VAR1 VAR2)
    message(STATUS "start ModifyGlobalVariable function")
    set(${VAR1} "VALUE1" PARENT_SCOPE)
    set(${VAR2} "VALUE2" PARENT_SCOPE)
    message(STATUS "end ModifyGlobalVariable function")
endfunction()

set(GLOBAL_VAR1 "VAL1")
set(GLOBAL_VAR2 "VAL2")

message("GLOBAL_VAR1: ${GLOBAL_VAR1}")
message("GLOBAL_VAR2: ${GLOBAL_VAR2}")

# Call the function "ModifyGlobalVariable"
ModifyGlobalVariable(GLOBAL_VAR1 GLOBAL_VAR2)

# Printing the modified global variables
message("GLOBAL_VAR1: ${GLOBAL_VAR1}")
message("GLOBAL_VAR2: ${GLOBAL_VAR2}")

message("----------------------------------")

function(IncreamentVar VAR)
    math(EXPR ${VAR} "${${VAR}} + 1")
    set(${VAR} ${${VAR}} PARENT_SCOPE)
endfunction()

set(myVar 0)

IncreamentVar(myVar)
message("myVar: ${myVar}")

IncreamentVar(myVar)
message("myVar: ${myVar}")

message("----------------------------------")
set(myVar2 0)

# loop to increment myVar2 twice
foreach(loop_var RANGE 1)
    message("loop_var: ${loop_var}")
    IncreamentVar(myVar2)    
endforeach()

message("myVar2: ${myVar2}")
