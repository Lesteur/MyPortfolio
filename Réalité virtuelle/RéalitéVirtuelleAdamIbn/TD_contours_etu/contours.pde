//**********************************************************************
// Calcul du gradient de Sobel
// img : PImage image à traiter
// gradient : PImage image du résultat du gradient
//**********************************************************************
void compute_gradient_sobel(PImage img, PImage gradient) {
  float[][] filtreSobelH = { { -1, 0, 1 }, 
    { -2, 0, 2 }, 
    { -1, 0, 1 } }; 
  float[][] filtreSobelV = { { 1, 2, 1 }, 
    { 0, 0, 0 }, 
    { -1, -2, -1 } }; 
  float grad = 0;
  float gradH = 0;
  float gradV = 0;
  int loc = 0;

  //Parcours des pixels de l'image
  for (int x = 1; x < img.width-1; x++) {
    for (int y = 1; y < img.height-1; y++ ) {
      gradV = 0; gradH = 0;      
      //Calcul du résultat de la convolution par les 2 masques :
      gradH = apply_kernel_lum(x, y, filtreSobelH, img);
      gradV = apply_kernel_lum(x, y, filtreSobelV, img);
      //Calcul de la norme du gradient :
      grad = sqrt(gradH*gradH+gradV*gradV); 
      
      //Stockage dans une PImage (valeur entre 0 et 255)
      loc = x + y*img.width;
      gradient.pixels[loc] = color(grad);
    }
  }
  gradient.updatePixels();
}
//**********************************************************************
// Calcul du gradient + nms
// img : PImage image à traiter
// gradient : PImage image du résultat du gradient
// gradnms : PImage image du résultat de la suppression de nom maxima
//**********************************************************************
void compute_gradient_nms(PImage img, PImage gradient, PImage gradnms) {
  int w = img.width;
  int h = img.height;
  float sumX = 0;
  float sumY = 0;
  
  // Convertir l'image en tableau de pixels
  img.loadPixels();
  
  // Créer une nouvelle image pour stocker le gradient
  //PImage gradient = createImage(w, h, RGB);
  
  // Calculer le gradient avec le filtre de Sobel
  float[][] sobelX = {{-1, 0, 1}, {-2, 0, 2}, {-1, 0, 1}};
  float[][] sobelY = {{-1, -2, -1}, {0, 0, 0}, {1, 2, 1}};
  
  for (int y = 1; y < h - 1; y++) {
    for (int x = 1; x < w - 1; x++) {
      sumX = 0;
      sumY = 0;
      
      // Appliquer le filtre de Sobel
      for (int i = -1; i <= 1; i++) {
        for (int j = -1; j <= 1; j++) {
          int index = (x + j) + (y + i) * w;
          float c = brightness(img.pixels[index]);
          sumX += sobelX[i + 1][j + 1] * c;
          sumY += sobelY[i + 1][j + 1] * c;
        }
      }
      
      // Calculer le module du gradient
      float magnitude = sqrt(sumX * sumX + sumY * sumY);
      gradient.pixels[x + y * w] = color(magnitude);
    }
  }
  
  // Appliquer l'algorithme NMS
  gradnms.loadPixels();
  gradient.loadPixels();
  
  for (int y = 1; y < h - 1; y++) {
    for (int x = 1; x < w - 1; x++) {
      int index = x + y * w;
      
      // Obtenir les valeurs des gradients
      float mag = brightness(gradient.pixels[index]);
      float angle = atan2(sumY, sumX);
      
      // Limites des indices voisins
      int index1 = index - 1;
      int index2 = index + 1;
      
      // Comparer le gradient actuel avec les gradients des pixels voisins
      float grad1 = brightness(gradient.pixels[index1]);
      float grad2 = brightness(gradient.pixels[index2]);
      
      // Suppression des non-maximaux
      if ((angle < -PI/8 && angle >= -3*PI/8) || (angle >= PI/8 && angle < 3*PI/8)) {
        if (mag < grad1 || mag < grad2) {
          gradnms.pixels[index] = color(0);
        } else {
          gradnms.pixels[index] = gradient.pixels[index];
        }
      } else {
        if (mag < grad1 || mag < grad2) {
          gradnms.pixels[index] = color(0);
        } else {
          gradnms.pixels[index] = gradient.pixels[index];
        }
      }
    }
  }
  
  // Mettre à jour les pixels de l'image gradnms
  gradnms.updatePixels();
  gradient.updatePixels();
}


//**********************************************************************
// Seuillage simple
// img : PImage image à traiter
// imgSeuilleeimgSeuillee : PImage image du résultat du seuillage
// seuil : seuil utilisé pour le seuillage simple
//**********************************************************************
void seuillage(PImage img, PImage imgSeuillee, int seuil) {
  img.filter(GRAY);
  int loc = 0;
  //Parcours des pixels de l'image
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++ ) {
      // Pixel courant
      loc = x + y*img.width;
      
      float moy = brightness(img.pixels[loc]);
      
      /*
      int pR = (img.pixels[loc] >> 16) & 0xFF;
      int pG = ((img.pixels[loc] >> 8) & 0xFF);
      int pV = (img.pixels[loc] & 0xFF);
      int moy = (pR + pG + pV)/3;
      */
      
      if (moy >= seuil) {
        imgSeuillee.pixels[loc] = color(255, 255, 255);
      } else {
        imgSeuillee.pixels[loc] = color(0, 0, 0);
      }
      
    }
  }
  imgSeuillee.updatePixels();
}


//**********************************************************************
// Calcul des contours
// img : PImage image à traiter
// gradient : PImage image du résultat du gradient
// gradnms : PImage image du résultat de la suppression de nom maxima
// contours : PImage image du résultat de l'extraction de contours après seuillage
//**********************************************************************
void compute_contours(PImage img, PImage gradient, PImage gradnms, PImage contours) {

  // A COMPLETER !

  
}
