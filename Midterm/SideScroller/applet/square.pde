class Square{
  //PARAMETERS
  float Width=20;
  float origHeight=20;
  float Height=origHeight;
  float crouchHeight=Height/2;
  float maxVel=5;
  float grav=.5;

  int maxHitCountBlink=6;
  int maxInvincCount=60;
  float bulletDamage=1;

  float jumpVel=10;
  int origJump=1;

  float slowRate=1.3;

  float maxHealth=20;
  int origLives=3;
  int origAmmo=10;



  //VARIABLES
  float xPos=width/2;
  float yPos=0;
  float xVel=0;
  float yVel=0;

  //COUNTERS
  int jumpCount=0;
  float health=10;
  int lives=3;
  int ammo=0;
  int coins=0;

  //BOOLEANS
  boolean onGround=false;
  boolean dead=false;
  boolean hit=false;
  boolean invinc=false;

  int hitCountBlink=0;
  int invincCount=0;


  //draws square and runs other functions
  void render(){
    if(hardMode==true){
     maxHealth=10;
    }else if (hardMode==false){
     maxHealth=20; 
    }
    xPos+=xVel;
    yPos+=yVel;
    if(hitCountBlink>0){
      hitCountBlink--;
    };
    if(invincCount>0){
      invincCount--; 
    }

    if(onGround==false){
      yVel+=grav;
    } 
    else if (onGround==true){
      jumpCount=origJump;
      yVel=0; 
    }


    if(hit==true){
      fill(20);
    }
    else {
      fill(255);
    }
    rect(xPos,yPos,Width,Height);
    fill(255);
    if(onGround==false&&jump==false){
      jumpCount=origJump-1; 
    }



    if(dead==false&&levelBeaten==false){
      keys();
    }
    bounds();

    die();
    if(hitCountBlink==0){
      hit=false;
    }
    else if (hitCountBlink>0){
      hit=true;
    }

    if(invincCount==0){
      invinc=false;
    }
    else if (invincCount>0){
      invinc=true;
    }

  }

  //Check if square has hit sides
  void bounds(){
    if(xPos>levelEnd){
      xPos=levelEnd;
      xVel=0;
    }
    if(xPos<0){
      xPos=0;
      xVel=0;
    }
    if(xPos<abs(trans)){
      xPos=abs(trans); 
      xVel=0;
    }
    else if (xPos>abs(trans)+width){
      xVel=0;
      xPos=abs(trans)+width; 
    }
  }


  //Check if keys are pressed -- accelerate/decelerate
  void keys(){
    //LEFT
    if(left==true&&crouch==false){
      if(xVel>=maxVel*-1){
        if(jump==false){
          xVel--;
        }
        else if (jump==true){
          xVel-=.5;
        }
      } 
      else if (xVel<maxVel*-1){
        xVel=maxVel*-1;
      }
    }
    //RIGHT
    if (right==true&&crouch==false){
      if(xVel<=maxVel){
        if(jump==false){
          xVel++;
        }
        else if (jump==true){
          xVel+=.5;
        }

      } 
      else if (xVel>maxVel){
        xVel=maxVel;
      }
    } 
    //CROUCH
    if(crouch==true){
      Height=crouchHeight;

      left=false;
      right=false;

    }
    else if (crouch==false){
      Height=origHeight; 
    }


    //SLOW
    if(onGround ==true){
      if(left!=true&&right!=true&&abs(xVel)>.1){
        xVel=xVel/slowRate;
      }
      else if (left!=true&&right!=true&&xVel<.1){
        xVel=0;
      }
    }
  }

  //how to die
  void die(){
    if(health<=0||yPos>height+50){
      dead=true;
      health=0;
      yPos=-100;
      if(lives>0){
        lives--;
      }
      else if (lives<=0){
        gameOver=true;
      }
      inPlay=false;
    }
  }

  void respawn(){
    if(dead==true){
      invincCount=maxInvincCount;
      yPos=0; 
      xPos=checkpoints.currentCheckpoint;
      trans=-checkpoints.currentCheckpoint+width/2;
      onGround=false;
      yVel=0;
      xVel=0;
      dead=false;
      health=maxHealth;
      ammo=origAmmo;
      inPlay=true;
      

    }
  }

}







