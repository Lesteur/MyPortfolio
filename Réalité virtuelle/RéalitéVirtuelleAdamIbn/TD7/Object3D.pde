PShape initObject(String obj, float _scale) {
  // Chargement de l'objet utilise
  //objetOBJ = loadShape(obj); // Avec materiaux simples
  PShape objetOBJ = loadShape(obj); // Avec image de texture
  //objetOBJ = loadShape("moon.obj"); // Avec image de texture, bump, repere decale

  // Analyse de l'objet pour determiner la position du repere
  nombreVertex = objetOBJ.getVertexCount();
  nombreVertexTotal = nombreVertex;
  if (nombreVertex>0) {
    for (int i=0; i<nombreVertex; i++) {
      vX = objetOBJ.getVertexX(i);
      vY = objetOBJ.getVertexY(i);
      vZ = objetOBJ.getVertexZ(i);
      if (vX<minX) minX=vX; 
      else if (vX>maxX) maxX=vX; 
      if (vY<minY) minY=vY; 
      else if (vY>maxY) maxY=vY; 
      if (vZ<minZ) minZ=vZ; 
      else if (vZ>maxZ) maxZ=vZ;
    }
  } 

  nombreEnfant = objetOBJ.getChildCount();
  //println("Nombre d'enfants : "+nombreEnfant);
  if (nombreEnfant>0) {
    for (int i=0; i<nombreEnfant; i++) {
      // Analyse pour chaque enfant
      partieObj = objetOBJ.getChild(i);
      nombreVertex = partieObj.getVertexCount();
      nombreVertexTotal +=nombreVertex;
      if (nombreVertex>0) {
        for (int j=0; j<nombreVertex; j++) {
          vX = partieObj.getVertexX(j);
          vY = partieObj.getVertexY(j);
          vZ = partieObj.getVertexZ(j);
          if (vX<minX) minX=vX; 
          else if (vX>maxX) maxX=vX; 
          if (vY<minY) minY=vY; 
          else if (vY>maxY) maxY=vY; 
          if (vZ<minZ) minZ=vZ; 
          else if (vZ>maxZ) maxZ=vZ;
        }
      }
    }
  }
  
  println("Nombre total de vertex dans l'objet : " + nombreVertexTotal);
  println("Coordonnees min : " + minX + "  " + minY + "  " + minZ);
  println("Coordonnees MAX : " + maxX + "  " + maxY + "  " + maxZ);
  
  // Determination de la taille effective de l'objet
  dimOBJ_X = maxX-minX;  // dimOBJ_X = objetOBJ.getWidth();
  dimOBJ_Y = maxY-minY;  // dimOBJ_Y = objetOBJ.getHeight();
  dimOBJ_Z = maxZ-minZ;  // dimOBJ_Z = objetOBJ.getDepth();
  println("Taille Objet : " + dimOBJ_X + ", " + dimOBJ_Y + ", " + dimOBJ_Z);

  decX = -minX - dimOBJ_X/2.0f;
  decY = -minY - dimOBJ_Y/2.0f;
  decZ = -minZ - dimOBJ_Z/2.0f;
  println("Translations a appliquer pour centrer l'objet : " + decX + "  " + decY + "  " + decZ);


  // Calcul du facteur d'echelle pour affichage "correct" a l'ecran
  facteurEchelle = _scale;
  //facteurEchelle = min(width/(1.6*dimOBJ_X), height/(1.6*dimOBJ_Y), width/(1.6*dimOBJ_Z));
  objetOBJ.scale(facteurEchelle);

  println("Facteur d'Echelle pour rendu 640x480 : " + facteurEchelle);

  // Mise a jour des dimensions de l'objet et des decalages associes
  dimOBJ_X *= facteurEchelle;
  dimOBJ_Y *= facteurEchelle;
  dimOBJ_Z *= facteurEchelle;

  decX*= facteurEchelle;
  decY*= facteurEchelle;
  decZ*= facteurEchelle;
  println("Nouvelle taille Objet : " + dimOBJ_X + ", " + dimOBJ_Y + ", " + dimOBJ_Z);

  // Application des translations ainsi calculees pour recentrage
  // A noter, si l'origine de l'objet est en bas a droite au fond, alors
  // equivalent a : objetOBJ.translate(dimOBJ_X/2, -dimOBJ_Y/2, -dimOBJ_Z/2);
  objetOBJ.translate(decX, decY, decZ);

  // Creation d'une boite englobante
  noFill();
  stroke(200);
  boundingBoxOBJ = createShape(BOX, dimOBJ_X, dimOBJ_Y, dimOBJ_Z);

  // Trace de cette boite par defaut
  traceBB_OBJ = true;
  
  return objetOBJ;
}
