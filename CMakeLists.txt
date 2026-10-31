cmake_minimum_required(VERSION 4.3)
project(Integration_Main)

set(CMAKE_CXX_STANDARD 23)

# This reverses a CMAKE updated policy that makes boost unable to be implemented the way it is currently
if(POLICY CMP0167)
    cmake_policy(SET CMP0167 OLD)
endif()

set(Boost_INCLUDE_DIR F:/boost_1_92_0)
set(Boost_LIBRARY_DIR F:/boost_1_92_0)
find_package(Boost 1.92.0)

include_directories(${Boost_INCLUDE_DIR})
include_directories(include)

if(NOT Boost_FOUND)
    message(FATAL_ERROR "Couldn't find boost.")
endif()

add_executable(Integration_Main main.cpp)
