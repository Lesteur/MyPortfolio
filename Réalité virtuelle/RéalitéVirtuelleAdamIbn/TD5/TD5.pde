/****************************************************************************/
/*  MESNARD Emmanuel                                              ISIMA     */
/*                                                                          */
/*            T D  4   d e   R e a l i t e   V i r t u e l l e              */
/*                                                                          */
/*        "WaterWall" - ajout d'ondulations sur une image issu du           */
/*                      flux video de la webcam en mode "Capture"           */
/*                      par clic et drag de la souris                       */
/*                                                                          */
/*        Base sur : "gesture_baseFile2a_motionPixels", Daniel Shiffman     */
/*                   "Water Simulation", Rodrigo Amaya                      */
/*                                                                          */
/* TD4_WaterWall_Capture_ETUDIANT.pde                    Processing 4.3     */
/****************************************************************************/

// Importation des librairies
import edu.ufl.digitalworlds.j4k.*; // Gestion de la Kinect

// Declaration des variables globales
PKinect kinect;   // Declaration de la Kinect
Skeleton[] s;     // Tableau des Squelettes des personnes detectees
int sMax;         // Limite de personnes pouvant etre detectees

byte[] colorMap;    // Carte des valeurs des couleurs = Flux "COLOR"
PImage  colorImage; // Image RGB reconstruite equivalente
int colorW = 600;     // Largeur de l'image RGB
int colorH = 480;     // Hauteur de l'image RGB

int xHand;
int yHand;

// Constante et Variables pour la creation des ondulations 
final int widthCapture = 600;
final int heightCapture = 480;

final int IncrementOndulation = 100; // Increment sur l'ondulation (100)
final int DiaOndulations = 3; // Diametre des ondulations autour du point d'impact (3)
int TableauOndulations[]; // Tableau des ondulations, avec taille double de l'image a traiter
PImage ImageATraiter; // Image d'entree sur laquelle il faut calculer les ondulations
PImage ImageOndulee;  // Image en sortie, modifiee avec ajout des ondulations

// Indices pour le traitement des ondulations
int OldIndex, NewIndex, MapIndex;


void setup() {
  size(600, 480); // Ouverture a la taille de la webcam : widthCapture x heightCapture
  surface.setTitle("TD 4 - WaterWall - E. Mesnard / ISIMA");
  
  xHand = 0;
  yHand = 0;

  // Initialisation Objet Kinect
  kinect = new PKinect(this);

  // Ouverture du flux "COLOR" 
  if (kinect.start(PKinect.COLOR | PKinect.SKELETON) == false) {
    println("Pas de kinect connectee !"); 
    exit();
    return;
  } else if (kinect.isInitialized()) {
    println("Kinect initialisee avec : ");
    colorW = kinect.getColorWidth();
    colorH = kinect.getColorHeight();
    println("  * Largeur image couleur : " + colorW);
    println("  * Hauteur image couleur : " + colorH);
    println("Kinect de type : "+kinect.getDeviceType());
    sMax = kinect.getSkeletonCountLimit();
    println("  * Limite de personnes trackées : " + sMax);
  } else { 
    println("Probleme d'initialisation de la kinect");
    exit();
    return;
  }
  
  // Creation des objets Color
  colorMap = new byte[colorW*colorH*4];
  colorImage = createImage(colorW, colorH, RGB);

  // Initialisation des variables pour generer les ondulations
  // avec traitements sur des images de taille : widthCapture x heightCapture
  TableauOndulations = new int[widthCapture * (heightCapture+2) * 2];
  ImageATraiter = createImage(widthCapture, heightCapture, RGB);
  ImageOndulee = createImage(widthCapture, heightCapture, RGB);

  OldIndex = widthCapture; 
  NewIndex = widthCapture * (heightCapture+3);
}


