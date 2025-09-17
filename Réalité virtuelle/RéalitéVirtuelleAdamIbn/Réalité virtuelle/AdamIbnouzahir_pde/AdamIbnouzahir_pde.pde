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
boolean lock = false;

int totalMolette; // Gestion de la roulette centrale

// Fonction d'initialisation de l'application - executee une seule fois
void setup() {
  size(640, 480);
  surface.setTitle("TD 1 - Yeux Virtuels suivi de souris - E. Mesnard / ISIMA");
  colorMode(HSB, 255,200,200);
  stroke(0);
  smooth();
  // Intervalle oeil gauche : (X,Y)min = (190,200); (X,Y)max = (250,300)
  Xg = 220;
  Yg = 250;
  // Intervalle oeil droit : (X,Y)min = (366,180); (X,Y)max = (435,320)
  Xd = 400;
  Yd = 250;
}

void mousePressed() { // Fonction invoquee lors de l'appui sur un des deux boutons
  if (lock) {
    lock = false;
  } else {
    lock = true;
  }
}

void draw() {
  //background(#BCD8D3);
  background(color(totalMolette%360,100,100));

  // Deplacements en proportion des mouvements au sein de la fenetre
  
  if (!lock) {
  //Oeil gauche
  Xg = map(mouseX, 0, width, 260, 220 - 20, 220 + 20);
  
  //Oeil droit
  
  Xd = mouseX;
  
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

void mouseWheel(MouseEvent event) {
  totalMolette += 5*event.getCount(); // Prise en compte de l'evenement
  println(totalMolette); // Affichage retour console pour debug
}

void keyPressed() {
  // Analyse des caracteres "etendus"
  switch (keyCode) {
    // Fleches : LEFT, RIGHT, UP, DOWN
    case LEFT    : text("Hello World !", 10, 10);
                   break;
    case RIGHT   : text("Saturation actuelle : " + str(totalMolette%360), 10, 10);
                   break;
    case UP      : text("Position des yeux :", 10, 10);
                   text("Oeil gauche : " + str(Xg) + " " + str(Yg), 10, 20);
                   text("Oeil droite : " + str(Xd) + " " + str(Yd), 10, 30);
                   break;
    // Autres Touches speciales : CONTROL, ALT et SHIFT
  }
}
