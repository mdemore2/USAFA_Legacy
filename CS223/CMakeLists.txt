#cmake_minimum_required(VERSION 3.6)
#project(CS223_repository_spring_2017)
#
#set(CMAKE_C_STANDARD 11)
#
#set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
#
#set(CMAKE_C_FLAGS "-Wall")
#set(SOURCE_FILES
#        Labs/Sets/Set.h
#        Labs/Sets/Set.c
#        Labs/Sets/set_test_program.c)
#
#
#add_executable(CS223_repository_spring_2017 ${SOURCE_FILES})

cmake_minimum_required(VERSION 3.6)
project(CS223_repository_spring_2017)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_FLAGS -mwindows)

set(SOURCE_FILES
        PEXs/PEX4/PEX4_Shannon_switching_game.c
        PEXs/PEX4/gameLogic.c
        PEXs/PEX4/gameLogic.h
        PEXs/PEX4/graphics.c
        PEXs/PEX4/graphics.h
        PEXs/PEX4/Graph.c
        PEXs/PEX4/Graph.h
        )

add_executable(PEX4 ${SOURCE_FILES})
