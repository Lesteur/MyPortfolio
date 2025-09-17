/**
 * \file maze.h
 * \brief Header file for maze structure and related functions.
 *
 * Defines the maze structure, its properties, and functions to manipulate mazes.
 *
 */
#ifndef MAZE_H
#define MAZE_H

#include <stdbool.h>
#include "graph.h"

/**
 * \def MAZE_H
 * \brief The maximum height of the maze.
 */
#define MAZE_HEIGHT 100

/**
 * \def MAZE_W
 * \brief The maximum width of the maze.
 */
#define MAZE_WIDTH 100

/**
 * \struct maze
 * \brief Structure representing a maze.
 * Contains properties such as dimensions, grid representation, start and end points,
 * and a visited array for traversal tracking.
 */
typedef struct
{
    int id;                                     // Unique identifier for the maze
    int width;                                  // Width of the maze
    int height;                                 // Height of the maze
    graph_node grid[MAZE_HEIGHT][MAZE_WIDTH];   // 2D array representing the maze structure
    int start_x;                                // X-coordinate of the starting point
    int start_y;                                // Y-coordinate of the starting point
    int end_x;                                  // X-coordinate of the ending point
    int end_y;                                  // Y-coordinate of the ending point
    // int visited[MAZE_HEIGHT][MAZE_WIDTH]; // 2D array to track visited cells during traversal
} maze;

/**
 * \fn maze * maze_create(int id, int width, int height)
 * \brief Creates a new maze with the specified dimensions.
 * 
 * \param id Unique identifier for the maze.
 * \param width Width of the maze.
 * \param height Height of the maze.
 * \return Pointer to the newly created maze structure.
 */
maze * maze_create(int id, int width, int height);

/**
 * \fn void maze_destroy(maze * m)
 * \brief Destroys the maze and frees associated memory.
 * 
 * \param m Pointer to the maze structure to be destroyed.
 */
void maze_destroy(maze * m);

/**
 * \fn void maze_set_start(maze * m, int x, int y)
 * \brief Sets the starting position of the maze.
 *
 * \param m Pointer to the maze structure.
 * \param x X-coordinate of the starting position.
 * \param y Y-coordinate of the starting position.
 */
void maze_set_start(maze * m, int x, int y);

/**
 * \fn void maze_set_end(maze * m, int x, int y)
 * \brief Sets the ending position of the maze.
 *
 * \param m Pointer to the maze structure.
 * \param x X-coordinate of the ending position.
 * \param y Y-coordinate of the ending position.
 */
void maze_set_end(maze * m, int x, int y);

/**
 * \fn graph_node * maze_get_path(maze * m, int start_x, int start_y)
 * \brief Finds a path through the maze starting from the specified coordinates.
 *
 * \param m Pointer to the maze structure.
 * \param start_x X-coordinate of the starting position.
 * \param start_y Y-coordinate of the starting position.
 * \return Pointer to a graph node representing the path found in the maze.
 */
graph_node * maze_get_path(maze * m, int start_x, int start_y);

/**
 * \fn bool maze_is_valid(maze * m)
 * \brief Checks if the maze is valid.
 *
 * \param m Pointer to the maze structure.
 * \return True if the maze is valid, false otherwise.
 */
bool maze_is_valid(maze * m);

/**
 * \fn void maze_print(maze * m)
 * \brief Prints the maze to the console.
 *
 * \param m Pointer to the maze structure to be printed.
 */
void maze_print(maze * m);

/**
 * \fn maze * maze_import(const char * filename)
 * \brief Imports a maze from a file.
 *
 * \param filename Name of the file containing the maze data.
 * \return Pointer to the imported maze structure, or NULL if the import fails.
 */
maze * maze_import(const char * filename);

#endif // MAZE_H