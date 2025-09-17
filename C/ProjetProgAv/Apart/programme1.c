#include <stdio.h>
#include <stdlib.h>
#include <time.h>

struct _Taquin
{
  int ** puzzle;
  int n;
  int i;
  int j;
};
typedef struct _Taquin Taquin;

int ** CreerTab(int n)
{
  int ** tab = malloc(sizeof(int*)*n);
  for (int i = 0; i < n; i++)
  {
    tab[i] = malloc(sizeof(int)*n);
    for (int j = 0; j < n; j++)
    {
      tab[i][j] = i*4+j + 1;
    }
  }
  tab[n-1][n-1] = 0;
  return tab;
}

void FreeTaquin(Taquin * puzzle)
{
  for (int i = 0; i < puzzle->n; i++)
  {
    free(puzzle->puzzle[i]);
  }
  free(puzzle->puzzle);
  free(puzzle);
}

void AfficheTaquinTextuel(Taquin * taquin)
{
  int nb;
  int n = taquin->taille;
  for (int i = 0; i < n; i++)
  {
    for (int j = 0; j < n; j++)
    {
      nb = taquin->puzzle[i][j];
      if (nb >= 10)
        printf("%d |", nb);
      else if (nb == 0)
        printf("   |");
      else
        printf("%d  |", nb);
    }
    printf("\n");
    for (int j = 0; j < n; j++)
      printf("----");
    printf("\n");
  }
}

Taquin * CreerTaquin(int n)
{
  Taquin * puzzle = malloc(sizeof(Taquin));
  puzzle->puzzle = CreerTab(n);
  puzzle->n = n;
  puzzle->i = n-1;
  puzzle->j = n-1;
  return puzzle;
}

void BougeTaquin(Taquin * puzzle, char touche)
{
  int ** tab = puzzle->puzzle;
  int i = puzzle->i;
  int j = puzzle->j;
  int n = puzzle->n;
  switch (touche)
  {
    case 'g':
      if (j != 0)
      {
        tab[i][j] = tab[i][j-1];
        tab[i][j-1] = 0;
        puzzle->j = j-1;
      }
      break;
    case 'd':
      if (j != n-1)
      {
        tab[i][j] = tab[i][j+1];
        tab[i][j+1] = 0;
        puzzle->j = j+1;
      }
      break;
    case 'h':
      if (i != 0)
      {
        tab[i][j] = tab[i-1][j];
        tab[i-1][j] = 0;
        puzzle->i = i-1;
      }
      break;
    case 'b':
      if (i != n-1)
      {
        tab[i][j] = tab[i+1][j];
        tab[i+1][j] = 0;
        puzzle->i = i+1;
      }
      break;
  }
}

void InitTaquin(Taquin * puzzle, int iter)
{
  int nb, n;
  for (int i = 0; i < iter; i++)
  {
    nb = rand() % 4;
    switch(nb)
    {
      case 0:
        BougeTaquin(puzzle, 'g');
        break;
      case 1:
        BougeTaquin(puzzle, 'd');
        break;
      case 2:
        BougeTaquin(puzzle, 'h');
        break;
      case 3:
        BougeTaquin(puzzle, 'b');
        break;
    }
  }
  n = puzzle->n - puzzle->j - 1;
  for (int i = 0; i < n; i++)
    BougeTaquin(puzzle, 'd');
  n = puzzle->n - puzzle->i - 1;
  for (int j = 0; j < n; j++)
    BougeTaquin(puzzle, 'b');
}

int main()
{
  srand(time(NULL));
  int n = 4;
  char touche = '0';
  Taquin * puzzle = CreerTaquin(n);
  InitTaquin(puzzle, 100);
  do
  {
    system("clear");
    AfficheTaquin(puzzle, n);
    printf("\nCommande ?\n");
    scanf("%c", &touche);
    BougeTaquin(puzzle, touche);
  } while (touche != '0');
  FreeTaquin(puzzle);
}
