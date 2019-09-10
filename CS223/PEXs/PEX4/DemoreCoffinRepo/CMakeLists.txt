cmake_minimum_required(VERSION 3.6)
project(PEX4)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_FLAGS -mwindows)

set(SOURCE_FILES PEX4_Shannon_switching_game.c
        gameLogic.c
        gameLogic.h
        graphics.c
        graphics.h
        Graph.c
        Graph.h)

add_executable(PEX4 ${SOURCE_FILES})
