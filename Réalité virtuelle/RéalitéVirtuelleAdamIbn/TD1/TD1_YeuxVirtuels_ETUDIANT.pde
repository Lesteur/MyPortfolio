/****************************************************************************/
/*  MESNARD Emmanuel                                                ISIMA   */
/*                                                                          */
/*      TD1 : Yeux interactifs, qui suivent la souris en temps réel         */
/*                                                                          */
/*  TD1_YeuxVirtuels.pde                                   Processing 4.2   */
/****************************************************************************/

// Declarations de constantes : Quelques couleurs...
final int rouge = color(255,0,0); 
final int vert  = color(0,255,0); 
final int bleu  = color(0,0,255);
final int noir  = color(0,0,0); 
final int blanc = color(255,255,255); 

float Xg, Yg; // Positions "regard" de l'oeil gauche
float Xd, Yd; // Oeil droit
boolean lock;

int totalMolette;

// Fonction d'initialisation de l'application - executee une seule fois
void setup() {
  size(640, 480);
  colorMode(HSB, 360, 100, 100); // Changement de mode
  surface.setTitle("TD 1 - Yeux Virtuels suivi de souris - E. Mesnard / ISIMA");
  stroke(0);
  smooth();
  // Intervalle oeil gauche : (X,Y)min = (190,200); (X,Y)max = (250,300)
  Xg = 220;
  Yg = 250;
  // Intervalle oeil droit : (X,Y)min = (366,180); (X,Y)max = (435,320)
  Xd = 400;
  Yd = 250;
  
  lock = false;
}

void draw() {
  background(color(totalMolette%360, 100, 100));
  
  if (!lock) {
    // Deplacements en proportion des mouvements au sein de la fenetre
    Xg = map(mouseX, 0, width, 220 - 30, 220 + 30);
    Yg = map(mouseY, 0, height, 250 - 40, 250 + 40);
    
    Xd = map(mouseX, 0, width, 400 - 30, 400 + 30);
    Yd = map(mouseY, 0, height, 250 - 60, 250 + 60);
  }
  
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

void mousePressed() { // Fonction invoquee lors de l'appui sur un des deux boutons
  if (mouseButton == RIGHT) {
    if (lock) {
      lock = false;
    } else {
      lock = true;
    }
  }
}

void mouseWheel(MouseEvent event) {
  totalMolette += event.getCount() * 10; // Prise en compte de l'evenement
  println(totalMolette); // Affichage retour console pour debug
  // Affichage des informations sur la fenetre de l'application
  text("Total du decalage molette centrale : ",10,20);
  text(str(totalMolette),222,20);
}
