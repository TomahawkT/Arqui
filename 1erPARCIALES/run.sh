#!/bin/sh
nasm -f elf32 minilib.asm -o minilib.o
gcc -c -m32 expression.c -o expression.o
gcc -m32 expression.o minilib.o -o expressionTest
./expressionTest expresion.txt