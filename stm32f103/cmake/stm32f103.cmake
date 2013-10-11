INCLUDE(CMakeForceCompiler)

function(add_executable ...)
	_add_executable(${ARGV}		${STM32F1_NEEDED_SYSTEM_FILES}
								${STM32F1_ACCESS_LAYER_SYSTEM_SOURCE_FILE}
								${STM32F1_DEVICE_VECTOR_TABLE_SOURCE_FILE}
								${STM32F1_SYSCALL_SOURCE_FILE}
								${STM32F1_ROOT_DIR}/hal/hal_stm32f1_clock.cpp
							)
endfunction()

set (STM32F1_ROOT_DIR "${CMAKE_CURRENT_LIST_DIR}/../../stm32f1/")
set (STM32F103_ROOT_DIR "${CMAKE_CURRENT_LIST_DIR}/..")

SET(CMAKE_CROSSCOMPILING TRUE) 
# the name of the target operating system
SET(CMAKE_SYSTEM_NAME Generic)

################################################################################

set (SYSTEM_FILES_DIR "${CMAKE_CURRENT_LIST_DIR}/../system_files")

################################################################################

configure_file(${CMAKE_CURRENT_LIST_DIR}/../../hal/clock.hpp ${CMAKE_BINARY_DIR}/hal/clock.hpp COPYONLY)
configure_file(${STM32F103_ROOT_DIR}/hal/hal_stm32f103_uart.hpp ${CMAKE_BINARY_DIR}/hal/uart.hpp COPYONLY)
configure_file(${STM32F1_ROOT_DIR}/hal/hal_stm32f1_gpio.hpp ${CMAKE_BINARY_DIR}/hal/gpio.hpp COPYONLY)
configure_file(${CMAKE_CURRENT_LIST_DIR}/../../stm32fx/hal/stm32fx/usart_conf.hpp ${CMAKE_BINARY_DIR}/hal/stm32fx/usart_conf.hpp COPYONLY)
include_directories(${CMAKE_BINARY_DIR})

include (arm-none-eabi-gcc)

################################################################################
# stm32f4 system headers


include_directories(${CMAKE_CURRENT_LIST_DIR}/../../hal/)
include_directories(${CMAKE_CURRENT_LIST_DIR}/../hal/)
include_directories(${SYSTEM_FILES_DIR})
include_directories(${STM32F1_ROOT_DIR}/system_files/STM32F10x_StdPeriph_Driver/inc/)
include_directories(${STM32F1_ROOT_DIR}/system_files)


################################################################################
# stm32f4 system sources
set(STM32F1xx_StdPeriph_Driver		${STM32F1_ROOT_DIR}/system_files/STM32F10x_StdPeriph_Driver/src)
set(STM32F1_MISC_SOURCE				${STM32F1xx_StdPeriph_Driver}/misc.c)
set(STM32F1_ADC_SOURCE				${STM32F1xx_StdPeriph_Driver}/stm32f10x_adc.c)
set(STM32F1_BKP_SOURCE				${STM32F1xx_StdPeriph_Driver}/stm32f10x_bkp.c)
set(STM32F1_CAN_SOURCE				${STM32F1xx_StdPeriph_Driver}/stm32f10x_can.c)
set(STM32F1_CEC_SOURCE				${STM32F1xx_StdPeriph_Driver}/stm32f10x_cec.c)
set(STM32F1_CRC_SOURCE				${STM32F1xx_StdPeriph_Driver}/stm32f10x_crc.c)
set(STM32F1_DAC_SOURCE				${STM32F1xx_StdPeriph_Driver}/stm32f10x_dac.c)
set(STM32F1_DBGMCU_SOURCE			${STM32F1xx_StdPeriph_Driver}/stm32f10x_dbgmcu.c)
set(STM32F1_DMA_SOURCE				${STM32F1xx_StdPeriph_Driver}/stm32f10x_dma.c)
set(STM32F1_EXTI_SOURCE				${STM32F1xx_StdPeriph_Driver}/stm32f10x_exti.c)
set(STM32F1_FLASH_SOURCE			${STM32F1xx_StdPeriph_Driver}/stm32f10x_flash.c)
set(STM32F1_FSMC_SOURCE				${STM32F1xx_StdPeriph_Driver}/stm32f10x_fsmc.c)
set(STM32F1_GPIO_SOURCE				${STM32F1xx_StdPeriph_Driver}/stm32f10x_gpio.c)
set(STM32F1_I2C_SOURCE				${STM32F1xx_StdPeriph_Driver}/stm32f10x_i2c.c)
set(STM32F1_IWDG_SOURCE				${STM32F1xx_StdPeriph_Driver}/stm32f10x_iwdg.c)
set(STM32F1_PWR_SOURCE				${STM32F1xx_StdPeriph_Driver}/stm32f10x_pwr.c)
set(STM32F1_RCC_SOURCE				${STM32F1xx_StdPeriph_Driver}/stm32f10x_rcc.c)
set(STM32F1_RTC_SOURCE				${STM32F1xx_StdPeriph_Driver}/stm32f10x_rtc.c)
set(STM32F1_SDIO_SOURCE				${STM32F1xx_StdPeriph_Driver}/stm32f10x_sdio.c)
set(STM32F1_SPI_SOURCE				${STM32F1xx_StdPeriph_Driver}/stm32f10x_spi.c)
set(STM32F1_TIM_SOURCE				${STM32F1xx_StdPeriph_Driver}/stm32f10x_tim.c)
set(STM32F1_USART_SOURCE			${STM32F1xx_StdPeriph_Driver}/stm32f10x_usart.c)
set(STM32F1_WWDG_SOURCE				${STM32F1xx_StdPeriph_Driver}/stm32f10x_wwdg.c)
################################################################################

