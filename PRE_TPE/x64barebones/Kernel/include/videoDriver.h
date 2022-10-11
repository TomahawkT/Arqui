// COLOR TABLE
#ifndef VIDEO_DRIVER_H
#define VIDEO_DRIVER_H

#define BLACK           0x00
#define BLUE            0x01
#define GREEN           0x02
#define CYAN            0x03
#define RED             0x04
#define PURPLE          0x05
#define BROWN           0x06
#define GRAY            0x07
#define DARK GRAY       0x08
#define LIGHT_BLUE      0x09
#define LIGHT_GREEN     0x0A
#define LIGHT_CYAN      0x0B
#define LIGHT_RED       0x0C
#define LIGHT_PURPLE    0x0D
#define YELLOW          0x0E
#define WHITE           0x0F

#define RTC_SECONDS         0x00
#define RTC_SECONDS_ALARM   0x01
#define RTC_MINUTES         0x02
#define RTC_MINUTES_ALARM   0x03
#define RTC_HOURS           0x04
#define RTC_HOURS_ALARM     0x05
#define RTC_DAY_OF_WEEK     0x06
#define RTC_DAY_OF_MONTH    0x07
#define RTC_MONTH           0x08
#define RTC_YEAR            0x09

int checkProcess();
void getTime();
char vdAttribute(char background, char letter);
void vdPrint(const char * string, char background, char letter);
void vdPrintCharAttribute(char character, char attribute);

#endif 