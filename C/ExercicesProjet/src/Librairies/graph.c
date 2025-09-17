#include <stdlib.h>
#include <stdio.h>
#include "graph.h"

graph_node * graph_node_create(int id)
{
    graph_node * node = malloc(sizeof(graph_node));
    
    if (node == NULL)
    {
        fprintf(stderr, "Failed to allocate memory for graph node\n");
        return NULL;
    }
    
    node->id = id;
    node->num_edges = 0;
    node->visited = 0; // Initially not visited

    return node;
}

void graph_node_destroy(graph_node * node, bool recursive)
{
    if (node != NULL)
    {
        if (recursive)
        {
            // Recursively destroy linked nodes if needed
            for (int i = 0; i < node->num_edges; i++)
            {
                graph_node_destroy(node->edges[i], true);
            }
        }

        free(node);
    }
}

bool graph_node_add_link(graph_node * node, graph_node * linked_node)
{
    if (node == NULL || linked_node == NULL)
    {
        fprintf(stderr, "Invalid node or linked node\n");
        return false;
    }

    if (node->num_edges < 4) // Assuming a maximum of 4 edges
    {
        node->edges[node->num_edges] = linked_node; // Copy the linked node
        node->num_edges++;
        return true;
    }
    else
    {
        fprintf(stderr, "Maximum number of edges reached for node %d\n", node->id);
        return false;
    }
}