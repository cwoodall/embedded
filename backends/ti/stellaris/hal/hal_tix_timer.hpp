#pragma once

#include <timer.h>

#include <TimerInterface.hpp>
#include <Priority.hpp>

#define TIX_TIMER_COUNT							6
#define TIX_WTIMER_COUNT							6

namespace tix {

	namespace timer
	{

		long	TimerIntNumberGet(unsigned long ulBase);

		unsigned long get_timer_base_from_id(::timer::Timer_Id TimerId, bool wide);
		unsigned long get_timer_clock_from_id(::timer::Timer_Id TimerId, bool wide);
		unsigned long get_timer_clock_from_base(unsigned long TimerBase);
		unsigned long get_timer_base_from_pin(::pinout::Gpio_id GPIOId, ::pinout::Pin_id PINId);
		unsigned long get_timer_config_from_pin(::pinout::Gpio_id GPIOId, ::pinout::Pin_id PINId);
		bool is_wide_timer(unsigned long TimerBase);

		class Timer : public ::timer::TimerInterface
		{
		public:
			Timer(::timer::Timer_Id TimerId, ::timer::SubdivisionDelay_T Delay, uint16_t Period, ::timer::callback_T callback, Priority_T priority = INTERRUPT_PRIORITY(1));

			void clear();

			bool triggered();

			void enable();

			void disable();

			void setPeriod(uint16_t Period);

			void configure();

			::timer::callback_T 			_callback;

		private:
			bool							_configured;
			::timer::SubdivisionDelay_T 	_SubdivisionDelay;
			unsigned long					_TimerBase;
			::timer::Timer_Id 				_TimerId;
			uint16_t						_Period;
			Priority_T						_Priority;

		};

	} //namespace timer

} //namespace tix

namespace timer
{

	typedef ::tix::timer::Timer						ConcreteTimer;

}//namespace timer


