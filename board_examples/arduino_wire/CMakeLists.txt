cmake_minimum_required(VERSION 2.6)

set(EMBEDDED_PATH ${CMAKE_CURRENT_LIST_DIR}/../../)
include(${EMBEDDED_PATH}/backends/cmake/project.cmake)

build_project(test_arduino_wire main.cpp)
target_link_libraries(test_arduino_wire frontend_arduino)