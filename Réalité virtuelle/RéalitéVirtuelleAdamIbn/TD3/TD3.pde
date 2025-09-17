/****************************************************************************/
/*  MESNARD Emmanuel                                                ISIMA   */
/*                                                                          */
/*          Exemple 7 : Recherche d'un POI - Version webcam Capture         */
/*                      Mise en evidence du point le plus vert sur l'image  */
/*                      Analyse naive basee sur un unique point             */
/*                                                                          */
/* Exemple_7_POI_Point_Vert_Capture.pde                    Processing 4.2   */
/****************************************************************************/

// Importation des librairies
import processing.video.*; // Bibliotheque de controle camera

// Parametres de taille de la capture video
final int widthCapture=640;  // largeur capture
final int heightCapture=480; // hauteur capture
final int numPixels=widthCapture*heightCapture; // nombre de pixels d'une image video
final int fpsCapture=30;     // taux d’images/secondes

final int Teinte_Blanche = 255*3; // En HSB, le vert vaut 120°

float Xg, Yg; // Positions "regard" de l'oeil gauche
float Xd, Yd; // Oeil droit
boolean lock;

// Variables images
PImage image1;
PImage image2;
PImage diffimage; // Image difference  = image1 - image2
int nbPixels;         // Nombre de pixels dans l'image (1)

// Variables pour comparaison des pixels des images
color pixelImg1=0;
color pixelImg2=0;

// Difference des couleurs des deux pixels
int diffPixel=0;  // total
int diffPixelR=0; // par composante
int diffPixelG=0;
int diffPixelB=0; 

int i; // index pour les boucles

// Declaration des variables globales
String[] cameras;    // Liste des cameras dispos
Capture webCam;      // Declaration de la Capture par Camera

// Fonction d'initialisation de l'application - executee une seule fois
void setup() {
  
  // Initialisation des parametres graphiques utilises
  size(640,480); // Ouverture en mode normal 640 * 480
  surface.setTitle("TD3");
  
  nbPixels = widthCapture * heightCapture;
  image1 = createImage(widthCapture, heightCapture, RGB);
  image2 = createImage(widthCapture, heightCapture, RGB);
  diffimage = createImage(widthCapture, heightCapture, RGB);

  noFill(); // pas de remplissage
  stroke(#FF0000); // couleur Rouge pourtour
  
  colorMode(RGB, 100, 100, 100); // Passage en mode HSB pour Couleur avec teinte
  // Pour faciliter la recherche d'une teinte particuliere
  
  // Recherche d'une webcam 
  cameras = Capture.list();
  if (0 == cameras.length) {
    println("Pas de Webcam sur cet ordinateur !");
    exit();
  } else {
    // Initialisation de la webcam Video : la derniere de la liste
    webCam = new Capture(this, widthCapture, heightCapture, cameras[cameras.length-1], fpsCapture);
    webCam.start(); // Mise en marche de la webCam
  }
} // Fin de Setup


// Fonction de re-tracage de la fenetre - executee en boucle
void draw() {
  int i; // Index du vecteur image...
  int xx, yy; // ... equivalent aux coordonnees matriciels xx et yy
  int yPos; // Decalage offset de la composante y
  
  color currColor; // Couleur du pixel courant...
  float teinte; // Teinte (hue) dans cette couleur
  
  int xPOI, yPOI; // Coordonnees du Point d'interet  : Point Of Interest
  float poids, poidsPOI; // Ecart entre les differences teinte (et le vert pur)
  xPOI = 0; yPOI = 0;   // Par defaut, le POI est en (0,0)
  
  if (webCam.available() == true) { // Verification de presence d'une nouvelle frame
    webCam.read(); // Lecture du flux sur la camera... lecture d'une frame
    webCam.loadPixels();
    
    // Recherche du point le plus proche de la couleur de reference
    poidsPOI = 255*3; // Valeur la plus grande possible
    xPOI = 0; yPOI = 0;   // Par defaut, le POI est en (0,0)
    
    // Analyse de l'image
    image1.loadPixels();
    arrayCopy(image1.pixels, image2.pixels);
    arrayCopy(webCam.pixels, image1.pixels);
    //arrayCopy(webCam.pixels, image2.pixels);
    image1.updatePixels();
    image2.updatePixels();
    
    comparer();
    
    // Analyse de l'image
    diffimage.loadPixels();
    for (yy = 0; yy < heightCapture; yy++) { // abscisse yy
      yPos = yy * widthCapture; 
      for (xx = 0; xx < widthCapture; xx++) { // ordonnees xx
      i = xx + yPos;
        currColor = diffimage.pixels[i]; // recuperation couleur
        teinte = blue(currColor) * 3; // et de la teinte
        // Calcul de l'ecart de teinte par rapport au vert pur
        poids = abs(Teinte_Blanche-teinte);
        if (poids < poidsPOI) {  // Le POI est le point qui a le moins de difference...
          poidsPOI = poids; // Mise a jour des informations et coordonnees
          xPOI = xx;
          yPOI = yy;
        }
      }
    }
    
    //image(diffimage, 0, 0); // Restitution de l'image captee sur la webCam
    //ellipse(xPOI,yPOI,20,20); // Trace d'un cercle rouge autour du POI
  }
  
  /*
  if (!lock) {
    // Deplacements en proportion des mouvements au sein de la fenetre
    Xg = map(xPOI, 0, widthCapture, 220 - 30, 220 + 30);
    Yg = map(yPOI, 0, heightCapture, 250 - 40, 250 + 40);
    
    Xd = map(xPOI, 0, widthCapture, 400 - 30, 400 + 30);
    Yd = map(yPOI, 0, heightCapture, 250 - 60, 250 + 60);
  }
  */
  
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

void comparer() {
  //fastblur(image2, 30);
  
  image1.loadPixels();
  image2.loadPixels();
  diffimage.loadPixels();
  
  for (i = 0; i < nbPixels; i++) { // traitement sur tous les pixels
    pixelImg1 = image1.pixels[i];
    pixelImg2 = image2.pixels[i];

    // Calcul des differences sur les 3 composantes couleur : R, G et B
    diffPixelR = abs(((pixelImg1 >> 16) & 0xFF) - ((pixelImg2 >> 16) & 0xFF));
    // A noter : equivalent a :  abs( red(pixelImg1) - red(pixelImg2) )
    diffPixelG = abs(((pixelImg1 >> 8) & 0xFF) - ((pixelImg2 >> 8) & 0xFF));
    diffPixelB = abs((pixelImg1 & 0xFF) - (pixelImg2 & 0xFF));

    diffPixel = diffPixelR + diffPixelG + diffPixelB;

    // Mise en evidence des differences
    diffimage.pixels[i] = color(diffPixel, diffPixel, diffPixel); // en niveaux de gris
    //diffimage.pixels[i] = color(diffPixelR, diffPixelG, diffPixelB); // en couleur
    
    /*
    if (diffPixel > 120) {
      diffimage.pixels[i] = color(255, 255, 255);
    } else {
      diffimage.pixels[i] = color(0, 0, 0);
    }
    */
    
  }
  
  image1.updatePixels();
  image2.updatePixels();
  diffimage.updatePixels();
}

// Fonction appelee lors de la fermeture de la fenetre windows
// par un clic sur la croix de fermeture de la fenetre...
void exit() {
  println("ATTENTION : Le programme s'arrete, donc cloture WebCam !!");
  webCam.stop(); // Arret "propre" de la webcam
  super.exit();
}
