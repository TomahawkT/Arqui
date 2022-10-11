#include <videoDriver.h>
#include <naiveConsole.h>

extern uint16_t accessRTC(char argument);

// Gets a string, and hexadecimal values for background and letter from constants defined at videoDriver.h
// Calculates attribute by shifting background byte 

char vdAttribute(char background, char letter){
    return background * 0x10 + letter;
}

void vdPrint(const char * string, char background, char letter){
    
    char attribute = vdAttribute(background,letter);

    int i;

	for (i = 0; string[i] != 0; i++)
		ncPrintCharAttribute(string[i],attribute);
}

void vdPrintCharAttribute(char character, char attribute){
    uint8_t ** currentVideo = getCurrentVideo();
    **(currentVideo) = character;
	**(currentVideo+1) = attribute;
	*(currentVideo) += 2;
}

int checkProcess(){
    return accessRTC(0x0A) & 0x80;
}

void getTime(){
    while(checkProcess());
	int hour = accessRTC(RTC_HOURS);
	int minutes = accessRTC(RTC_MINUTES);
	int seconds = accessRTC(RTC_SECONDS);
	
    ncPrintHex(hour);
    ncPrint(":");
    ncPrintHex(minutes);
    ncPrint(":");
    ncPrintHex(seconds);
    ncNewline();

}