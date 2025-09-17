// Importation des librairies
import processing.video.*; // Bibliotheque de controle camera


// Parametres de taille de la capture video
final int widthCapture=640;  // largeur capture
final int heightCapture=480; // hauteur capture
final int numPixels=widthCapture*heightCapture; // nombre de pixels d'une image video
final int fpsCapture=30;     // taux d'images/secondes

// Quelques couleurs...
final int noir  = color(0,0,0); 
final int blanc = color(255,255,255);

// Declaration des variables globales
String[] cameras;    // Liste des cameras dispos
Capture webCam;      // Declaration de la Capture par Camera

PImage gradient;  // image de la norme du gradient
PImage imgSeuillee; // image seuillée
PImage gradnms;

//**********************************************************************
// Fonction d'initialisation de l'application - executee une seule fois
void setup() {
  // Initialisation des parametres graphiques utilises
  size(640,480); // Ouverture en mode normal 640 * 480
  surface.setTitle("Exemple extraction de contours");
  colorMode(RGB, 255,255,255); 
  noFill(); // pas de remplissage
  background(noir); // couleur fond fenetre
  
  // Recherche d'une webcam 
  cameras = Capture.list();
  if (cameras.length == 0) {
    println("Pas de Webcam sur cet ordinateur !");
    exit();
  } else {
    // Initialisation de la webcam Video par defaut
    webCam = new Capture(this, widthCapture, heightCapture, cameras[0], fpsCapture);
    webCam.start(); // Mise en marche de la webCam
  }
  
  // Initialisation des images
  gradient = createImage(webCam.width, webCam.height, RGB);
  gradnms = createImage(webCam.width, webCam.height, RGB);
  imgSeuillee = createImage(webCam.width, webCam.height, RGB);

  
} // Fin de Setup



//************************************************************************
// Fonction de re-tracage de la fenetre - executee en boucle
void draw() {
  if (webCam.available() == true) { // Verification de presence d'une nouvelle frame
    webCam.read(); // Lecture du flux sur la camera... lecture d'une frame
    image(webCam, 0, 0); // Restitution de l'image captee sur la webCam   
    
    if (mousePressed && (mouseButton == LEFT)){// Test clic gauche de la souris...
      // Calcul des gradients
      
      //compute_gradient_sobel(webCam, gradient);
      compute_gradient_nms(webCam, gradient, gradnms);
      seuillage(gradnms, imgSeuillee, 200);
      
      // Affichage de l'image des contours
      image(imgSeuillee, 0, 0);
      //image(gradient,0,0);
    }
    else{
     // Affichage de l'image de la Webcam
      image(webCam,0,0);
      //seuillage(webCam, imageSeuil, 50);
    }
  } 
}

// Fonction appelee lors de la fermeture de la fenetre windows
// par un clic sur la croix de fermeture de la fenetre...
void exit() {
  println("ATTENTION : Le programme s'arrete, donc cloture WebCam !!");
  webCam.stop(); // Arret "propre" de la webcam
  super.exit();
}
