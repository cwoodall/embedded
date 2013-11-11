if (_COPY_HAL_FILES_HELPER)
	return()
endif()
set (_COPY_HAL_FILES_HELPER on CACHE STRING "_COPY_HAL_FILES_HELPER")

################################################################################
# HAL FILES

macro (add_hal_files hal_implemented hal_type)

	if (NOT ${hal_implemented})
		message (">>>>>>>>>>>>>>>>>>>>> ${hal_type} is not implemented for this architecture")
	elseif (${${hal_implemented}} STREQUAL "")
		message (">>>>>>>>>>>>>>>>>>>>> ${hal_type} is not implemented for this architecture")
	else()

		set(hal_filename ${hal_type}.hpp)
		set(hal_interface_filename ${hal_type}Interface.hpp)

		file (TO_NATIVE_PATH ${${hal_implemented}}				HAL_IMPLEMENTED_NATIVE_PATH)
		file (TO_NATIVE_PATH ${BASE_HAL_DIR}/${hal_interface_filename}	HAL_NATIVE_PATH)

		file (READ ${HAL_IMPLEMENTED_NATIVE_PATH} FILE_CONTENT)
		file (WRITE ${CMAKE_BINARY_DIR}/hal/${hal_filename}
"/****************************************************************************
** Hal file for ${hal_type}
**
** This file was generated by the toolchain
**
** The original file is located here : \"${HAL_IMPLEMENTED_NATIVE_PATH}\"
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/
")
		file (APPEND ${CMAKE_BINARY_DIR}/hal/${hal_filename} "${FILE_CONTENT}")

		
		list(APPEND MCU_HAL_FILES_SOURCES ${HAL_NATIVE_PATH})
		if (NOT (${HAL_IMPLEMENTED_NATIVE_PATH} STREQUAL ${HAL_NATIVE_PATH}))
			#message ("append : ${HAL_IMPLEMENTED_NATIVE_PATH}")
			list(APPEND MCU_HAL_FILES_SOURCES ${HAL_IMPLEMENTED_NATIVE_PATH})
		endif()

	endif()
endmacro()

add_hal_files(HAL_IMPLEMENTED_LED		"Led")
add_hal_files(HAL_IMPLEMENTED_CLOCK		"Clock")
add_hal_files(HAL_IMPLEMENTED_UART		"Uart")
add_hal_files(HAL_IMPLEMENTED_GPIO		"Gpio")
add_hal_files(HAL_IMPLEMENTED_EXTINT		"Extint")
add_hal_files(HAL_IMPLEMENTED_PWM		"Pwm")
add_hal_files(HAL_IMPLEMENTED_TIMER		"Timer")
add_hal_files(HAL_IMPLEMENTED_SPI		"Spi")
add_hal_files(HAL_IMPLEMENTED_PINOUT		"Pinout")

set (HAL_DIR ${CMAKE_BINARY_DIR}/ CACHE STRING "HAL_DIR")
