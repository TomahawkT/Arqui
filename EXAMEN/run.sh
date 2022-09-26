nasm -f elf32 binary_search.asm
nasm -f elf syscalls32.asm
gcc -c -m32 main.c
gcc -m32 binary_search.o main.o syscalls32.o -o main
