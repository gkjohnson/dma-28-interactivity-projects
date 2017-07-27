class Square{
  //PARAMETERS
  float Width=20;
  float origHeight=20;
  float Height=origHeight;
  float crouchHeight=Height/2;
  float maxVel=6;
  float grav=.5;

  float jumpVel=8;
  int origJump=1;

  float slowRate=1.2;

  float maxHealth=20;
  int origLives=3;
  int origAmmo=10;
  


  //VARIABLES
  float xPos=50;
  float yPos=0;
  float xVel=0;
  float yVel=0;

  //COUNTERS
  int jumpCount=0;
  float health=20;
  int lives=3;
  int ammo=origAmmo;
  int coins=0;

  //BOOLEANS
  boolean onGround=false;
  boolean dead=false;


  //draws square and runs other functions
  void render(){
    xPos+=xVel;
    yPos+=yVel;



    if(onGround==false){
      yVel+=grav;
    } 
    else if (onGround==true){
      jumpCount=origJump;
      yVel=0; 
    }

    rect(xPos,yPos,Width,Height);

    if(onGround==false&&jump==false){
      jumpCount=origJump-1; 
    }

    if(dead==false){
      keys();
    }
    bounds();

    die();


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

    }else if (crouch==false){
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
    if(health==0||yPos>height+Width/2){
      dead=true;
      health=0;
      yPos=-100;
      if(lives>0){
        lives--;
      }
      else if (lives<=0){
        gameOver=true;
      }
    }
  }

  void respawn(){
    if(dead==true){
      yPos=0; 
      onGround=false;
      yVel=0;
      xVel=0;
      dead=false;
      health=maxHealth;
      ammo=origAmmo;

    }
  }

}


class SpeechBubble{
}






