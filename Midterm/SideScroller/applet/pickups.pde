class AmmoKit{
  float xPosOrig=100;
  float yPosOrig=350;
  float xPos=100;
  float yPosBase=350;
  float yPos=0;

  float Width=10;
  float Height=14;
  boolean collected=false;


  void render(){
    yPos=yPosBase+3*sin(bounce+PI);

    rectMode(CENTER);
    //draw kit
    if(collected==false){
      /*rect(xPos,yPos, Width,Height);
       for(int i=1;i<=4;i++){
       line(xPos+(Width/5)*i-Width/2,yPos-Height/2, xPos+(Width/5)*i-Width/2,yPos+Height/2); 
       }*/      fill(255,80);
      noStroke();
      xPos=xPosOrig;
      yPosBase=yPosOrig;
      ellipse(xPos,yPos,35,35);
      ellipse(xPos,yPos,25,25);

      image(ammo,xPos,yPos);

      stroke(0);
      fill(255);
    }
    else if (collected==true){
      xPos=-100;
      yPos=-100; 
    }
    collected();


  }

  void collected(){
    if(xPos+Width/2>square.xPos-square.Width/2 && xPos-Width/2<square.xPos+square.Width/2 && yPos+Width/2>square.yPos-square.Height/2 && yPos-Width/2<square.yPos+square.Height/2 && collected==false){
      collected=true;
      square.ammo+=5;
    }
  }
}




class HealthKit{
  float healthInc=3;
  float xPosOrig=300;
  float yPosOrig=300;
  float xPos=300;
  float yPosBase=300;
  float yPos=0;
  float Width=19;
  float Height=13;
  boolean collected=false;

  void render(){
    yPos=yPosBase+3*sin(bounce);
    rectMode(CENTER);
    if(collected==false){
      /*   rect(xPos,yPos, Width,Height);
       line(xPos-8,yPos+Height/2,xPos-8,yPos-Height/2);
       
       noStroke();
       fill(255,200,200);
       rect(xPos,yPos,10,4);
       rect(xPos,yPos,4,10);
       fill(255);
       stroke(0);*/
      fill(255,80);
      noStroke();
      xPos=xPosOrig;
      yPosBase=yPosOrig;
      ellipse(xPos,yPos,35,35);
      ellipse(xPos,yPos,25,25);
      image(health,xPos,yPos);
      stroke(0);
      fill(255);  
    }
    else if (collected==true){
      xPos=-100;
      yPos=-100; 
    }
    collected();
  }


  void collected(){
    if(xPos+Width/2>square.xPos-square.Width/2 && xPos-Width/2<square.xPos+square.Width/2 && yPos+Width/2>square.yPos-square.Height/2 && yPos-Width/2<square.yPos+square.Height/2 && collected==false){
      collected=true;
      if(square.health+healthInc<=square.maxHealth){
        square.health+=healthInc;
      }
      else if (square.health<square.maxHealth&&square.health>square.maxHealth-healthInc){
        square.health=square.maxHealth;

      }


    }
  }
}





class Coin{
  float xPosOrig=500;
  float yPosOrig=275;
  float xPos=500;
  float yPos=275;
  float Width=10;
  float Height=10;
  boolean collected=false;

  void render(){
    rectMode(CENTER);
    if(collected==false){

      xPos=xPosOrig;
      yPos=yPosOrig;
      noStroke();
      fill(0);
      ellipse(xPos,yPos,Width+4,Height+4);
      stroke(255);
      noFill();
      ellipse(xPos,yPos,Width,Height);
      noStroke();
      fill(255);
      ellipse(xPos,yPos,Width-4,Height-4);
      stroke(0);
      fill(255);
    }
    else if (collected==true){
      xPos=-100;
      yPos=-100; 
    }
    collected();
  }


  void collected(){
    if(xPos+Width/2>square.xPos-square.Width/2 && xPos-Width/2<square.xPos+square.Width/2 && yPos+Width/2>square.yPos-square.Height/2 && yPos-Width/2<square.yPos+square.Height/2 && collected==false){
      collected=true;
      square.coins++;
    }
  }

}

class OneUP{
  
}


