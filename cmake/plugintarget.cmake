######## target
add_library(${PROJECT_NAME} SHARED ${SOURCE_FILES})
target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_${CMAKE_CXX_STANDARD})

if(EXISTS "${CMAKE_SOURCE_DIR}/extern/CommonLibSSE-NG")
        add_subdirectory("${CMAKE_SOURCE_DIR}/extern/CommonLibSSE-NG" CommonLibSSE EXCLUDE_FROM_ALL)
else()
        find_package(CommonLibSSE REQUIRED)
endif()

target_link_libraries(${PROJECT_NAME} PRIVATE CommonLibSSE::CommonLibSSE)
target_include_directories(${PROJECT_NAME} PRIVATE CommonLibSSE::CommonLibSSE)

if(MSVC)
        target_compile_options(${PROJECT_NAME} PRIVATE /Zi)
        target_link_options(${PROJECT_NAME} PRIVATE "$<$<CONFIG:RELEASE>:/DEBUG:FULL;/INCREMENTAL:NO;/OPT:REF,ICF>")
endif()

target_include_directories(${PROJECT_NAME}
        PRIVATE
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/src>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/cmake>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/external/include>
        $<INSTALL_INTERFACE:src>)

target_include_directories(${PROJECT_NAME}
        PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>)

if(EXISTS "${CMAKE_SOURCE_DIR}/src/PCH.h")
    target_precompile_headers(${PROJECT_NAME}
    PRIVATE
        "${CMAKE_SOURCE_DIR}/src/PCH.h")
endif()