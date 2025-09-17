#ifndef floodit_h
#define floodit_h

/**
 * @def TAILLE
 * @brief Taille de la grille
 */
#define TAILLE 12


/**
 * @def COULEURS
 * @brief Nombre de couleurs
 */
#define COULEURS 6

/**
 * @def ROUGE
 * @brief Couleur rouge
 */
#define ROUGE 0

/**
 * @def VERT
 * @brief Couleur verte
 */
#define VERT 1

/**
 * @def BLEU
 * @brief Couleur bleue
 */
#define BLEU 2

/**
 * @def JAUNE
 * @brief Couleur jaune
 */
#define JAUNE 3

/**
 * @def CYAN
 * @brief Couleur cyan
 */
#define CYAN 4

/**
 * @def MAGENTA
 * @brief Couleur magenta
 */
#define MAGENTA 5

/**
 * @def BLANC
 * @brief Couleur blanche
 */
#define BLANC 6

/**
 * @def NOIR
 * @brief Couleur noire
 */
#define NOIR 7

/**
 * @def COUP_MAX
 * @brief Nombre de coups maximum
 */
#define COUP_MAX 22


/**
 * @var int grilleGlobale
 * @brief Grille de jeu
 */
extern int grilleGlobale[TAILLE][TAILLE];


/**
 * @var int tentatives
 * @brief Nombre de tentatives
 */
extern int tentatives;


/**
 * @fn int initialiser()
 * @brief Initialise la grille de Flood it
 *
 * @param grille La grille de Flood it
 * @return 0
 */
int initialiser(int grille[TAILLE][TAILLE]);


/**
 * @fn void afficher(int grille[TAILLE][TAILLE])
 * @brief Affiche la grille de Flood it
 *
 * @param grille La grille de Flood it
 * @return void
 */
void afficher(int grille[TAILLE][TAILLE]);


/**
 * @fn int fin(int grille[TAILLE][TAILLE])
 * @brief Vérifie si la grille est pleine
 *
 * @param grille La grille de Flood it
 * @return 1 si la grille est pleine, 0 sinon
 */
int fin(int grille[TAILLE][TAILLE]);


/**
 * @fn void remplir(int grille[TAILLE][TAILLE], int couleur1, int couleur2, int i, int j)
 * @brief Remplit la grille de Flood it

 * @param grille La grille de Flood it
 * @param couleur1 La couleur à remplacer
 * @param couleur2 La nouvelle couleur
 * @param i L'indice de la ligne
 * @param j L'indice de la colonne

 * @return void
 */
void remplir(int grille[TAILLE][TAILLE], int couleur1, int couleur2, int i, int j);

#endif