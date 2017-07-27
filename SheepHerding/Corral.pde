int maxRand=300;
int minRand=50;
float minArea=10000;
float maxArea=15000;
float sheepCaughtMOD=.2;
int sheepToRender=100;


class Corral{
  float Width;
  float Height;
  float x;
  float y;
  float wallWidth=3;
  
  boolean up=true;
  boolean down=true;
  boolean left=true;
  boolean right=false;
  
  
  Corral(float newWidth,float newHeight, float newX, float newY){
 reset(newWidth,newHeight,newX,newY);}
  
  void render(){
          fill(150,80,40);

    rect(x,y,Width,Height);

    if(left==true){
      rect(x-Width/2-wallWidth,y,wallWidth*2,Height+wallWidth*4);
    }
    if(right==true){
    rect(x+Width/2+wallWidth,y,wallWidth*2,Height+wallWidth*4);}
    
    if(up==true){rect(x,y-Height/2-wallWidth,Width+wallWidth*4,wallWidth*2);}
    if(down==true){rect(x,y+Height/2+wallWidth,Width+wallWidth*4,wallWidth*2);}
fill(255);  
}
  
  void reset(float newWidth,float newHeight, float newX, float newY){
    Width=random(minRand,maxRand);
    Height=random(minRand,maxRand);

    y=newY;
    
    while (Width*Height<minArea||Width*Height>maxArea){
      println(Width*Height);
      Width=random(minRand,maxRand);
      Height=random(minRand,maxRand);
   }
    println(Width*Height);
        x=Width/2+10;
        y=random(Height/2,height-Height/2);
  
  right=false;
  }
}

class Flower{
  float r;
  float g;
  float b;
  float Size;
  
  float x;
  float y;
  
  float opac;
  
  
  Flower(){
    r=random(150,255);
    g=random(150,255);
    Size=random(3,10);
    x=random(10,width-10);
    y=random(10,height-10);
    opac=random(100,200);
  }
  
  void render(){
    fill(r,g,b,opac);
    ellipse(x,y,Size,Size);
  }
  
}
  
  

