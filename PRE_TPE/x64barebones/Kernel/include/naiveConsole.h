#ifndef NAIVE_CONSOLE_H
#define NAIVE_CONSOLE_H

#include <stdint.h>

uint8_t ** getCurrentVideo();
void readInput();
void ncPrint(const char * string);
void ncPrintChar(char character);
void ncNewline();
void ncPrintDec(uint64_t value);
void ncPrintHex(uint64_t value);
void ncPrintBin(uint64_t value);
void ncPrintBase(uint64_t value, uint32_t base);
void ncPrintCharAttribute(char character, char attribute);
void ncPrintAttribute(const char * string, char attribute);
void ncClear();

#endif