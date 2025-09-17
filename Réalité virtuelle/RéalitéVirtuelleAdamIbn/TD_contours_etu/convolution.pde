//************************************************************************
//***** Calcul de la combinaison linéaire avec les coefficient du masque *
//***** à la position x y dans l'image, sur la luminance uniquement ******
float apply_kernel_lum(int x, int y, float[][] kernel, PImage img)
{
  float lum = 0.0;
  int loc = 0;
  int kernel_size = kernel.length;
  int m = kernel_size / 2;
  // Parcours du masque
  for (int i = 0; i < kernel_size; i++){
    for (int j= 0; j < kernel_size; j++){
      // A COMPLETER !
      //Calcul de l'indice linéaire du pixel
      loc = (y+j-1)*img.width + x + i - 1;
      // Calcul de la multiplication avec le masque 
      lum += (brightness(img.pixels[loc]) * kernel[i][j]);
    }
  }
  // Renvoie la valeur résultante
  return lum;
}
//**********************************************************************
// Convolution d'une image par un masque (kernel)
void image_convolution(PImage img, float[][] kernel, PImage resultat)
{  
  float lum = 0.0;
  // Parcours de l'image
  for (int y = 0; y < img.height; y++) { 
    for (int x = 0; x < img.width; x++) { 
      // Parcours du masque
      lum = apply_kernel_lum(x,y, kernel, img);
      resultat.pixels[x + img.width*y]=color(lum);
    }
  }
  resultat.updatePixels(); 
}
