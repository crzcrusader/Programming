cmake_minimum_required(VERSION 3.30)
project(Program2 C)

set(CMAKE_C_STANDARD 17)

add_executable(Program2 main.c
        briscola.c
        briscola.h)
