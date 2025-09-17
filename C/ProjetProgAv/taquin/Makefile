CC=gcc
CCFLAGS+=-Wall -Wextra -pedantic -g -lSDL2 -lSDL2_ttf
SRCS=f_taquin.c f_sdl.c main.c
EXE=taquin.exe

.phony: all clean

all:
	$(CC) $(SRCS) $(CCFLAGS) -o $(EXE)

clean:
	rm $(EXE)