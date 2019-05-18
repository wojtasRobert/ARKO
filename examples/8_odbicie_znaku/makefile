CC = gcc
CFLAGS = -m32 -Wall

all:    main.o f.o
	$(CC) $(CFLAGS) main.o f.o -o fun

main.o:	main.c
	$(CC) $(CFLAGS) -c main.c -o main.o

f.o:    f.s
	nasm -f elf32 f.s

clean:
	rm -f *.o

