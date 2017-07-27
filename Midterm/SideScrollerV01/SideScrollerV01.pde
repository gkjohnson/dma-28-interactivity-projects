



//Define Classes and Arrays
Square square;
Translate transChange;

Brick [] bricks;
int currentBrick=0;
int maxBricks=1000;

Bullet [] bullets;
int currentBullet=0;
int maxBullets=10;

AmmoKit ammokit;
HealthKit healthkit;

Coin [] coins;
int maxCoins=100;
int currentCoin=0;

CheckPoint [] checkpoints;
int currentCheckPointCount=0;
int maxCheckPoints=10;


int groundBricks=100;
//int[] holesArray = {1,2,3,4,5};
PFont font;


int HIT=0;


//SETUP//
void setup(){
  size(600,400);
  //hint(ENABLE_OPENGL_4X_SMOOTH);
  //hint(DISABLE_OPENGL_2X_SMOOTH);
  rect(70,70,20,20); 
  noCursor();
  smooth();
  
  

  square= new Square();
  transChange = new Translate();
  bricks= new Brick[maxBricks];
  bullets= new Bullet[maxBullets];

  ammokit=new AmmoKit();
  healthkit=new HealthKit();
  coins=new Coin[maxCoins];
  checkpoints=new CheckPoint[maxCheckPoints];


  for (int i=0; i<maxCoins; i++){
  coins[i]=new Coin();
  }
  for(int i=0;i<maxBullets;i++){
    bullets[i]=new Bullet();
  }
    for(int i=0;i<maxCheckPoints;i++){
    checkpoints[i]=new CheckPoint();
    
  }

  font=loadFont("ArialMT-11.vlw");
  textFont(font);
  square.respawn();
}
///

//PARAMETERS
float healthBarLen=100;
float healthFillLen=0;

//VARIABLES
float trans=0;

float rightBound=trans+width;
float leftBound=trans;
float angle=0;
int levelEnd=(groundBricks-1)*20;

float bounce=0;

//BOOLEANS
boolean left=false;
boolean right=false;
boolean jump=false;
boolean crouch=false;
boolean horizFire=false;
boolean bossinPlay=false;
boolean inPlay=false;
boolean gameOver=false;

//COUNTERS
int level=2;

int currentCheckPoint=-1;

//DRAW//
void draw(){
  
stroke(0);
  
  
  background (205);
  noFill();
  

  
  fill(255);

  //Update Variables
  healthFillLen=map(square.health, 0,square.maxHealth, 0,healthBarLen);
  
  if(bounce>=2*PI){
   bounce=0; 
  }
  bounce+=PI/40;
  
  transChange.updateTrans();

  rightBound=abs(trans)+width;
  leftBound=abs(trans);
  currentAngle();


//DRAW LEVEL
  pushMatrix();
  {
    translate(trans,0);
    line (levelEnd-175,0, levelEnd-175,height);
    if(square.dead==false){
      square.render();
    }
    square.onGround=false;

    if(level==1){
      Level1();
    } 
    else if (level==2){
      Level2();
    }
    bulletCycle();
  }

  currentBrick=0;
  popMatrix();

  HUD();
  deadScreen();

  {
    noFill();
    ellipse(mouseX,mouseY,5,5);
    ellipse(mouseX,mouseY,10,10);
    line(mouseX-2.5,mouseY,mouseX+2.5,mouseY); 
    fill(255);
  }

}
//

//CUSTOM FUNCTIONS

void Level1(){

  for (int i=0; i<maxBricks/4; i++){
    bricks[currentBrick]=new Brick();
    bricks[currentBrick].xPos=i*20; 
    bricks[currentBrick].yPos=380;
    bricks[currentBrick].render();
    currentBrick++;
  } 

  for (int i=0; i<maxBricks/2; i++){
    bricks[currentBrick]=new Brick();
    bricks[currentBrick].xPos=i*20; 
    bricks[currentBrick].render();
    currentBrick++;
  }
}

