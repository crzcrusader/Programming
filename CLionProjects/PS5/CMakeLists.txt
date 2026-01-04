cmake_minimum_required(VERSION 3.30)
project(PS5 C)

set(CMAKE_C_STANDARD 17)

add_executable(PS5 main.c
        Appointment.h
        Appointment.c)
