cmake_minimum_required(VERSION 3.16)
project(
  cutekeyboardplugin
  VERSION 1.0
  LANGUAGES C CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 REQUIRED COMPONENTS Core)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Gui Qml Quick)

if (Qt6Gui_VERSION VERSION_GREATER_EQUAL "6.10.0")
  find_package(Qt6 REQUIRED COMPONENTS GuiPrivate QuickPrivate)
endif()

option(BUILD_EXAMPLES "Build examples" OFF)

if(QT_KNOWN_POLICY_QTP0001)
  qt_policy(SET QTP0001 NEW)
endif()

qt_standard_project_setup()

add_subdirectory(src)

if(BUILD_EXAMPLES)
  add_subdirectory(example)
endif()
