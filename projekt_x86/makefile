CC = gcc
CFLAGS = -Wall -m64 -no-pie
LINK = -lallegro -lallegro_dialog -lallegro_image

all: main.o drawCurve.o
	$(CC) $(CFLAGS) main.o drawCurve.o -o bezier $(LINK)

main.o: main.c
	$(CC) $(CFLAGS) -c main.c -o main.o

drawCurve.o: drawCurve.s
	nasm -f elf64 -g drawCurve.s

clean:
	rm -f *.o bezier

