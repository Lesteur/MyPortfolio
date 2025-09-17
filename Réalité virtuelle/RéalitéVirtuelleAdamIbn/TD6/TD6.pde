/****************************************************************************/
/*  MESNARD Emmanuel                                              ISIMA     */
/*                                                                          */
/*          Exemple 12 : Realite Augmentee par ARtoolkit et Webcam          */
/*                       avec marqueur de type Pattern                      */
/*                       Un appui sur une touche passe de la Realite        */
/*                       Enrichie 2D a la Realite Augmentee spatiale 3D     */
/*                                                                          */
/*                       Webcam via le mode "Capture" basee sur GStreamer   */
/*                                                                          */
/* Exemple_12_Realite_Augmentee.pde                      Processing 4.3     */
/****************************************************************************/

// Importation des librairies
import jp.nyatla.nyar4psg.*;   // ARToolKit (version 3.0.10

import processing.video.*;     // Bibliotheque de controle camera

// Parametres de taille de la capture video
final int widthCapture=640;  // largeur capture
final int heightCapture=480; // hauteur capture
final int numPixels=widthCapture*heightCapture; // nombre de pixels d'une image video
final int fpsCapture=30;     // taux d'images/secondes

// Declaration des variables globales
Capture webCam;      // Declaration de la Capture par Camera
String[] cameras;    // Liste textuelle des webCams disponibles

MultiMarker sceneMM; // Scene de recherche de "multi-marqueur"
MultiNft sceneNft;
boolean RE2D_RA3D;   // Choix du mode : Realite Enrichie 2D, ou Realite Augmentee 3D
boolean debugFlag;

ArrayList<Firework> fireworks;

PVector gravity = new PVector(0, 0.2);

