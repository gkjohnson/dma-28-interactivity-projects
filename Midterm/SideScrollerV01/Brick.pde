class Brick{
  float xPos=0;
  float yPos=height;

  float squareYPos=square.yPos+square.yVel;
  float squareXPos=square.xPos+square.xVel;
  float Width=20;

  float rightside=xPos+Width/2+square.Width/2;
  float leftside=xPos-Width/2-square.Width/2;


  //y hits
  float hitTop=yPos-Width/2-square.Height/2;
  float hitBottom=yPos+Width/2+square.Height/2;
  //x hits

  //boolean
  boolean hit=false;
  boolean drawn=false;

  //functions
  void render(){

beingDrawn();
  if(drawn==true){
    //y hits update
    hitTop=yPos-Width/2-square.Height/2;
    hitBottom=yPos+Width/2+square.Height/2;
    // x hits update
    rightside=xPos+Width/2+square.Width/2;
    leftside=xPos-Width/2-square.Width/2;


    rectMode(CENTER);
    rect(xPos,yPos,Width,Width);
    hit();
  }
  
  }



  void hit(){

    if(square.xPos>xPos-Width/2-square.Width/2&&square.xPos<xPos+Width/2+square.Width/2&&square.yPos>=hitTop&&square.yPos<hitBottom){
      //Square Hit
      if (squareYPos+square.yVel<hitBottom&&abs(square.yVel)/square.yVel==-1){
        hit=true;
        square.yVel=0;
        square.yPos=hitBottom;

        
      } 
      else if (squareYPos+square.yVel>=hitTop){
        square.onGround=true;


        jump=false;
        hit=true;
        square.yPos=hitTop;
      }     
    }

    if(square.yPos>hitTop&&square.yPos<hitBottom){
      if(square.xPos+square.xVel<rightside&&square.xPos+square.xVel>leftside){
        
         if(square.xVel/abs(square.xVel)==1){
          square.xPos=leftside;
          square.xVel=0;  
          println("HIT LEFT"+HIT);
          HIT++;}
        //}else if(square.xVel/abs(square.xVel)==-1){
          else if(square.xVel < 0.0){
          square.xPos=rightside;
          square.xVel=0;  
          println("HIT RIGHT"+HIT);
          HIT++;
        } 
      }
    }

    //Bullet Hit
    for (int i = 0; i<maxBullets; i++){
      if(bullets[i].xPos<xPos+Width/2+5 && bullets[i].xPos>xPos-Width/2-5 && bullets[i].yPos<yPos+Width/2 && bullets[i].yPos>yPos-Width/2){
        bullets[i].exploding=true; 
      }



    }

  }

  void beingDrawn(){
    if (xPos>abs(trans)-Width&&xPos<abs(trans)+width+Width){
      drawn=true; 
    }
  }
}







