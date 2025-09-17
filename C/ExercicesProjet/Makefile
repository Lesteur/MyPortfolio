# === Project Configuration ===

# Compiler and flags
CC = gcc
CFLAGS = -Wall -Wextra -W -g -pedantic -I$(SRC_DIR)/Librairies `sdl2-config --cflags`
LDFLAGS = `sdl2-config --libs` -lSDL2_image -lSDL2_ttf -lSDL2_mixer -lSDL2_net -lSDL2_gfx -lm

# Directories
SRC_DIR = src
LIB_DIR = $(SRC_DIR)/Librairies
OBJ_DIR = $(SRC_DIR)/Assembly

# Executable name
EXEC = game.exe

# Source files
SRC_FILES = $(wildcard $(LIB_DIR)/*.c) $(SRC_DIR)/main.c

# Object files
OBJ_FILES = $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRC_FILES))

# Default target
all: $(EXEC)

# Link object files to produce executable
$(EXEC): $(OBJ_FILES)
	$(CC) $(OBJ_FILES) -o $@ $(LDFLAGS)

# Compile source files to object files in OBJ_DIR
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# Clean object files
clean:
	$(RM) $(OBJ_FILES)

# Clean object files and executable
fclean: clean
	$(RM) $(EXEC)

# Full rebuild
re: fclean all

# Phony targets
.PHONY: all clean fclean re