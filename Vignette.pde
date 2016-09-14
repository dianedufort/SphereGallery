class Vignette {
 
 PImage image; //contiendra le dessin
 
 float pX, pY, pZ; //position (pour la translation)
 float rotationY, rotationX; 
   
  Vignette(float px, float py, float pz, float ry, float rx, PImage img){ 
    pX = px;  pY = py;  pZ = pz; 
    rotationY = ry; rotationX = rx; 
    image = img;
 }

 void dessin(){  
   pushMatrix();
     translate(pX, pY, pZ);  //on se déplace
     rotateY(rotationY); //rotation pour suivre le cerle
     rotateY(-PI/2); //rotation de -PI/2 pour prendre en compte le fait que l'image à l'angle 0 ne doit pas nous faire face mais être perpendiculaire à l'axe X
     
     //ajouté pour la sphère
     rotateX(rotationX);

     image(image, -image.width/2, -image.height/2);//on veille à ce que l'image soit au centre de 
     //notre forme afin que ce soit lui qui subisse les transformations
   popMatrix();
 }


}
