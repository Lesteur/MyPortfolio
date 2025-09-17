/**
 * \file graph.h
 * \brief Header file for graph structure and related functions.
 *
 * Defines the graph structure, its properties, and functions to manipulate graphs.
 *
 */
#ifndef GRAPH_H
#define GRAPH_H

#include <stdbool.h>

/**
 * \struct graph_node
 * \brief Structure representing a node in a graph.
 */
typedef struct graph_node
{
    int id;                         // Unique identifier for the node
    int num_edges;                  // Number of edges connected to this node
    struct graph_node * edges[4];   // Array of edges (linked nodes) connected to this node
    int visited;                    // Flag to indicate if the node has been visited in a traversal
} graph_node;

/**
 * \fn graph_node * graph_node_create(int id)
 * \brief Creates a new graph node with the specified ID.
 *
 * \param id Unique identifier for the graph node.
 */
graph_node * graph_node_create(int id);

/**
 * \fn void graph_node_destroy(graph_node * node)
 * \brief Destroys a graph node and frees associated memory.
 *
 * \param node Pointer to the graph node to be destroyed.
 * \param recursive If true, recursively destroys linked nodes as well.
 */
void graph_node_destroy(graph_node * node, bool recursive);

/**
 * \fn bool graph_node_add_link(graph_node * node, graph_node * linked_node)
 * \brief Adds a link (edge) from the current node to another node.
 *
 * \param node Pointer to the current graph node.
 * \param linked_node Pointer to the graph node to be linked.
 * \return true if the link was successfully added, false if the maximum number of edges is reached.
 */
bool graph_node_add_link(graph_node * node, graph_node * linked_node);

#endif // GRAPH_H