void Level2(){
  ammokit.render();
  healthkit.render();
  coins[0].render();
  for (int i=0; i<10; i++){
    bricks[currentBrick]=new Brick();
    bricks[currentBrick].xPos=i*20; 
    bricks[currentBrick].yPos=19*20;
    bricks[currentBrick].render();
    currentBrick++;
  } 
  for (int i=0; i<10; i++){
    bricks[currentBrick]=new Brick();
    bricks[currentBrick].xPos=i*20+500; 
    bricks[currentBrick].yPos=17*20;
    bricks[currentBrick].render();
    currentBrick++;
  } 
  for (int i=0; i<groundBricks; i++){

    if(i!=30&&i!=31&&i!=32&&i!=33){
      bricks[currentBrick]=new Brick();
      bricks[currentBrick].xPos=i*20; 
      bricks[currentBrick].render();
      currentBrick++;
    }
  }
}

void HUD(){
  rectMode(CORNER);

  fill(255);
  noStroke();
  rect(10,10,healthFillLen,12);

  noFill();
  stroke(0);
  rect(10,10,healthBarLen,12);

  fill(255);
  for(int i=0;i<square.lives;i++){
    rect(10+(i)*10 ,25, 5,5);
  }
  fill(0);
  text("Ammo: " + nf(square.ammo,2)+"\nCoins  : "+nf(square.coins,2), healthBarLen+15,20);
  text("Level: " + nf(level,2),width-50,20);


  fill(255);
  stroke(0);
  rectMode(CENTER);


}


void bulletCycle(){
  for(int i=0;i<maxBullets;i++){
    if(bullets[i].drawn==true){
      bullets[i].render();
    } 
    else
      if (bullets[i].drawn==false){
        bullets[i].xPos=-10;
        bullets[i].yPos=-10;
        currentBullet=i;
      }

  }
}

void currentAngle(){
  if (horizFire==false){
    if(abs(mouseX+abs(trans)-square.xPos)/(mouseX+abs(trans)-square.xPos)==1){
      angle=asin((mouseY-square.yPos)/(dist(mouseX+abs(trans),mouseY,square.xPos,square.yPos))); 

    } 
    else if
      (abs(mouseX-square.xPos+abs(trans))/(mouseX+abs(trans)-square.xPos)==-1){
      angle=-asin((mouseY-square.yPos)/(dist(mouseX+abs(trans),mouseY,square.xPos,square.yPos)))+PI;
    }
  }
  else

      if(horizFire==true){


      if(right==true){
        angle=0;
      }
      else if (left==true){
        angle=PI;
      }

    }
}


void deadScreen(){
  if(square.dead==true&&gameOver==false){
    fill(0,100);
    noStroke();
    rect( width/2,height/2,width,height);
    fill(255);
    stroke(0);
    textAlign(CENTER);
    text("You Died!\n\nYou have " + square.lives + " lives left!\nLEFT CLICK to respawn",width/2,height/2);
    textAlign(LEFT);
  } 
  if (square.dead==true&&gameOver==true){
    fill(0,200);
    noStroke();
    rect( width/2,height/2,width,height);
    fill(255);
    stroke(0);
    textAlign(CENTER);
    text("GAME OVER\nLEFT CLICK to respawn",width/2,height/2);
    textAlign(LEFT);
  
    currentCheckPoint=0;
  }
}

void reset(){
  square.xPos=150;
  square.respawn();
  square.lives=square.origLives;
  square.coins=0;
  square.dead=false;
  gameOver=false;


  trans=0;

}

void nextLevel(){
}


//KEY AND MOUSE FUNCTIONS
void keyPressed(){
  if(key=='a'){
    left=true; 
  }

  if(key=='d'){
    right=true;
  }
  if(key=='w'&&square.jumpCount>0){
    jump=true; 

    square.onGround=false;
    square.jumpCount--;
    square.yVel=-square.jumpVel;
  }
  if(key=='s'&&square.onGround==true){
    crouch=true;
  }
}


void keyReleased(){
  if (key=='a'){
    left=false;
  }

  if (key=='d'){
    right=false;
  }
  if(key=='w'){

  }
  if(key=='s'){
    crouch=false; 
  }
}


void mousePressed(){
  if(mouseButton==LEFT&&bullets[currentBullet].drawn==false&&square.dead==false&&gameOver==false&&square.ammo>0){
    bullets[currentBullet].drawn=true;
    bullets[currentBullet].xPos=square.xPos;
    bullets[currentBullet].yPos=square.yPos; 
    bullets[currentBullet].bulAngle=angle;
    square.ammo--;
  } 
  else if (mouseButton==LEFT&&square.dead==true&&gameOver==false){
    square.respawn(); 
  } 
  else if (mouseButton==LEFT&&square.dead==true&&gameOver==true){

    reset();
  }

}



