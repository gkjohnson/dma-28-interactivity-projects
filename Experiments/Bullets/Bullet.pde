class Bullet {
  float xpos = 90;
  float ypos = 90; 
  float angle=0;
  float xchange=0;
  float ychange=0;
  
  boolean isShooting = false;
  
  void render() {
    ellipse(xpos, ypos, 10, 10);
    if (isShooting) {
       move(); 
    }
  }
  
  void move() {
       xchange=cos(angle);
      ychange=sin(angle);
     xpos += xchange; 
     ypos += ychange;
     println(xpos);
     
     if (xpos > width) {

     }
  }
}