// Fonction d'initialisation de l'application - executee une seule fois
void setup() {
  // Initialisation des parametres graphiques utilises
  size(640, 480, P3D); // ouverture en mode 3D (ou 2D, car selection du mode par RE2D_RA3D)
  surface.setTitle("Exemple 12 - Realite Augmentee - E. Mesnard / ISIMA");
  noFill();
  stroke(#E802B7); // Couleur violacee
  strokeWeight(1);
  
  debugFlag = true;

  // Recherche des webCams disponibles, par interrogation du systeme d'exploitation
  cameras = Capture.list();
  if (cameras==null) {
    // Le systeme d'exploitation n'a pas repondu
    // Tentative d'ouverture d'une webcam par defaut
    webCam= new Capture(this, 640, 480);
    webCam.start(); // Mise en marche de la webCam
  } else if (0 == cameras.length) {
    println("Pas de Webcam sur cet ordinateur !");
    exit();
  } else {
    // Choix explicite de la derniere camera de la liste :
    webCam = new Capture(this, cameras[cameras.length-1]);
    webCam.start(); // Mise en marche de la webCam
  }

  // Declaration de la scene de recherche avec parametres par defaut :
  // calibration de camera et systeme de coordonnees
  
  sceneNft = new MultiNft(this, widthCapture, heightCapture,
      "camera_para.dat",
      NyAR4PsgConfig.CONFIG_PSG);

  // Declaration du marqueur a rechercher, avec sa dimension en mm
  
  sceneNft.addNftTarget("ISIMA_30ans_NFT", 80);
  println(MultiNft.VERSION);

  RE2D_RA3D = false; // Mode RE par defaut
  println("Mode Réalité Enrichie, avec informations en coordonnées Image");
  println("    Appuyer sur une touche pour changer de mode");
  
  fireworks = new ArrayList<Firework>();
} // Fin de Setup


// Fonction de re-tracage de la fenetre - executee en boucle
void draw() {
  if (webCam.available() == true) { // Verification de presence d'une nouvelle frame

    webCam.read(); // Lecture du flux sur la camera... lecture d'une frame

    sceneNft.detect(webCam);   // Recherche du marqueur dans la scene
    webCam.updatePixels();    // Mise a jour des pixels

    background(0); // Efface l'ecran
    image(webCam, 0, 0);  // Affiche l'image prise par la webCam

    // Incrustation de l'image virtuelle si marqueur trouve
    if (sceneNft.isExist(0)) {
      // Le marqueur 0 est effectivement detecte dans le flux video
      V2_RA_en_Coordonnees_Marqueur();
    }
    
    for (int i = fireworks.size()-1; i >= 0; i--) {
      Firework f = fireworks.get(i);
      f.run();
      if (f.done()) {
        fireworks.remove(i);
      }
    }
    
  }
}

/*
void V1_RE_en_Coordonnees_Image() {
  PVector[] pos2d; // Position 2D du marqueur dans le repere Image
  String s; // Chaine de caracteres a afficher
  int i; // Indice de boucle pour traitement sur les 4 coins

  // Lecture du vecteur position
  pos2d = sceneNft.getMarkerVertex3D(0);

  // Trace du pourtour du marqueur
  stroke(#E802B7); // Couleur violacee
  strokeWeight(2);
  line(pos2d[0].x, pos2d[0].y, pos2d[1].x, pos2d[1].y);
  line(pos2d[2].x, pos2d[2].y, pos2d[1].x, pos2d[1].y);
  line(pos2d[2].x, pos2d[2].y, pos2d[3].x, pos2d[3].y);
  line(pos2d[0].x, pos2d[0].y, pos2d[3].x, pos2d[3].y);

  for (i=0; i<pos2d.length; i++) { // Pour les 4 coins..., car pos2d.length doit etre egal a 4
    // Trace des 4 points 2D, aux 4 coins du marqueur
    fill(#F70A36); // Couleur rouge assez vif
    noStroke();
    ellipse(pos2d[i].x, pos2d[i].y, 20, 20);

    // Trace des 4 étiquettes
    // Creation de la chaine, et ecriture en noir sur fond azur
    s = "(" + int(pos2d[i].x) + "," + int(pos2d[i].y) + ")";
    strokeWeight(1);
    stroke(#0B7CAF);
    fill(#0B7CAF); // Couleur bleutee
    rect(pos2d[i].x, pos2d[i].y, textWidth(s)+6, textAscent()+textDescent()+3);
    fill(0);
    text(s, pos2d[i].x + 5, pos2d[i].y + textAscent()+2); // Ecriture effective sur l'image
  }
}
*/

void V2_RA_en_Coordonnees_Marqueur() {
  // Changement de repere pour tracer en coordonnees "Marqueur"
  sceneNft.beginTransform(0); // Modification graphique sur marqueur 0
  // Ce beginTransform provoque le changement de repere dans Processing
  // Toutes les commandes de traces se feront
  // par rapport au nouveau système de coordonnees

  strokeWeight(2); // Trait epais
  stroke(#E802B7); // Couleur violacee
  noFill(); // Sans remplissage
  // Dessin en mode 3D : ici, un cube de 80mm
  translate(0, 0, 40); // Placement du cube au dessus
  // du marqueur, donc Z=40mm
  //box(80, 80, 80);     // Cube de 8 cm de cote
  
  fireworks.add(new Firework());
  
  if (debugFlag) {
    stroke(#FF0000);
    line(0, 0, 0, 40, 0, 0);
    stroke(#00FF00);
    line(0, 0, 0, 0, 40, 0);
    stroke(#0000FF);
    line(0, 0, 0, 0, 0, 40);
  }
  
  sceneNft.endTransform();
}

void keyPressed() {
  println(frameRate); // Affichage du nombre de "draw" a la seconde
  debugFlag = !debugFlag; // Changement de mode
}

// Fonction appelee lors de la fermeture de la fenetre windows
// par un clic sur la croix de fermeture de la fenetre...
void exit() {
  println("ATTENTION : Le programme s'arrete, donc cloture WebCam !!");
  if (0 != cameras.length) webCam.stop(); // Arret "propre" de la webcam
  super.exit();  // Re envoi de l'exit pour quitter reellement
}
