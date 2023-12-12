cmake_minimum_required(VERSION 3.25)
cmake_policy(SET CMP0141 NEW)

project(
        Template
        VERSION 0.0.1
        LANGUAGES CXX)
set(PROJECT_LICENSE "MIT")
set(PROJECT_FRIENDLY_NAME ${PROJECT_NAME})
set(PROJECT_LONG_NAME "Template CommonLibSSENG")
set(PROJECT_DESCRIPTION ${PROJECT_LONG_NAME})

list(APPEND CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake")
include(GNUInstallDirs)
include(addpluginsources)
include(pluginconfig)
include(plugintarget)
include(pluginpackage)

######## dependencies
set(Boost_NO_WARN_NEW_VERSIONS 1)
set(Boost_USE_STATIC_LIBS ON)
set(Boost_USE_MULTITHREADED  ON)
find_package(Boost REQUIRED COMPONENTS)
if(Boost_FOUND)
    target_link_libraries(${PROJECT_NAME} PRIVATE ${Boost_LIBRARIES})
    target_include_directories(${PROJECT_NAME} PRIVATE ${Boost_INCLUDE_DIRS})
endif()


