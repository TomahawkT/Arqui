#!/bin/bash

nasm -f elf $1 -o $2.o && ld -melf_i386 $2.o library.o -o $2
#si quiero 64: nasm -f elf64 $1 -o out.o && ld out.o -o $2