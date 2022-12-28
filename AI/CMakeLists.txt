cmake_minimum_required(VERSION 3.18)

if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()
set(CMAKE_CXX_STANDARD 17)

project(ChessAI LANGUAGES CXX)

file(GLOB src CONFIGURE_DEPENDS *.cpp *.h)
add_executable(ChessAI ${src})
