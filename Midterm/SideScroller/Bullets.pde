class Bullet{
  //Parameters
  float maxVel=15;
  float origWidth=4;
  float Width=origWidth;
  //Variables
  float xPos=0;
  float yPos=0;
  float bulAngle=0;
  float xVel=maxVel*cos(bulAngle);
  float yVel=maxVel*sin(bulAngle);
  float damage=1;

  //counters


  //booleans
  boolean rightBul=true;
  boolean leftBul=false;
  boolean upBul=false;
  boolean drawn=false;
  boolean exploding=false;
  boolean damaging=false;


  void render(){
    xVel=maxVel*cos(bulAngle);
    yVel=maxVel*sin(bulAngle);
    if(drawn==true&&exploding==false){
      xPos+=xVel;
      yPos+=yVel;
    }
    stroke(0);
    fill(205);
    ellipse(xPos,yPos,Width,Width);

    fill(255,50);
    noStroke();

    ellipse(xPos,yPos,Width+3,Width+3);

    drawn();
    explode();



  }

  void drawn(){
    if(xPos>abs(trans)+width||xPos<abs(trans)||yPos<0||yPos>height){
      drawn=false;
    }
    damaging=true;
  }



  int explodeCount=8;
  void explode(){
    if(exploding==true&&explodeCount>0){
      Width+=3;
      explodeCount--;
      damaging=false;
    } 
    else if (explodeCount<=0){
      xPos=-10;
      yPos=-10;
      drawn=false;
      exploding=false;
      explodeCount=5;
      Width=origWidth; 
    }


  }
}












class EnemyBullet{
  //Parameters
  float maxVel=5;
  float origWidth=8;
  float Width=origWidth;
  float damage=1;
  //Variables
  float xPos=0;
  float yPos=0;
  float bulAngle=0;
  float xVel=maxVel*cos(bulAngle);
  float yVel=maxVel*sin(bulAngle);
  //booleans
  boolean drawn=false;

  void render(){
    xVel=maxVel*cos(bulAngle);
    yVel=maxVel*sin(bulAngle);

    xPos+=xVel;
    yPos+=yVel;
    fill(255,150,150);
    stroke(2);
    stroke(255,0,0);
    ellipse(xPos,yPos,Width,Width);
    fill(255);
    drawn();
    squareHit();



  }

  void drawn(){
    if(xPos>abs(trans)+width+10||xPos<abs(trans)-10||yPos<-10||yPos>height+10){
      drawn=false;
    }

  }

  void squareHit(){
    if(xPos+Width/2>square.xPos-square.Width/2 && xPos-Width<square.xPos+square.Width/2 && yPos+Width>square.yPos-square.Width/2 && yPos-Width<square.yPos+Width/2&&drawn==true&&square.invinc==false){
      square.health-=square.bulletDamage;
      drawn=false;
      if(mechboss.bossOn==true){
        square.xVel=1*(xVel/abs(xVel));
      }
      square.hitCountBlink=square.maxHitCountBlink;
      square.invincCount=square.maxHitCountBlink;

    }

  }

}


