class MechBoss{
  float xPos=levelEnd;
  
  float xBound=levelEnd-175;
  
  float health=100;
  
  boolean drawn=false;
  boolean xStop=true;
  boolean bossOn=false;
  boolean dead=false;
  boolean exploding=false;

  void render(){
    if(square.xPos>xBound&&xStop==true){
     square.xVel=0;
    square. xPos=xBound; 
    }
    rectMode(CORNER);
    rect(xPos-20,-10,20,120);
    rect(xPos-140,5*20+10,140,100);
    rect(xPos-100,210, 100,40);
    rect(xPos-30,250,30,160);
    
    
    rectMode(CENTER);
    
    
    
  }
  
  void drawn(){
  }
  
  
  
  
}