/****************************************************************************/
/*  MESNARD Emmanuel                                                ISIMA   */
/*                                                                          */
/*              Les bases : Ouverture d'une fenetre                         */
/*                                                                          */
/* Exemple_1_Fenetre_Titre.pde                             Processing 4.2   */
/****************************************************************************/

// Fonction d'initialisation de l'application - executee une seule fois
void setup() {
  // Initialisation des parametres graphiques utilises
  size(600, 300); // Fenetre de 600*300, sans appeler la carte graphique
  // size(600,300,P2D); // Fenetre de 600*300 avec acceleration carte graphique, en 2D
  surface.setTitle("Exemple 1 Basique : Fenetre avec titre - E. Mesnard / ISIMA");
  background(0); // Fond noir
}

// Fonction de re-tracage de la fenetre - executee en boucle
void draw() {
  // Ne rien faire de particulier !
}
