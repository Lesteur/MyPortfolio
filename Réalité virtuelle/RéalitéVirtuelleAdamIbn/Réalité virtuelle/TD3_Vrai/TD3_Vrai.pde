/****************************************************************************/
/*  MESNARD Emmanuel                                                ISIMA   */
/*                                                                          */
/*      Calcul de la difference entre deux images fixes, prechargees        */
/*                                                                          */
/* Exemple_8_JeuDifferences.pde                            Processing 4.2   */
/****************************************************************************/

// Variables images
PImage image1;
PImage image2;
PImage differenceImg; // Image difference  = image1 - image2
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
int totalMolette;

int xmoy;
int ymoy;

void binarisation(int seuil) {
  
  if (seuil > 255) {
    seuil = 255;
  } else if (seuil < 0) {
    seuil = 0;
  }
  
  int moy = 0;

  //println("Taille image 1 = " + image1.width + " x "+image1.height);
  //println("Taille image 2 = " + image2.width + " x "+image2.height);
  nbPixels = image1.width * image1.height;

  // Meme taille que l'image 1
  differenceImg = createImage(image1.width, image1.height, RGB);

  image1.loadPixels();
  image2.loadPixels();
  differenceImg.loadPixels();
  
  xmoy = 0;
  ymoy = 0;

  for (i = 0; i < nbPixels; i++) { // traitement sur tous les pixels
    pixelImg1 = image1.pixels[i];
    pixelImg2 = image2.pixels[i];

    // Calcul des differences sur les 3 composantes couleur : R, G et B
    diffPixelR = abs(((pixelImg1 >> 16) & 0xFF) - ((pixelImg2 >> 16) & 0xFF));
    // A noter : equivalent a :  abs( red(pixelImg1) - red(pixelImg2) )
    diffPixelG = abs(((pixelImg1 >> 8) & 0xFF) - ((pixelImg2 >> 8) & 0xFF));
    diffPixelB = abs((pixelImg1 & 0xFF) - (pixelImg2 & 0xFF));

    diffPixel = diffPixelR + diffPixelG + diffPixelB;
    
    int cordx = i % nbPixels;
    int cordy = floor(i / nbPixels);
    
    if (diffPixel >= seuil)
    {
      differenceImg.pixels[i] = color(255, 255, 255);
      //xmoy += differenceImg.pixels[i].x;
    } else {
      differenceImg.pixels[i] = color(0, 0, 0);
    }

    // Mise en evidence des differences
    //differenceImg.pixels[i] = color(diffPixel, diffPixel, diffPixel); // en niveaux de gris
    //differenceImg.pixels[i] = color(diffPixelR, diffPixelG, diffPixelB); // en couleur
  }
  image1.updatePixels();
  image2.updatePixels();
  differenceImg.updatePixels();

  // Restitution de l'image des differences
  image(differenceImg, 0, 0);
}

// Fonction d'initialisation de l'application - executee une seule fois
void setup() {
  size(298, 412);
  totalMolette = 100;
  image1 = loadImage("Image1_Joconde.jpg");
  image2 = loadImage("Image2_Joconde.jpg");
  
  binarisation(100);
}

// Fonction de re-tracage de la fenetre - executee en boucle
void draw() {
  binarisation(totalMolette);
}

void mouseWheel(MouseEvent event) {
  totalMolette += event.getCount(); // Prise en compte de l'evenement
  println(totalMolette); // Affichage retour console pour debug
}
