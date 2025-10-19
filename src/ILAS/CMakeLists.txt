qt_add_library(ILASModule STATIC
    ILASManager.cc
    ILASManager.h
)

target_include_directories(ILASModule
    PRIVATE
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${CMAKE_SOURCE_DIR}/src
)

target_link_libraries(ILASModule
    PRIVATE
        QGroundControlModule
)
