cmake_minimum_required(VERSION 3.24)

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

######## dependencies
find_package(CommonLibSSE REQUIRED)
add_commonlibsse_plugin(${PROJECT_NAME} SOURCES ${HEADER_FILES} ${SOURCE_FILES}
                        NAME ${PROJECT_NAME}
                        VERSION ${PROJECT_VERSION}
                        )

set(Boost_NO_WARN_NEW_VERSIONS 1)
set(Boost_USE_STATIC_LIBS ON)
set(Boost_USE_MULTITHREADED  ON)
find_package(Boost REQUIRED)
if(Boost_FOUND)
    target_link_libraries(${PROJECT_NAME} PRIVATE ${Boost_LIBRARIES})
    target_include_directories(${PROJECT_NAME} PRIVATE ${Boost_INCLUDE_DIRS})
endif()

######## target
add_library("${PROJECT_NAME}::${PROJECT_NAME}" ALIAS "${PROJECT_NAME}")
target_include_directories(${PROJECT_NAME}
        PRIVATE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/src>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/cmake>
        $<INSTALL_INTERFACE:src>)

target_include_directories(${PROJECT_NAME}
        PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>)

if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/src/PCH.h")
    target_precompile_headers(${PROJECT_NAME}
    PRIVATE
        "${CMAKE_CURRENT_SOURCE_DIR}/src/PCH.h")
endif()

######## install and distribution
install(FILES
        "${CMAKE_CURRENT_SOURCE_DIR}/dist/${PROJECT_NAME}.ini"
        "${CMAKE_CURRENT_SOURCE_DIR}/dist/${PROJECT_NAME}.toml"
        CONFIGURATIONS Debug Release RelWithDebInfo
        DESTINATION ${PLUGIN_INSTALL_DEST} OPTIONAL)

if(PLUGIN_INSTALL_PDB)
        install(FILES $<TARGET_PDB_FILE:${PROJECT_NAME}>
                CONFIGURATIONS Debug RelWithDebInfo
                DESTINATION ${PLUGIN_INSTALL_DEST} OPTIONAL)
endif()

install(TARGETS ${PROJECT_NAME}
        RUNTIME DESTINATION ${PLUGIN_INSTALL_DEST})

if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/dist/Data")
    install(DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/dist/Data/"
            DESTINATION ".")
endif()

set(CPACK_GENERATOR ZIP)
set(CPACK_PACKAGE_NAME ${PROJECT_LONG_NAME})
set(CPACK_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CMAKE_PROJECT_VERSION}")
set(CPACK_INCLUDE_TOPLEVEL_DIRECTORY 0)
include(CPack)
