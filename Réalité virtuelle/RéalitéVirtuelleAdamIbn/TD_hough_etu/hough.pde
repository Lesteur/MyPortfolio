// calcul de l'accumulateur sur l'image im de contours binaires
int [][] compute_hough(PImage im){
  int rmax = (int) sqrt(im.width*im.width + im.height*im.height);
  float r = 0; int loc = 0;
  int [][] tab = new int[180][2*rmax + 1];
  for (int x = 0; x < im.width; x++) { //Parcours colonnes
    for (int y = 0; y < im.height; y++) { //Parcours lignes
      // Pixel location
      loc = x + y*im.width;
      if (im.pixels[loc] == color(255)) {
        for (int theta = -90; theta < 90; theta++) {
          r = x*cos(radians(theta)) + y*sin(radians(theta));
          tab[theta+90][round(r+rmax)] = tab[theta+90][round(r+rmax)] + 1;
        }
      }
      
    }
  }
  return tab;
}


// Calcul des lignes principales (accumulateur supérieur au seuil)
Vector<droite> compute_hough_lines(int [][] tab, int seuil_hough){
  Vector<droite> lines = new Vector<droite>();
  int rmax = tab[0].length;

  for (int i = 0; i < tab.length; i++) {
    for (int j = 0; j < tab[0].length; j++) {
      if (tab[i][j] > seuil_hough) {
        droite d = new droite();
        d.r = j - rmax/2 - 1;
        d.theta = i-90;
        d.acc = tab[i][j];
        lines.add(d);
      }
    }
  }

  return lines;
}

Vector<droite> compute_hough_lines2(int [][] tab, int seuil_hough){
  Vector<droite> lines = new Vector<droite>();
  int rmax = (int) sqrt(height*height + width*width);
  int count = 0;

  for (int i = 0; i < tab.length; i++) {
    for (int j = 0; j < tab[0].length; j++) {
      if (tab[i][j] > seuil_hough) {
        droite d = new droite();
        d.r = j - rmax/2 - 1;
        d.theta = i-90;
        d.acc = tab[i][j];
        lines.add(d);
        count ++;
      }
    }
  }
  print("nombre de lignes trouvées : " + str(count));
  return lines;
}
