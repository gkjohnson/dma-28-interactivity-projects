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

  //counters


  //booleans
  boolean rightBul=true;
  boolean leftBul=false;
  boolean upBul=false;
  boolean drawn=false;
  boolean exploding=false;


  void render(){
    xVel=maxVel*cos(bulAngle);
    yVel=maxVel*sin(bulAngle);
    if(drawn==true&&exploding==false){
      xPos+=xVel;
      yPos+=yVel;
    }
    ellipse(xPos,yPos,Width,Width);

    drawn();
    explode();


  }

  void drawn(){
    if(xPos>abs(trans)+width||xPos<abs(trans)||yPos<0||yPos>height){
      drawn=false;
    }
  }



  int explodeCount=8;
  void explode(){
    if(exploding==true&&explodeCount>0){
      Width+=3;
      explodeCount--;
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











