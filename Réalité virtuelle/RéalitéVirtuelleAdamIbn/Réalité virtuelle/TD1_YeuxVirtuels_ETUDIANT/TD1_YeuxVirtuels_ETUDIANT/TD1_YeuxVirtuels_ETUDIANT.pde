/****************************************************************************/
/*  MESNARD Emmanuel                                                ISIMA   */
/*                                                                          */
/*      TD1 : Yeux interactifs, qui suivent la souris en temps réel         */
/*                                                                          */
/*  TD1_YeuxVirtuels.pde                                   Processing 4.2   */
/****************************************************************************/

float Xg, Yg; // Positions "regard" de l'oeil gauche
float Xd, Yd; // Oeil droit

// Fonction d'initialisation de l'application - executee une seule fois
void setup() {
  size(640, 480);
  surface.setTitle("TD 1 - Yeux Virtuels suivi de souris - E. Mesnard / ISIMA");
  stroke(0);
  smooth();
  // Intervalle oeil gauche : (X,Y)min = (190,200); (X,Y)max = (250,300)
  Xg = 220;
  Yg = 250;
  // Intervalle oeil droit : (X,Y)min = (366,180); (X,Y)max = (435,320)
  Xd = 400;
  Yd = 250;
}

void draw() {
  background(#BCD8D3);

  // Deplacements en proportion des mouvements au sein de la fenetre
  
  
  // Trace oeil gauche
  fill(#F7F3C8);
  ellipse(220, 250, 108, 240);
  fill(0);
  ellipse(Xg, Yg, 30, 90);
  fill(#EADF5A);
  ellipse(Xg, Yg+5, 12, 12);

  // Trace oeil droit
  fill (#F7F3C8);
  ellipse(400, 250, 108, 300);
  fill(0);
  ellipse(Xd, Yd, 30, 90);
  fill(#EADF5A);
  ellipse(Xd, Yd+5, 12, 12);
}
