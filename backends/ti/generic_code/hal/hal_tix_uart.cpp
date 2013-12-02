#include <hal/usart_conf.hpp>
#include <string.h>
#include <hw_types.h>
#include <hw_memmap.h>
#include <UartInterface.hpp>
#include <hal/Uart.hpp>
#include <gpio.h>
#include <uart.h>

namespace tix
{

	namespace uart
	{

		Uart::Uart(unsigned int id, ::uart::UartInterface::uart_callback callback, ::uart::Configuration config)
		{

			//GPIO configuration for UART use
			unsigned long RxPinConfig;
			unsigned long TxPinConfig;

			//clocks associated to UARTs
			unsigned long UartPeripheral;
			unsigned long GPIOPeripheral;

			// the gpio used
			unsigned long GPIO_Port;
			unsigned char GPIO_Pin_TX;			// the selected pin
			unsigned char GPIO_Pin_RX;			// the selected pin

			_callback = callback;

			switch (id)
			{
			case 1:
				_UART_Base = UART0_BASE;
				UartPeripheral = SYSCTL_PERIPH_UART0;
				GPIOPeripheral = SYSCTL_PERIPH_GPIOA;
				RxPinConfig = GPIO_PA0_U0RX;
				TxPinConfig = GPIO_PA1_U0TX;
				GPIO_Port = GPIO_PORTA_BASE;
				GPIO_Pin_RX = GPIO_PIN_0;
				GPIO_Pin_TX = GPIO_PIN_1;
				break;
			case 2:
				_UART_Base = UART1_BASE;
				UartPeripheral = SYSCTL_PERIPH_UART1;
				GPIOPeripheral = SYSCTL_PERIPH_GPIOB;
				RxPinConfig = GPIO_PB0_U1RX;
				TxPinConfig = GPIO_PB1_U1TX;
				GPIO_Port = GPIO_PORTB_BASE;
				GPIO_Pin_RX = GPIO_PIN_0;
				GPIO_Pin_TX = GPIO_PIN_1;
				break;
			case 3:
				_UART_Base = UART2_BASE;
				UartPeripheral = SYSCTL_PERIPH_UART2;
				GPIOPeripheral = SYSCTL_PERIPH_GPIOD;
				RxPinConfig = GPIO_PD6_U2RX;
				TxPinConfig = GPIO_PD7_U2TX;
				GPIO_Port = GPIO_PORTB_BASE;
				GPIO_Pin_RX = GPIO_PIN_6;
				GPIO_Pin_TX = GPIO_PIN_7;
				break;
			} //end switch


			//
			// Enable the peripherals
			//
			SysCtlPeripheralEnable(UartPeripheral);
			SysCtlPeripheralEnable(GPIOPeripheral);


			//
			// Set GPIO for UART pins.
			//
			GPIOPinConfigure(RxPinConfig);
			GPIOPinConfigure(TxPinConfig);
			GPIOPinTypeUART(GPIO_Port, GPIO_Pin_RX | GPIO_Pin_TX);

			//
			// Configure the UART
			//
			UARTConfigSetExpClk(_UART_Base, SysCtlClockGet(),
								conf_2_baudrate(config.baudRate),
								(conf_2_Parity(config.Parity)
								| conf_2_StopBits(config.StopBits)
								| conf_2_WordLength(config.WordLength)));


			//
			// Configure Hardware control flow
			//
			UARTFlowControlSet(_UART_Base, conf_2_HardwareFlowControl(config.HardwareFlowControl));


		}

		void Uart::send(const char* const str)
		{
			send((const unsigned char*) str, (unsigned int)strlen(str));
		}


		void Uart::send(const types::buffer& buf)
		{
			for (auto c : buf)
			{
				UARTCharPut(_UART_Base, c & 0xFF);
			}

		}

		void Uart::send(const unsigned char* buf, unsigned int length)
		{
			for (unsigned int i = 0; i < length; i++)
			{
				UARTCharPut(_UART_Base, buf[i] & 0xFF);
			}
		}

		/*
		//TODO: implement callbacks and interrupts
		#define USART_IRQ_CALLBACK(UsartX)	void USART##UsartX##_IRQ_Handler()									\
												{																	\
													::uart::get_instance(UsartX).accumulator(USART##UsartX ->DR);	\
												}

		USART_IRQ_CALLBACK(1)
		USART_IRQ_CALLBACK(2)
		USART_IRQ_CALLBACK(3)
		*/


	} /* namespace uart  */

} /* namespace tix  */