void draw() {
  int i, j; // Indices des boucles
  
  // Recuperation d'eventuelles donnees sur la kinect...
  colorMap = kinect.getColorFrame();
  s = kinect.getSkeletons();

  // Traitement du Flux "COLOR"
  // **************************
  if (colorMap!=null) { // Des donnees couleur sont disponibles

    // Conversion du tableau en une image en couleur
    colorImage.loadPixels();
    j = 0;
    for (i = 0; i < colorMap.length; i+=4) {  
      //int BB = (int) (colorMap[i]&0x0000FF);
      //int GG = (int) (colorMap[i+1]&0x0000FF);
      //int RR = (int) (colorMap[i+2]&0x0000FF);
      //colorImage.pixels[j] = color(RR, GG, BB); 
      colorImage.pixels[j] = (colorMap[i+2]&0x0000FF)<<16 |
        (colorMap[i+1]&0x0000FF)<<8  |
        (colorMap[i]&0x0000FF);
      j++;
    }
    colorImage.updatePixels();
  }

  // Sauvegarde de cette image pour mise a jour de l'image a traiter
  ImageATraiter.copy(colorImage, 0, 0, widthCapture, heightCapture, 0, 0, widthCapture, heightCapture);
  
  // Traitement du Flux "Skeletons"
  for (i=0; i<sMax; i++) {
    if (s[i]!=null) { // Des donnees sont disponibles
      if (s[i].isTracked()==true) { // Cet humain est actuellement visible
        traceSquelette(i); // Dessin effectif du squelette
      }
    }
  }
  
  // Generation des ondulations, a chaque cycle, meme si pas de nouvelle frame de webcam
  // pour faire correctement evoluer les ronds dans l'eau
  GenererOndulations(ImageATraiter);

  // Restitution de l'image resultante a l'ecran
  image(ImageOndulee, 0, 0);
}

void traceSquelette(int userId) {
  
  int[] jointPos; // Coordonnees des membres
  // Verification de la presence effective du membre
  if (s[userId].isJointTracked(Skeleton.HAND_RIGHT)==true) {

    // Recuperation des coordonnees 2D, proportionnelles a la taille de la fenetre
    jointPos = s[userId].get2DJoint(Skeleton.HAND_RIGHT, width, height);

    xHand = jointPos[0];
    yHand = jointPos[1];
    
    AjoutOndulation(xHand, yHand);
  }
  
}

// Fonction d'evolution des ondulations
void GenererOndulations(PImage ImageOrigine) {
  int i; // indice dans la boucle de generation des ondulations 
  int a, b; // Offset du traitement
  int Tmp; // variable temporaire

  // Changement de Map a chaque nouvelle frame : permutation des indices
  Tmp=OldIndex;
  OldIndex=NewIndex;
  NewIndex=Tmp;

  // Utilisation de l'image passee en parametre et de l'image a creer
  ImageOrigine.loadPixels();
  ImageOndulee.loadPixels();

  // Generation des ondulations sur toute l'image
  i=0;
  MapIndex=OldIndex;
  for (int y=0; y<heightCapture; y++) {
    for (int x=0; x<widthCapture; x++) {

      // Algorithme de calcul des ondulations
      short data = (short)((TableauOndulations[MapIndex-widthCapture]
        +TableauOndulations[MapIndex+widthCapture]
        +TableauOndulations[MapIndex-1]
        +TableauOndulations[MapIndex+1])>>1);
      data -= TableauOndulations[NewIndex+i];
      data -= data >> 5;
      TableauOndulations[NewIndex+i]=data;

      // Maintien si data=0; ondulationi si data>0
      data = (short)(1024-data);

      // Calcul des offsets
      a=((x)*data/1024);
      b=((y)*data/1024);

      // Gestion des cas limites, en bordure de l'image
      if (a>=widthCapture) a=widthCapture-1;
      else if (a<0) a=0;
      if (b>=heightCapture) b=heightCapture-1;
      else if (b<0) b=0;
      
      // Creation de l'image ondulee
      ImageOndulee.pixels[i]=ImageOrigine.pixels[a+(b*widthCapture)];
      
      // Traitement du pixel suivant
      MapIndex++;
      i++;
    }
  }
  // Rafraichissement du tableau avant de sortir
  ImageOndulee.updatePixels();
  ImageOrigine.updatePixels();
}


// Ajout d'Ondulation autour du point d'impact indique
public void AjoutOndulation(int XX, int YY) {
  for (int j=YY-DiaOndulations; j<YY+DiaOndulations; j++) {
    for (int k=XX-DiaOndulations; k<XX+DiaOndulations; k++) {
      if (j>=0 && j<heightCapture && k>=0 && k<widthCapture) {
        // Le point concerne est dans l'image, donc, il est modifiable
        TableauOndulations[OldIndex+(j*widthCapture)+k] += IncrementOndulation;
      }
    }
  }
}
