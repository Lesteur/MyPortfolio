#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "maze.h"
#include "graph.h"

maze * maze_create(int id, int width, int height)
{
    maze * m = (maze *) malloc(sizeof(maze));
    if (m == NULL)
    {
        fprintf(stderr, "Failed to allocate memory for maze\n");
        return NULL;
    }
    
    m->id = id;
    m->width = width;
    m->height = height;

    // Initialize the grid with walls and the visited array
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            graph_node * node = &m->grid[i][j];

            node->id = i * width + j; // Unique ID for each node
            node->num_edges = 0; // Initially no edges
        }
    }

    m->start_x = -1;
    m->start_y = -1;
    m->end_x = -1;
    m->end_y = -1;

    return m;
}

void maze_destroy(maze * m)
{
    if (m != NULL)
        free(m);
}

void maze_set_start(maze * m, int x, int y)
{
    if (m != NULL && x >= 0 && x < m->width && y >= 0 && y < m->height)
    {
        m->start_x = x;
        m->start_y = y;
    }
    else
    {
        fprintf(stderr, "Invalid start position\n");
    }
}

void maze_set_end(maze * m, int x, int y)
{
    if (m != NULL && x >= 0 && x < m->width && y >= 0 && y < m->height)
    {
        m->end_x = x;
        m->end_y = y;
    }
    else
    {
        fprintf(stderr, "Invalid end position\n");
    }
}

graph_node * maze_get_path(maze * m, int start_x, int start_y)
{
    if (m == NULL || start_x < 0 || start_x >= m->width || start_y < 0 || start_y >= m->height)
    {
        fprintf(stderr, "Invalid maze or starting position\n");
        return NULL;
    }

    graph_node * start_node = graph_node_create(0); // Create the starting node
    if (start_node == NULL)
    {
        return NULL; // Memory allocation failed
    }

    // Implement pathfinding logic here (e.g., DFS, BFS) to populate the graph nodes
    // For now, we will just return the starting node as a placeholder

    return start_node;
}

bool maze_is_valid(maze * m)
{
    if (m == NULL)
    {
        fprintf(stderr, "Maze is NULL\n");
        return false;
    }

    // Check if start and end points are set
    if (m->start_x < 0 || m->start_y < 0 || m->end_x < 0 || m->end_y < 0)
    {
        fprintf(stderr, "Start or end point not set\n");
        return false;
    }

    // Additional validation logic can be added here (e.g., checking for walls, connectivity)

    return true;
}

void maze_print(maze * m)
{
    if (m == NULL) {
        fprintf(stderr, "Maze is NULL\n");
        return;
    }
}

maze * maze_import(const char * filename)
{
    maze * m = NULL;

    // Implement maze import logic here

    return m;
}