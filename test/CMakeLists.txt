CMAKE_MINIMUM_REQUIRED(VERSION 3.2)

enable_language(C CXX CUDA)

include_directories(${MyProject_SOURCE_DIR}/SpSolver/include)
link_directories(${MyProject_SOURCE_DIR}/SpSolver/src)
link_directories(${MyProject_SOURCE_DIR}/SpSolver)

#set(EXECUTABLE_OUTPUT_PATH ".")
#set(CUDA_NVCC_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -O3")
#find_package(CUDA REQUIRED)

add_executable(main main.cpp)

target_link_libraries(main SpSolver)
