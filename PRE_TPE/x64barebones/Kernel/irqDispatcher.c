#include <time.h>
#include <stdint.h>
#include <videoDriver.h>
#include <naiveConsole.h>

static void int_20();
static void int_21();

static uint64_t (*functions[255]) (void); 

void irqDispatcher(uint64_t irq) {
	switch (irq) {
		case 0:
			int_20();
			break;
		case 1:
			int_21();
			break;
	}
	return;


	//(*functions[irq + 0x20])();
	//return;

}

void int_20() {
	timer_handler();
}

void int_21(){
	uint8_t i = readKey();
	if(i != 0){ 
		ncPrintChar(i);
	}
}
