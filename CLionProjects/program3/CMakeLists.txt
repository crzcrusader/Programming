cmake_minimum_required(VERSION 3.30)
project(program3 C)

set(CMAKE_C_STANDARD 17)

add_executable(program3 main.c
        actors.c
        actors.h)
