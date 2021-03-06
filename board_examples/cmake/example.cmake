set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/../../backends/cmake/)
include(embedded)

#add pinout support
include(${CMAKE_CURRENT_LIST_DIR}/../../backends/generic_code/pinout/cmake/Pinout.cmake)

if (PROJECT_DRIVERS)
	foreach (driver ${PROJECT_DRIVERS})
		if (EXISTS ${CMAKE_CURRENT_LIST_DIR}/../../drivers/${driver})
			include_directories(${CMAKE_CURRENT_LIST_DIR}/../../drivers/${driver}/)
			file (GLOB cpp_driver_files ${CMAKE_CURRENT_LIST_DIR}/../../drivers/${driver}/*.cpp)
			file (GLOB hpp_driver_files ${CMAKE_CURRENT_LIST_DIR}/../../drivers/${driver}/*.hpp)
			list (APPEND PROJECT_SOURCES ${cpp_driver_files} ${hpp_driver_files})
		endif()
	endforeach()
endif()

include_directories(${BASE_HAL_DIR}/)
include_directories(${HAL_DIR})
include_directories(${TARGET_INCLUDE_DIRECTORIES})

ADD_EXECUTABLE(${PROJECT_NAME}.elf	${PROJECT_SOURCES})

include(project)

build_project(${PROJECT_SOURCES})

