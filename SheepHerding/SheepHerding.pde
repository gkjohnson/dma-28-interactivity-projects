/// THE GAME MAY RUN SLOWLY BY LEVEL 10 (if you can get that far) ///



import processing.opengl.*;

PImage sheepEat2;
PImage sheepTitle;
PImage sheepWin;

Dog dog;

Sheep [] sheep;
int maxSheep=500;

Flower [] flowers;
int maxFlowers=100;

Corral corral;
PFont arial;

float [][][] trail;
int trailLen=75;
boolean [][] trailDisp;

boolean relationships=false;
boolean showTrail=false;
boolean showFlowers=true;

float BARRIER_WIDTH=10;
float SCARE_DIST=75;

boolean gameWon=false;
boolean levelWon=false;
boolean inPlay=true;
boolean gameOver=false;
boolean pause=false;

int sheepCaught=0;
int level=0;
int timer=50;
int frameSec=60;

void setup(){
  levelChange();
  size(600,400,OPENGL);
  sheep=new Sheep[maxSheep];
  trail =new float[maxSheep][trailLen][2];
  trailDisp=new boolean[maxSheep][trailLen];
  flowers=new Flower[maxFlowers];
  dog=new Dog();
  for (int i=0; i<maxSheep;i++){
    sheep[i]=new Sheep(random(0,width),random(0,height),random(0,1000),i); 
  }
  for (int i=0; i<maxFlowers;i++){
   flowers[i]=new Flower(); 
  }
  
  
  sheepEat2=loadImage("sheepue.png");
    sheepTitle=loadImage("sheepueTitle.png");
  sheepWin=loadImage("sheepueWin.png");
  
  rectMode(CENTER);
  corral=new Corral(random(50,500),random(50,500),/*random(100,width)*/60,random(100,width-100));
  arial=loadFont("ArialMT-12.vlw");
  textFont(arial);
  textAlign(CENTER);
  smooth();
  noCursor();

}

void draw(){
  //draw BG
 // println(maxRand);

  background(180,205,100);
  //flowers
 drawFlowers();
  // noStroke();
  timing();
  if(level==-1){
    gameOver();
  }
  if (level==0){
        image(sheepTitle,0,0);
    level0();


    
  }
  else
    if(level>0&&level<11){
      // draw boundry
      
      
      fill(180,110,80);
      rect(width/2,8,width-13,3);
      rect(width/2,height-8,width-13,3);
      rect(8,height/2,3,height-13);
      rect(width-8,height/2,3,height-13);
      for (int i=0;i<width/50;i++){
       ellipse(7+i*50,8,7,7);
       ellipse(7+i*50,height-8,7,7); 
      }
            for (int i=1;i<height/50;i++){
       ellipse(8,7+i*50,7,7);
       ellipse(width-8,7+i*50,7,7); 
      }
      ellipse(width-8,8,7,7);
       ellipse(width-8,height-8,7,7);
      fill(255);
     
      if(showTrail==true){
        strokeWeight(4);
        drawTrails();
        strokeWeight(1);
      }
      corral.render();
      for (int i=0; i<sheepToRender;i++){
        sheep[i].render();
      }
      if(levelWon==true||gameWon==true){
        inPlay=false;
      }

      dog.render();
      //println(sheepCaught + " out of " + ceil(sheepToRender*sheepCaughtMOD)+ "     ("+sheepToRender+")");
      levelWinCheck();
      levelWon();
      UI(width-115,15);
      if(levelWon==false){
        sheepCaught=0;
      }
    }
    else if (level==11){
      gameWon=true;
      win();
    }
    
    if(pause==true){
    paused();
    }
}
///LEVELS///
void level0(){
  fill(0);
 // text("SHEEP  HERDING \n\n CLICK to begin",width/2,100);
 
  fill(0,50);
  noStroke();
  rect(125,240,230,90);
  fill(255);
  textAlign(LEFT);
  text("Directions",13,210);
    text("Herd the sheep into the corral. A box in\nthe upper right-hand corner indicates\nhow many sheep you have yet to herd\nand how much time is left.",13,235);


 
 
 
 
  fill(0,50);
  noStroke();
  rect(125,340,230,90);
  fill(255);
  textAlign(LEFT);
  text("Controls",13,310);
    text("Herd Sheep\nToggle Relationships Render\nToggle Trail Render\nToggle Grass Render",70,335);
  textAlign(RIGHT);
  text("MOUSE:\nR:\nT:\nF:",60,335);
 
  
  textAlign(CENTER);
  
}
void win(){
  image(sheepWin,0,0);
  //fill(0);
  //text("YOU WIN!\n\n YOU SHEEP HERDING FIEND !!!",width/2,100);
  //fill(255);  
}
void gameOver(){
  fill(0);
  image(sheepEat2,0,0);
  text("GAME  OVER\n\nYour sheep are disappointed...\n\n\nCLICK to restart ",width/2,100);
  fill(255);
}
void timing(){
  if (timer==0){
    gameOver=true;
    level=-1; 
  }
}
void paused(){
 fill(0,100);
rect(width/2,height/2,width,height);
fill(255);
text("PAUSED ",width/2,100);
}

