Bullet [] bullets;
int currentBulletNum = 0;

void setup(){
  size(400,400);
  bullets = new Bullet[100];
}
float angle=0;

void draw(){
  background (205);
  gun(mouseX-width/2,mouseY-height/2);

  for (int i=0; i<bullets.length; i++) {
    Bullet b = bullets[i];
    if (b != null) {

      
      b.render();
    }  
  }


}

void gun(float x, float y){


  float linelength = 20;

  angle = atan((y/x));
  float linex=linelength * cos(angle);
  float liney=linelength * sin(angle);

  println(angle);  

  line(width/2,height/2, width/2 + linex, height/2 + liney);
}

void mousePressed() {
  Bullet b = new Bullet();
  b.xpos = width/2;
  b.ypos = height/2;
  b.isShooting = true;
  b.angle=angle;
  bullets[currentBulletNum] = b;
  currentBulletNum += 1;
}



