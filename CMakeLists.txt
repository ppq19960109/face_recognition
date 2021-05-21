cmake_minimum_required(VERSION 3.10)
set (APP_NAME faceapp)
set (APP_PATH "dlib")
# set the project name
project(${APP_NAME})
# set the project name and version
project(${APP_NAME} VERSION 1.0)

message(STATUS "PROJECT_SOURCE_DIR:${PROJECT_SOURCE_DIR}")
message(STATUS "PROJECT_BINARY_DIR:${PROJECT_BINARY_DIR}")
set (CMAKE_INSTALL_PREFIX "${PROJECT_BINARY_DIR}/_install")

set (Tutorial_VERSION_MAJOR 1)
set (Tutorial_VERSION_MINOR 0)
# 加入一个配置头文件，用于处理 CMake 对源码的设置
configure_file (
  "${PROJECT_SOURCE_DIR}/config.h.in"
  "${PROJECT_BINARY_DIR}/config.h"
  )
# 是否使用自己的 MathFunctions 库
option (USE_MYMATH "Use provided math implementation" ON)
# 查找当前目录下的所有源文件
# 并将名称保存到 DIR_SRCS 变量
aux_source_directory(${APP_PATH} DIR_SRCS)
message("DIR_SRCS:${DIR_SRCS}")

file(GLOB_RECURSE SRC ${APP_PATH}/*.cpp)
message("SRC:${SRC}")

link_libraries(-ldl -lm pthread -lrt)

include_directories ("${PROJECT_SOURCE_DIR}/libdlib/include")
link_directories("${PROJECT_SOURCE_DIR}/libdlib/lib")

# add the executable
add_executable(${APP_NAME} ${DIR_SRCS})

target_link_libraries (${APP_NAME}  dlib -lX11 libpng.so)

# 指定安装路径
install (TARGETS ${APP_NAME} DESTINATION bin)
install (FILES "${PROJECT_BINARY_DIR}/config.h" DESTINATION include)