################################################################################
# stm32f4 system sources list
set(STM32F1_SYSTEM_SOURCES	STM32F1_MISC_SOURCE		
							STM32F1_ADC_SOURCE		
							STM32F1_BKP_SOURCE		
							STM32F1_CAN_SOURCE		
							STM32F1_CEC_SOURCE		
							STM32F1_CRC_SOURCE		
							STM32F1_DAC_SOURCE		
							STM32F1_DBGMCU_SOURCE	
							STM32F1_DMA_SOURCE		
							STM32F1_EXTI_SOURCE		
							STM32F1_FLASH_SOURCE	
							STM32F1_FSMC_SOURCE		
							STM32F1_GPIO_SOURCE		
							STM32F1_I2C_SOURCE		
							STM32F1_IWDG_SOURCE		
							STM32F1_PWR_SOURCE		
							STM32F1_RCC_SOURCE		
							STM32F1_RTC_SOURCE		
							STM32F1_SDIO_SOURCE		
							STM32F1_SPI_SOURCE		
							STM32F1_TIM_SOURCE		
							STM32F1_USART_SOURCE	
							STM32F1_WWDG_SOURCE)																								
						
																																																																																																																																																

################################################################################
# add sources requested by the user in the CMakeLists.txt
foreach(SYSTEM_SOURCE ${STM32F1_SYSTEM_SOURCES})
		list(APPEND STM32F1_NEEDED_SYSTEM_FILES ${${SYSTEM_SOURCE}})
endforeach()

# if user has requested some standard driver we must say it
list(LENGTH STM32F1_NEEDED_SYSTEM_FILES STM32F1_NEEDED_SYSTEM_FILES_LENGTH)
if (${STM32F1_NEEDED_SYSTEM_FILES_LENGTH} GREATER 0)
	add_definitions(-DUSE_STDPERIPH_DRIVER)
	include_directories(${CMAKE_SOURCE_DIR})
endif()
################################################################################




################################################################################
# find stm32 system file (CMSIS Cortex-M4 Device Peripheral Access Layer System Source File)
set (STM32F1_ACCESS_LAYER_SYSTEM_SOURCE_FILE  "${STM32F1_ROOT_DIR}/system_files/system_stm32f10x.c")
################################################################################


################################################################################
# find STM32F4xx Devices vector table
set (STM32F1_DEVICE_VECTOR_TABLE_SOURCE_FILE  "${SYSTEM_FILES_DIR}/startup_stm32f10x_md_vl.s")
################################################################################


################################################################################
# find STM32F4xx Devices vector table
set (STM32F1_SYSCALL_SOURCE_FILE  "${STM32F1_ROOT_DIR}/../stm32fx/system_files/syscall.c")
################################################################################

# adjust the default behaviour of the FIND_XXX() commands:
# search headers and libraries in the target environment, search 
# programs in the host environment
SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

SET(MCFLAGS "-mlittle-endian -mthumb -mcpu=cortex-m3 -mfix-cortex-m3-ldrd")
SET(CMAKE_ASM_FLAGS "${MCFLAGS}")
SET(CMAKE_C_FLAGS "${MCFLAGS} -Wall -Wextra -Warray-bounds -ffunction-sections -fdata-sections")
SET(CMAKE_CXX_FLAGS "${MCFLAGS} -std=c++11 -Wall -Wextra -Warray-bounds -fno-builtin -fno-rtti -fno-exceptions -ffunction-sections -fdata-sections")

SET(CMAKE_C_FLAGS_DEBUG "-O0 -g")
SET(CMAKE_CXX_FLAGS_DEBUG "-O0 -g")
SET(CMAKE_ASM_FLAGS_DEBUG "-g")

SET(CMAKE_C_FLAGS_RELEASE "-O3")
SET(CMAKE_CXX_FLAGS_RELEASE "-O3")
SET(CMAKE_ASM_FLAGS_RELEASE "")

################################################################################
# find stm32_flash.ld linker script files
set (LDSCRIPT "${CMAKE_CURRENT_LIST_DIR}/../system_files/stm32_flash.ld")
################################################################################

SET(CMAKE_CXX_LINK_FLAGS "${MCFLAGS} -T${LDSCRIPT} -Wl,--gc-sections --specs=nano.specs")
SET(CMAKE_C_LINK_FLAGS "${MCFLAGS} -T${LDSCRIPT} -Wl,--gc-sections --specs=nano.specs")

set (GDBINIT_CONTENT
"target remote localhost:3333
")

set (GDBFLASH_CONTENT
"target remote 127.0.0.1:3333
monitor reset init
monitor flash erase_address 0x08000000 0x10000
monitor flash write_image ${CMAKE_PROJECT_NAME}.elf
quit
")

set (OPENOCDCFG_CONTENT
"interface ft2232
ft2232_device_desc "USB<=>JTAG&RS232"
ft2232_layout jtagkey
ft2232_vid_pid 0x1457 0x5118

source [find target/stm32f1x.cfg]

#jtag_rclk 1500

gdb_breakpoint_override hard

#reset_config trst_and_srst srst_pulls_trst srst_gates_jtag
reset_config trst_and_srst separate

")


file (WRITE ${CMAKE_BINARY_DIR}/.gdbinit ${GDBINIT_CONTENT})
file (WRITE ${CMAKE_BINARY_DIR}/.gdbflash ${GDBFLASH_CONTENT})
file (WRITE ${CMAKE_BINARY_DIR}/openocd.cfg ${OPENOCDCFG_CONTENT})

ENABLE_LANGUAGE(ASM)

