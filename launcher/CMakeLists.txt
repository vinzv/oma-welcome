cmake_minimum_required(VERSION 3.5)
project(om-welcome-launcher)

set(CMAKE_AUTOMOC ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)

add_definitions(-std=gnu++14)

find_package(Qt5 COMPONENTS Core Gui Widgets WebEngineWidgets REQUIRED)
add_executable(om-welcome main.cpp Page.cpp)
qt5_use_modules(om-welcome Core Gui Widgets WebEngineWidgets)

install(TARGETS om-welcome DESTINATION bin)
