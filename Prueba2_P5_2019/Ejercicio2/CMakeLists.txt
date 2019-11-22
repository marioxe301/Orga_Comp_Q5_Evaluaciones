cmake_minimum_required (VERSION 2.8)
project (test_MemEncoder)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/")

find_package(VERILATOR REQUIRED)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(VERILOG_SRCDIR "${CMAKE_SOURCE_DIR}")
set(VERILOG_BINARY_DIR "${CMAKE_CURRENT_BINARY_DIR}/verilog-build")

set(VTOPMODULE "MemEncoder")
set(VERILOG_SOURCES "${VERILOG_SRCDIR}/MemEncoder.v")
set(VERILATOR_GEN_SOURCES   "${VERILOG_BINARY_DIR}/V${VTOPMODULE}__Syms.cpp \
                             ${VERILOG_BINARY_DIR}/V${VTOPMODULE}.cpp")

separate_arguments(VERILATOR_GEN_SOURCES)

# Run verilator to compile the verilog code
add_custom_command (
    OUTPUT ${VERILATOR_GEN_SOURCES}
    COMMAND ${VERILATOR} -Wall -Wno-fatal -I${VERILOG_SRCDIR} --cc ${VERILOG_SOURCES}
            --top-module ${VTOPMODULE} -Mdir ${VERILOG_BINARY_DIR}

    MAIN_DEPENDENCY ${VERILOG_SRCDIR}/${VTOPMODULE}.v
    DEPENDS ${VERILOG_SOURCES}
  )

include_directories(${CMAKE_CURRENT_BINARY_DIR})
include_directories(${VERILOG_BINARY_DIR})
include_directories(${VERILATOR_INCLUDE_DIR})
include_directories(${VERILATOR_DPI_INCLUDE_DIR})

set_directory_properties(
    PROPERTIES
    ADDITIONAL_MAKE_CLEAN_FILES "${VERILOG_BINARY_DIR}"
)

add_executable(${PROJECT_NAME}  ${VERILATOR_INCLUDE_DIR}/verilated.cpp
                                ${VERILATOR_GEN_SOURCES})

target_link_libraries(${PROJECT_NAME} ${CMAKE_CURRENT_SOURCE_DIR}/lib/libTestMemEncoder.a)
target_link_libraries(${PROJECT_NAME} -static-libgcc -static-libstdc++)