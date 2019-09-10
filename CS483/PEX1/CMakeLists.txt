cmake_minimum_required(VERSION 3.6)
project(pex1)

set(CMAKE_C_STANDARD 99)

set(SOURCE_FILES
        PEX1/main.c
        PEX1/LinkedList.c
        PEX1/LinkedList.h)

add_executable(pex1 main.c LinkedList.c LinkedList.h)

#${SOURCE_FILES}