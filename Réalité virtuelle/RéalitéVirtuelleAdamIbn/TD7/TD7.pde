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
PShape objetOBJ;        // Objet a charger
PShape boundingBoxOBJ;  // Boite englobante
float dimOBJ_X, dimOBJ_Y, dimOBJ_Z; // Dimensions de l'objet

boolean traceBB_OBJ; // Flag pour le trace de la bounding box

PShape[] objects;
int id_obj;

// Analyse complementaire pour determiner la position du repere dans l'objet
// -------------------------------------------------------------------------
PShape partieObj; // Analyse de l'objet par morceaux (enfants dans un objet)
int nombreEnfant;
int nombreVertex, nombreVertexTotal; // Nombres de Vertex
// Amplitudes de l'objet, initialisees aux extremes opposes
float minX = 3.40282347E+38; // min et max sur les 3 dimensions
float minY = 3.40282347E+38;
float minZ = 3.40282347E+38;
float maxX = -3.40282347E+38;
float maxY = -3.40282347E+38;
float maxZ = -3.40282347E+38;
// Coordonnees du vertex en cours de traitement
float vX, vY, vZ;
// Decalage a appliquer pour positionner correctement l'objet
float decX, decY, decZ;

MultiMarker sceneMM; // Scene de recherche de "multi-marqueur"
MultiNft sceneNft;
boolean RE2D_RA3D;   // Choix du mode : Realite Enrichie 2D, ou Realite Augmentee 3D
boolean debugFlag;
float facteurEchelle; // Mise a l'echelle pour un meilleur rendu

// Fonction d'initialisation de l'application - executee une seule fois
void setup() {
  
  // Initialisation des parametres graphiques utilises
  size(640, 480, P3D); // ouverture en mode 3D (ou 2D, car selection du mode par RE2D_RA3D)
  surface.setTitle("Exemple 12 - Realite Augmentee - E. Mesnard / ISIMA");
  noFill();
  stroke(#E802B7); // Couleur violacee
  strokeWeight(1);
  
  objects = new PShape[3];
  objects[0] = initObject("3D/moon.obj", 1);
  objects[1] = initObject("3D/dragon.obj", 3);
  objects[2] = initObject("3D/rocket.obj", 0.5);
  
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
    //webCam = new Capture(this, cameras[cameras.length-1]);
    webCam = new Capture(this, cameras[0]);
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
    
  }
}

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
  
  if (debugFlag) {
    stroke(#FF0000);
    line(0, 0, 0, 40, 0, 0);
    stroke(#00FF00);
    line(0, 0, 0, 0, 40, 0);
    stroke(#0000FF);
    line(0, 0, 0, 0, 0, 40);
  }
  
  // Affichage des objets
  lights(); // avec un peu de lumiere !
  shape(objects[id_obj]);
  //if (traceBB_OBJ) shape(boundingBoxOBJ);
  // A noter que les objets sont souvent translates...
  // et orientes etrangement !
  
  sceneNft.endTransform();
}

void keyPressed() {
  if (key == 'i') {
    println(frameRate); // Affichage du nombre de "draw" a la seconde
    debugFlag = !debugFlag; // Changement de mode
    traceBB_OBJ = !traceBB_OBJ;
  } else if (key == 'f') {
    id_obj = (id_obj + 1) % 3;
  }
}

// Fonction appelee lors de la fermeture de la fenetre windows
// par un clic sur la croix de fermeture de la fenetre...
void exit() {
  println("ATTENTION : Le programme s'arrete, donc cloture WebCam !!");
  if (0 != cameras.length) webCam.stop(); // Arret "propre" de la webcam
  super.exit();  // Re envoi de l'exit pour quitter reellement
}
