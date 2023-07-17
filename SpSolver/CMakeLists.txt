#Todo icc?

find_package(pybind11 CONFIG)

enable_language(C CXX CUDA)

find_package(CUDA)

# Set MKL_ROOT directory

set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR})
find_package(MKL)

include_directories(include ${pybind11_INCLUDE_DIRS} ${MKL_INCLUDE_DIRS})


cuda_add_library(SpSolver SHARED src/SpSolver.cu src/SpMat.cpp)
target_link_libraries(SpSolver pybind11::embed ${MKL_LIBRARIES} ${CUDA_cusolver_LIBRARY} ${CUDA_cusparse_LIBRARY})