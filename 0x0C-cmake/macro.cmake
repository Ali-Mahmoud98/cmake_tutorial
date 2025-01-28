# To run script use: cmake -P macro.cmake

macro(ModifyGlobalVariable VAR1 VAR2)
    set(${VAR1} "VALUE1")
    set(${VAR2} "VALUE2")
endmacro()

set(GLOBAL_VAR1 "VAL1")
set(GLOBAL_VAR2 "VAL2")

message("Before ModifyGlobalVariable macro")
message("GLOBAL_VAR1: ${GLOBAL_VAR1}")
message("GLOBAL_VAR2: ${GLOBAL_VAR2}")

# Call the macro "ModifyGlobalVariable"
ModifyGlobalVariable(GLOBAL_VAR1 GLOBAL_VAR2)

# Printing the modified global variables
message("After ModifyGlobalVariable macro")
message("GLOBAL_VAR1: ${GLOBAL_VAR1}")
message("GLOBAL_VAR2: ${GLOBAL_VAR2}")

message("----------------------------------")

macro(IncreamentVar VAR) # like a macro in C
    math(EXPR ${VAR} "${${VAR}} + 1") # the variable is modified in the global scope
    # set(${VAR} ${${VAR}} PARENT_SCOPE) # this will cause warning with macro
endmacro()

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
