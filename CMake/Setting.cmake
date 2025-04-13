set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

# Write properties that are influenced by the toolchain
#
message(STATUS "CMAKE_CROSSCOMPILING = ${CMAKE_CROSSCOMPILING}")
message(STATUS "CMAKE_SYSTEM_NAME = ${CMAKE_SYSTEM_NAME}")
message(STATUS "CMAKE_SYSTEM_PROCESSOR = ${CMAKE_SYSTEM_PROCESSOR}")
message(STATUS "MSVC_TOOLSET_VERSION = ${MSVC_TOOLSET_VERSION}")
message(STATUS "MSVC_VERSION = ${MSVC_VERSION}")

# Demonstrate that toolchain-related tooling can be found
#
find_program(NMAKE_PATH
    nmake.exe
)

message(STATUS "NMAKE_PATH = ${NMAKE_PATH}")

# Build a set of representative projects
#
add_compile_definitions(
    UNICODE
    _UNICODE
)

# 设置默认编译选项
if(MSVC)
    # MSVC 编译器选项
    # add_compile_options(/W4 /WX)
    # add_compile_definitions(_CRT_SECURE_NO_WARNINGS)
    add_compile_options(/Zc:preprocessor /utf-8 /DNOMINMAX /D_USE_MATH_DEFINES /EHsc /bigobj)
else()
    # GCC/Clang 编译器选项
    add_compile_options(-Wall -Wextra -Wpedantic -Werror)
    add_compile_options(-fvisibility=hidden)
    
    # ReleaseWithDebug 特定选项
    set(CMAKE_CXX_FLAGS_RelWithDbgInfo "${CMAKE_CXX_FLAGS_RelWithDbgInfo} -O3 -march=native -DNDEBUG")
    set(CMAKE_C_FLAGS_RelWithDbgInfo "${CMAKE_C_FLAGS_RelWithDbgInfo} -O3 -march=native -DNDEBUG")
endif()

# 设置不同构建类型的编译选项
set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -O0 -g3 -DDEBUG")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -O0 -g3 -DDEBUG")
set(CMAKE_C_FLAGS_Release "${CMAKE_C_FLAGS_Release} -O3 -DNDEBUG")
set(CMAKE_CXX_FLAGS_Release "${CMAKE_CXX_FLAGS_Release} -O3 -DNDEBUG")
set(CMAKE_C_FLAGS_RelWithDbgInfo "${CMAKE_C_FLAGS_RelWithDbgInfo} -O2 -g -DNDEBUG")
set(CMAKE_CXX_FLAGS_RelWithDbgInfo "${CMAKE_CXX_FLAGS_RelWithDbgInfo} -O2 -g -DNDEBUG")
set(CMAKE_C_FLAGS_MinSizeRel "${CMAKE_C_FLAGS_MinSizeRel} -Os -DNDEBUG")
set(CMAKE_CXX_FLAGS_MinSizeRel "${CMAKE_CXX_FLAGS_MinSizeRel} -Os -DNDEBUG")
