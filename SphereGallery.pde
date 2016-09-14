static final int LARGEUR = 900;
static final int HAUTEUR = 500;

final int LIGNES = 9;
final int[] COLONNES = {1, 7, 9, 12, 15, 12, 9, 7, 1}; 
final float[] ANGLESLIGNES = {PI/2, 3*PI/8 , 2*PI/8, PI/8, 0, -PI/8 , -2*PI/8, -3*PI/8, -PI/2} ;

PImage[] tabImages = new PImage[10];
final int MAXVIGNETTES = 73;
Vignette[] tabVignettes = new Vignette[MAXVIGNETTES];
int nbVignettes = 0;

float rayonSphere = 250;

//caméra
float eyeX, eyeY, eyeZ;
float angleCamera ;
float rayonCamera;

int angleGlob = 0;

void setup() {//fonction d'initialisation de la scène
  size(LARGEUR, HAUTEUR, P3D); 
 
  
  for(int i=0; i < tabImages.length; i++ ) {
     tabImages[i] = loadImage("data/" + (i+1) + ".png"); 
  }
  
  
  rayonCamera = rayonSphere *2.5 ; angleCamera = -PI/2; 
  
  eyeY= 0;
  eyeX = rayonCamera *cos(angleCamera);
  eyeZ = rayonCamera *sin(angleCamera);
  
  frameRate(24); //frameRate diminué de moitié

  //DANS LE CAS D'UNE ELLIPSE/D'UN CERCLE DE VIGNETTES
  /* int j = 3;
  for(int i= 0; i < COLONNES[j]; i++){
      float angY = i*2*PI/COLONNES[j];//i * (angle entre deux images) = i * 2PI/nbImagesLignes
      float angZ = 0;  float angX = 0;  //pour le moment, pas de rotation sur z ni sur x puisque les images tournent autour de y (une seule ligne)
     
      //on se place au dessus de la scène, nous aurons donc l'axe x horizontal (direction vers la droite) et l'axe z, vertical (direction vers le haut)
      float posX = rayonSphere * cos(angY);//on lit le graphique
      float posY = 0; //logique
      float posZ = - rayonSphere * sin(angY); // on le met en négatif pour prendre en compte la différence de sens de rotation
      tabFleurs[nbFleurs++] = new Vignette(posX , posY , posZ, angX, angY, angZ,img); 
  }*/
  
  //dans le cas d'une sphère
  for(int j= 0; j < COLONNES.length ; j++) {
    
    float angX = ANGLESLIGNES[j];  
    for(int i= 0; i < COLONNES[j]; i++){
        float angY = i*2*PI/COLONNES[j];//i * (angle entre deux images) = i * 2PI/nbImagesLignes
        
        int rand = int(random(1,10));
        PImage img =  tabImages[rand];
        

        //on se place au dessus de la scène, nous aurons donc l'axe x horizontal (direction vers la droite) et l'axe z, vertical (direction vers le haut)
        float posX = rayonSphere * cos(angY) * cos(angX); //on multiplie par cos(angZ) pour avoir la position en x des lignes avec moins de vignettes donc avec un rayon moins important
        float posY =  rayonSphere * sin(angX); //il est pris dans ANGLESLIGNES donc il est déjà bon et l'axe y pointe vers le bas
        float posZ = - rayonSphere * sin(angY) * cos(angX); // on le met en négatif
      //  println("Colonne = " + i + " posZ = " + posZ);
        tabVignettes[nbVignettes++] = new Vignette(posX , posY , posZ, angY, angX,img); 
    }  
  }

}
void draw() {
  
  
  background(0);
  camera(eyeX, eyeY,eyeZ, 0, 0, 0, 0, 1, 0);
  rotateY(radians(++angleGlob));
  for(int i=0; i<nbVignettes; i++) {//dessin des fleurs dans un tableau
    tabVignettes[i].dessin();  
  }

}
void keyPressed() {
   if (key ==  's') {
     save("data/capture_" + int(random(999999)) + ".jpg");
     println("Capture d'écran effectuée");
   }

}