///FUNCTIONS///
void drawFlowers(){
   if(showFlowers==true){
  noStroke();
  for (int i=0;i<maxFlowers;i++){
   flowers[i].render(); 
  }
  fill(255);
  stroke(0);
  
  rectMode(CENTER);}
}
void drawTrails(){

  float ORIG_OPAC=100;
  for (int i=0;i<sheepToRender;i++){
    float opacity=ORIG_OPAC;
    for(int j=1;j<trailLen;j++){
      stroke(150,50,0,opacity);
      if(trailDisp[i][j]==true){
        line (trail[i][j][0] ,trail[i][j][1],trail[i][j-1][0],trail[i][j-1][1]);
        opacity-=ORIG_OPAC/(float)trailLen; 
      }
      else if (trailDisp[i][j]==false){
        opacity=ORIG_OPAC;
      }
    }
  }
  stroke(0); 
}

void levelWinCheck(){
  if(sheepCaught>=ceil(sheepToRender*sheepCaughtMOD)){
    println("WON");
    corral.left=true;    
    corral.right=true;    
    corral.up=true;    
    corral.down=true;
    levelWon=true;
    inPlay=false;
  } 
}

void levelWon(){
  if(levelWon==true){
    fill(0,100);
    rect(width/2,height/2,width,height);
    fill(255);
    text("You completed  Level " + nf(level,2) + "\n\n\n Press SPACE to continue",width/2,100);

  }
}

void timer(float x,float y){
  frameSec--;
  if(frameSec<=0&&inPlay==true&&pause==false){
    frameSec=60;
    timer--;
  }

  text("Time: " +nf(timer,2),x,y);

}



void UI(float x,float y){
  rectMode(CORNER);
  fill(0,50);
  noStroke();
  rect(x,y,100,46);
  fill(255);
  stroke(0);
  rectMode(CENTER);
    textAlign(RIGHT);
  timer(97+x,13+y);
 
  text("Level " + nf(level,2)+"\nSheep: " + nf((int)sheepCaught,3)+" / " +nf((int)(sheepToRender*sheepCaughtMOD),3),97+x,27+y);
    textAlign(CENTER);
  
}

void keyReleased(){
  if (key=='r'||key=='R'){
    if (relationships==true){
      relationships=false;
    } 
    else if (relationships==false){
      relationships=true;
    }
    println(relationships);
  }

  if (key=='t'||key=='T'){
    if (showTrail==true){
      showTrail=false;
    } 
    else if (showTrail==false){
      showTrail=true;
    }
  }

  if(key==' '&&levelWon==true){
    levelWon=false;
    level++;
    reset();
  } 
  
  if(key=='f'||key=='F'){
      if (showFlowers==true){
      showFlowers=false;
    } 
    else if (showFlowers==false){
      showFlowers=true;
    }
  }
  
  if(key=='p'&&levelWon==false){
   if(pause==false){
     pause=true; 
    
   }else if (pause==true){
   pause=false;
   } 
}
}

void mouseReleased(){
  if (mouseButton==LEFT&&level==0){
    level=1; 
    levelChange();
    reset();

  }else if (mouseButton==LEFT&&level==-1){
  level=0;
  reset();
  println("CLICK");
  }
  if(mouseButton==LEFT&&gameWon==true){
    gameWon=false;
        level=0;
      reset();

  


 levelWon=false;
 inPlay=true;
 gameOver=false;
 pause=false;
  gameWon=false;
  }
}


void reset(){

  for (int i=0;i<maxSheep;i++){
    sheep[i].reset(random(0,width),random(0,height),random(0,1000));
  }

  inPlay=true;
  frameSec=60;
  sheepCaught=0;
  levelChange();
    corral.reset(100,100,/*random(100,width)*/60,random(100,width-100));
}

void levelChange(){
  if(level==1){
    maxRand=200;
    minRand=70;
    minArea=12000;
    maxArea=15000;
    sheepCaughtMOD=.4;
    sheepToRender=100;
    timer=120;
println("GOOOO");
  }
  else if (level==2){
    maxRand=150;
    minRand=70;
    minArea=10000;
    maxArea=13000;
    sheepCaughtMOD=.45;
    sheepToRender=150;
    timer=100;
  }
  else if (level==3){
    maxRand=150;
    minRand=20;
    minArea=7000;
    maxArea=10000;
    sheepCaughtMOD=.55;
    sheepToRender=200;
    timer=100;
  }
  else if (level==4){
    maxRand=150;
    minRand=20;
    minArea=4000;
    maxArea=7000;
    sheepCaughtMOD=.5;
    sheepToRender=200;
    timer=90;
  }
  else if (level==5){
    maxRand=100;
    minRand=10;
    minArea=1000;
    maxArea=3000;
    sheepCaughtMOD=.45;
    sheepToRender=250;
    timer=80;
  }
  else if (level==6){
    maxRand=100;
    minRand=10;
    minArea=100;
    maxArea=1000;
    sheepCaughtMOD=.4;
    sheepToRender=250;
    timer=80;
  }
  else if (level==7){
    maxRand=100;
    minRand=10;
    minArea=100;
    maxArea=1000;
    sheepCaughtMOD=.4;
    sheepToRender=300;
    timer=75;
  }
  else if (level>8){
    maxRand=100;
    minRand=10;
    minArea=100;
    maxArea=1000;
    sheepCaughtMOD=.5;
    sheepToRender=300;
    timer=70;
  }

  else{
    timer=70;
  }

}






