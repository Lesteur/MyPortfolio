/**
 * \file floodit.c
 * \brief Flood it SDL2
 * \author Adam Ibnouzahir
 * \version 1.0
 */

#include "floodit.h"

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <math.h>
#include <time.h>

int grilleGlobale[TAILLE][TAILLE];
int tentatives;


int initialiser(int grille[TAILLE][TAILLE])
{
    int i, j;

    for (i = 0; i < TAILLE; i++)
    {
        for (j = 0; j < TAILLE; j++)
        {
            grille[i][j] = rand() % COULEURS;
        }
    }

    return 0;
}


void afficher(int grille[TAILLE][TAILLE])
{
    int i, j;

    printf("  j ");
    for (i = 0; i < TAILLE; i++)
    {
        printf("%d ", i);
        if (i < 10)
            printf(" ");
    }

    printf("\n");

    printf("i  ");
    for (i = 0; i < TAILLE; i++)
        printf("---");
    printf("-\n");

    for (i = 0; i < TAILLE; i++)
    {
        printf("%d ", i);
        if (i < 10)
            printf(" ");

        for (j = 0; j < TAILLE; j++)
        {
            printf("|\033[%dm%d \033[0m", grille[i][j] + 41, grille[i][j]);
        }
        printf("| \n");

        printf("   ");
        for (j = 0; j < TAILLE; j++)
            printf("---");
        printf("-\n");

    }

    printf("\n");
}


int fin(int grille[TAILLE][TAILLE])
{
    int i, j;
    int couleur = grille[0][0];

    for (i = 0; i < TAILLE; i++)
    {
        for (j = 0; j < TAILLE; j++)
        {
            if (grille[i][j] != couleur)
                return 0;
        }
    }

    return 1;
}


void remplir(int grille[TAILLE][TAILLE], int couleur1, int couleur2, int i, int j)
{
    if (i < 0 || i >= TAILLE || j < 0 || j >= TAILLE)
        return;

    if (grille[i][j] == couleur2)
        return;

    if (grille[i][j] != couleur1)
        return;

    grille[i][j] = couleur2;

    remplir(grille, couleur1, couleur2, i - 1, j);
    remplir(grille, couleur1, couleur2, i + 1, j);
    remplir(grille, couleur1, couleur2, i, j - 1);
    remplir(grille, couleur1, couleur2, i, j + 1);
}