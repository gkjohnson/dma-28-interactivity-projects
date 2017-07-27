class DiveBomber{

  float xPos=0;
  float yPos=0;


  float glideVel=10;
  float diveVel=15;

  boolean drawn=false;
  boolean toSpawn=false;
  boolean diving=false;
  boolean destroyed=false;
  boolean withinRange=false;

  float randNum=0;
  int randSide=0;
  float angle=0;

  int timer=10;
  int offscreentimer=30;

  void render(){
    //  println(offscreentimer);
    if(withinRange==true){
      toSpawn=true; 
    }
    else if (withinRange==false){
      reset(); 
    }
    if(timer>0){
      timer--; 

    }

    if(toSpawn==true&&drawn==false&&timer==0&&withinRange==true){
      yPos=random(10,150);

      randNum=random(-10,10);

      if(randNum==0){
        randSide=1;
      }
      else if (abs(randNum)>0){
        randSide=ceil((randNum)/abs(randNum));
      }

      if(randSide==1){
        xPos=abs(trans)+width+10;

        glideVel=abs(glideVel)*-1;
      }
      else if (randSide==-1){
        xPos=abs(trans)-10; 

        glideVel=abs(glideVel);
      }


      toSpawn=false;
      drawn=true;
    }
    else if (drawn==true&&diving==false){
      xPos+=glideVel;
      ellipse(xPos,yPos,15,10);

    }
    else if (drawn==true&&diving==true){
      xPos+=diveVel*cos(angle)*randSide*-1;
      yPos+=diveVel*sin(angle);
      ellipse(xPos,yPos,10,10);
    }


    dive();
    resetTimer();
    hitSquare();
    explodes();
  }


  void dive(){
    if(abs(xPos-square.xPos)<150&&diving==false){
      angle=asin((-yPos+square.yPos)/(dist(xPos,yPos,square.xPos,square.yPos)));
      diving=true;

    } 

    if(yPos<0||yPos>height){
      reset(); 
    }

  }
  int mainShot=15;
  int mainNumShot=15;

  void explodes(){
    if(destroyed==true){
      for(int i=0;i<maxEnBullets;i++){
        if (enemybullets[i].drawn==false&&mainShot>=0){
          enemybullets[i].xPos=xPos;
          enemybullets[i].yPos=yPos;
          enemybullets[i].bulAngle=(PI/mainNumShot)*(mainShot)*2;

          currentEnBullet=i;
          enemybullets[currentEnBullet].drawn=true;
          mainShot--;
        }

      }
      reset();
    } 





  }

  void hitSquare(){
    if(yPos<square.yPos+square.Width/2&&yPos>square.yPos-square.Width/2&&xPos<square.xPos+square.Width/2&&xPos>square.xPos-square.Width/2){
      square.health-=3*square.bulletDamage;
      reset();
      square.hitCountBlink=square.maxHitCountBlink;
      square.invincCount=square.maxHitCountBlink;
    }

  }


  void resetTimer(){
    if(xPos<abs(trans)&&timer==0||xPos>abs(trans)+width&&timer==0){
      offscreentimer--;
    }
    if(offscreentimer<=0){
      reset();
      //println("RESET");

    } 

  }

  void reset(){
    mainShot=mainNumShot;
    drawn=false;
    diving=false;

    xPos=0;
    yPos=0;


    glideVel=abs(glideVel);
    ;
    diveVel=abs(diveVel);

    drawn=false;
    toSpawn=false;
    diving=false;
    destroyed=false;

    randNum=0;
    randSide=0;
    angle=0;
    offscreentimer=5;

    timer=ceil(random(10,120));

  }

}



class Goons{

}

