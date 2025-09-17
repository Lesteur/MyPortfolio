# Variables
CC = gcc        # Le compilateur utilisé
CFLAGS= -W -Wall -Wextra -g -pedantic # Options de compilation, ici pour activer tous les warnings
LDFLAGS= -lm -lSDL2 -lSDL2_gfx -lSDL2_image -lSDL2_ttf -lSDL2_mixer -lSDL2_net # Options de compilation haut

# Règle par défaut : compile tous les fichiers
prog: main.o floodit.o sdl2.o
	$(CC) $(CFLAGS) -o prog main.o floodit.o sdl2.o $(LDFLAGS)

main.o: main.c floodit.h sdl2.h
	$(CC) -c $(CFLAGS) main.c $(LDFLAGS)

floodit.o: floodit.c floodit.h
	$(CC) -c $(CFLAGS) floodit.c $(LDFLAGS)

sdl2.o: sdl2.c sdl2.h
	$(CC) -c $(CFLAGS) sdl2.c $(LDFLAGS)

# Nettoyage des fichiers objets et exécutables
clean:
	rm -f main.o floodit.o prog