class Pellet{
  
  float x=0;
  float y=0;
  float xPVel=0;
  float yPVel=0;
  float pelletWidth=10;
  int dropped=0;
  float pelletGround=ground-pelletWidth/2;

  void dropped(){
    x+=xPVel;
    y+=yPVel;
    
    if(dropped==2){
          eaten();
          
      if (pelletGround>y){
        yPVel+=gravity;
      }
      else if (pelletGround<=y){
        y=pelletGround;
        if(yPVel>=6){
          yPVel=yPVel*-.5;
        }
        else if (yVel<6){
          yPVel=0;
        }
      }
    }
    else if (dropped==1){
      yPVel=0;
      x=mouseX;
      y=mouseY;
      println("stuck , " + currentPellet);
    }

    if(dropped!=0){
      display(x,y);
    }
  }

  void display(float xdisp,float ydisp){
    if(mousePressed){
      xdisp=mouseX;
      ydisp=mouseY;
    }
    
    noFill();
    stroke(255);
    ellipse(x,y,pelletWidth,pelletWidth);
    noStroke();
    fill(255);
    ellipse(x,y,pelletWidth/2,pelletWidth/2); 
  }


  void eaten(){
    if(abs(x-xPos)<sqWidth/2&&abs(y-yPos)<sqWidth/2){
      if(health<maxHealth){
        health+=healthInc; 
      }
      
      dropped=0;
      foodEaten++;
      yPVel=0;
      x=0;
      y=0;
    }
  }
}



