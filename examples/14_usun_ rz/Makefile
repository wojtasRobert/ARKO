CC=gcc
CFLAGS=-m32

ASM=nasm
AFLAGS=-f elf32

all:result

main.o: main.c
	$(CC) $(CFLAGS) -c main.c
func.o: func.asm
	$(ASM) $(AFLAGS) func.asm
result: main.o func.o
	$(CC) $(CFLAGS) main.o func.o -o result
clean: 
	rm *.o
	rm result
