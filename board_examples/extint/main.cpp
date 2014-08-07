/******************************************************************************\
		INCLUDES
\******************************************************************************/
#include <Pinout.hpp>
#include <ExtintInterface.hpp>

/******************************************************************************\
		DEFINES
\******************************************************************************/
#define LED_PORT							1
#define LED_PIN								1

#define EXTINT_PORT							1
#define EXTINT_PIN							0

/******************************************************************************\
		PROTOTYPES
\******************************************************************************/
void Led_High_ISR();

/******************************************************************************\
		GLOBALS
\******************************************************************************/

//configure led
::pinout::ConcretePinout pinLed(LED_PORT, LED_PIN);
::extint::ConcreteExtint Eint(EXTINT_PIN, EXTINT_PORT, ::extint::RisingTrigger, &Led_High_ISR);

/******************************************************************************\
		FUNCTIONS
\******************************************************************************/

//led interrupt service routine
void Led_High_ISR()
{
	pinLed.high();

	return;
}

//------------------------------------------------------------------------------
int main(void)
{

	//force led low
	pinLed.low();


	while (1)
	{
		//wait for external interrupt...
	}

}

//------------------------------------------------------------------------------

