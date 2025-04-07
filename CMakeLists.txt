cmake_minimum_required(VERSION 3.16)

project(QWordle VERSION 0.1 LANGUAGES CXX)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find required Qt components
find_package(QT NAMES Qt6 Qt5 REQUIRED COMPONENTS Core Quick)
find_package(Qt${QT_VERSION_MAJOR} REQUIRED COMPONENTS Core Quick)

# Add include directory
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)

# List source and header files
set(SOURCES
    main.cpp
    src/GameModel.cpp
    src/WordleGame.cpp
    src/WordDictionary.cpp
    src/KeyInputFilter.cpp
)

set(HEADERS
    include/GameModel.h
    include/WordleGame.h
    include/WordDictionary.h
    include/KeyInputFilter.h
)

# Resource file containing QML
set(RESOURCES
    qml.qrc
)

# Create the executable
if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(QWordle
        MANUAL_FINALIZATION
        ${SOURCES}
        ${HEADERS}
        ${RESOURCES}
    )
else()
    add_executable(QWordle
        ${SOURCES}
        ${HEADERS}
        ${RESOURCES}
    )
endif()

# Link Qt libraries
target_link_libraries(QWordle
    PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick
)

# macOS/iOS specific settings
if(${QT_VERSION} VERSION_LESS 6.1.0)
    set(BUNDLE_ID_OPTION MACOSX_BUNDLE_GUI_IDENTIFIER com.example.QWordle)
endif()

set_target_properties(QWordle PROPERTIES
    ${BUNDLE_ID_OPTION}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)

# Install rules
include(GNUInstallDirs)
install(TARGETS QWordle
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

# Qt 6 finalization
if(QT_VERSION_MAJOR EQUAL 6)
    qt_import_qml_plugins(QWordle)
    qt_finalize_executable(QWordle)
endif()
