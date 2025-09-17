/****************************************************************************/
/*  MESNARD Emmanuel                                              ISIMA     */
/*                                                                          */
/*        Utilisation d'une des cameras (avec Ketai) sous Android           */
/*  infos supplementaires : http://ketai.org/reference/camera/ketaicamera/  */
/*                                                                          */
/* Exemple_17_Android_Camera_Ketai.pde           Processing 4.3 - ANDROID   */
/****************************************************************************/

// Import bibliotheques
import jp.nyatla.nyar4psg.*;   // ARToolKit (version 3.0.10
import ketai.camera.*;
import ketai.ui.*;

// Declaration des variables globales
KetaiCamera cam; // Camera
KetaiGesture gesture;
int nbCamera;
Boolean plusieursCamera;
PImage ImageCourante;
Boolean nouvelleFrame = false;

MultiMarker sceneMM; // Scene de recherche de "multi-marqueur"
boolean RE2D_RA3D;   // Choix du mode : Realite Enrichie 2D, ou Realite Augmentee 3D
boolean debugFlag;

PShape[] objects;
int id_obj;

// Analyse complementaire pour determiner la position du repere dans l'objet
// -------------------------------------------------------------------------
PShape objetOBJ;        // Objet a charger
PShape boundingBoxOBJ;  // Boite englobante
float dimOBJ_X, dimOBJ_Y, dimOBJ_Z; // Dimensions de l'objet
boolean traceBB_OBJ; // Flag pour le trace de la bounding box

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
float facteurEchelle; // Mise a l'echelle pour un meilleur rendu
float scales[];
float scales_min[];
float scales_max[];

// Fonction d'initialisation de l'application - executee une seule fois
void setup() {
  fullScreen(P3D);
  orientation(LANDSCAPE); // Forcage du mode

  // Gestion du mode d'affichage
  imageMode(CENTER); // Mode centre pour garantir que l'image sera visible
  textAlign(CENTER, CENTER);
  textSize(displayDensity * 25); // Parametrage de la police pour etre lisible
  
  // Mise en place de la gestion des mouvements sur ecran
  gesture = new KetaiGesture(this);
  
  objects = new PShape[3];
  scales = new float[3];
  scales_min = new float[3];
  scales_max = new float[3];
  scales[0] = 1;
  scales[1] = 3;
  scales[2] = 0.5;
  
  scales_min[0] = 0.5;
  scales_min[1] = 2.5;
  scales_min[2] = 0.2;
  
  scales_max[0] = 1.5;
  scales_max[1] = 3.5;
  scales_max[2] = 1;
  
  objects[0] = initObject("3D/moon.obj", scales[0]);
  objects[1] = initObject("3D/dragon.obj", scales[1]);
  objects[2] = initObject("3D/rocket.obj", scales[2]);

  // Ouverture du systeme de gestion des cameras a 24 fps
  cam = new KetaiCamera(this, 1280, 720, 24);
  if (cam != null) {
    nbCamera = cam.getNumberOfCameras();
    plusieursCamera = (nbCamera>1);
  }
  
  sceneMM = new MultiMarker(this, 1280, 720,
    "camera_para.dat",
    NyAR4PsgConfig.CONFIG_PSG);
   
  sceneMM.addARMarker("MM/Marqueur_Kanji.patt", 80); // Marqueur numero 0
  println(MultiMarker.VERSION); // Affichage numero version en console
}

void draw() {
  if (cam != null && cam.isStarted()) {
    // La camera fonctionne correctement et des donnees sont disponibles
    if (nouvelleFrame) { // Mise a jour que si nouvelle Frame
      sceneMM.detect(cam);   // Recherche du marqueur dans la scene
      
      image(cam, width/2, height/2, width, height); // restitution en plein ecran, centree
      nouvelleFrame = false;
      
      // Incrustation de l'image virtuelle si marqueur trouve
      if (sceneMM.isExist(0)) {
        // Le marqueur 0 est effectivement detecte dans le flux video
        V2_RA_en_Coordonnees_Marqueur();
      }
    }
  } else {
    // Elle est eteinte (ou absente...)
    background(#D16363);
    text("!! Camera eteinte !!", width/2, height/2);
  }
  // Ajout des boutons
  affichageBoutons();
}

void onCameraPreviewEvent() {
  cam.read(); // Lecture d'une image
  nouvelleFrame = true; // Gestion d'un booleen pour informer d'une nouvelle frame
}

void mousePressed() {
  // Analyse des boutons appuyes

  if (mouseY < 100) {
    // On ne regarde que dans le bandeau Haut

    if (mouseX < width/3) {
      // Premier tiers : Camera on/off
      if (cam.isStarted()) {
        cam.stop();
      } else {
        cam.start();
      }
    } else if (plusieursCamera && (mouseX > width/3) && (mouseX < 2*width/3)) {
      // Second tiers : changement de camera
      cam.setCameraID((cam.getCameraID() + 1 ) % nbCamera);
    } else if (mouseX > 2*width/3) {
      // Dernier tiers :  Flash Camera on/off
      if (cam.isFlashEnabled()) {
        cam.disableFlash();
      } else {
        cam.enableFlash();
      }
    }
  }
}

/*
void onLongPress(float x, float y) {
  id_obj = (id_obj + 1) % 3;
  objects[id_obj].scale(scales[id_obj]);
}
*/

void onPinch(float x, float y, float d) {
  // Zoom sur l'image, dans une limite raisonnable
  //Taille = constrain(Taille+d, TailleMini, TailleMaxi);
  scales[id_obj] = (constrain(scales[id_obj] + d*0.1, scales_min[id_obj], scales_max[id_obj]));
  objects[id_obj].scale(scales[id_obj]);
}

void affichageBoutons() { // Affichage de l'interface utilisateur
  pushStyle(); // Conservation du style d'ecriture
  textAlign(LEFT);
  fill(0);
  stroke(255);

  // Dessin des boutons
  rect(0, 0, width/3, 100);
  if (plusieursCamera) {
    rect(width/3, 0, width/3, 100);
  }
  rect((width/3)*2, 0, width/3, 100);

  // Affichage des textes sur les boutons
  fill(255);
  if (cam.isStarted()) {
    text("Camera Off", 5, 80);
  } else {
    text("Camera On", 5, 80);
  }

  if (plusieursCamera) {
    text("Switch Camera", width/3 + 5, 80);
  }

  if (cam.isFlashEnabled()) {
    text("Flash Off", width/3*2 + 5, 80);
  } else {
    text("Flash On", width/3*2 + 5, 80);
  }
  popStyle();
}

void V2_RA_en_Coordonnees_Marqueur() {
  // Changement de repere pour tracer en coordonnees "Marqueur"
  sceneMM.beginTransform(0); // Modification graphique sur marqueur 0
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
  // A noter que les objets sont souvent translates...
  // et orientes etrangement !
  
  sceneMM.endTransform();
}

/*
// Fonctions de gestion des evenements de la souris
void mouseDragged() { // Fonction invoquee tant que le bouton est maintenu appuye 
  // Ajout d'une rotation en X et en Y selon le deplacement de la souris
  if (sceneMM.isExist(0)) {
    objects[id_obj].rotateX((pmouseY-mouseY) /100.0);
    objects[id_obj].rotateY((mouseX-pmouseX) /100.0);
    objects[id_obj].rotateX((pmouseY-mouseY) /100.0);
    objects[id_obj].rotateY((mouseX-pmouseX) /100.0);
  }
}
*/
