

//load images
PImage brick2;
PImage brick1;
PImage brick3;
PImage bg;
PImage ammo;
PImage health;

PImage mechbossRotGun;
PImage mechbossMiniGun;
PImage mechbossMiniGunDead;

PImage mechbosscl;
PImage mechbossop1;
PImage mechbossop2;
PImage wires;

PImage divebomberglide;
PImage diverbomberdive;


//Define Classes and Arrays
Square square;
Translate transChange;
//Bricks
Brick [] bricks;
int currentBrick=0;
int maxBricks=1000;
//Bullets
Bullet [] bullets;
int currentBullet=0;
int maxBullets=10;
//Enemy Bullets
EnemyBullet [] enemybullets;
int currentEnBullet=0;
int maxEnBullets=100;
//Ammo
AmmoKit []ammokits;
int currentAmmoKit=0;
int maxAmmoKits=10;
AmmoKit bossammokit;
HealthKit [] healthkits;
int currentHealthKit=0;
int maxHealthKits=10;
//Coins
Coin [] coins;
int maxCoins=100;
int currentCoin=0;

CheckPoints checkpoints;

//enemy
DiveBomber divebomber;

//Bosses
MechBoss mechboss;
nullBoss nullboss;


//nextLevel
nextLevel nextlevel;

int groundBricks=450;
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
  //load images
  brick2=loadImage("brick2mech.gif");
  brick1=loadImage("brick1mech.gif");
  brick3=loadImage("brick3.gif");
  bg=loadImage("background.gif");
  ammo=loadImage("ammo.gif");
  health=loadImage("health.gif");
  mechbossRotGun=loadImage("mechbossrot.gif");
  mechbossMiniGun=loadImage("mechbossminigun.gif");
  mechbossMiniGunDead=loadImage("mechbossminigundead.gif");
  mechbosscl=loadImage("mainhubcl.gif");
  mechbossop1=loadImage("mainhubop1.gif");
  mechbossop2=loadImage("mainhubop2.gif");
  wires =loadImage("wires.gif");
  divebomberglide=loadImage("divebomberglide.gif");

  imageMode(CENTER);

  //laod arrays
  bossammokit=new AmmoKit();
  square= new Square();
  transChange = new Translate();
  bricks= new Brick[maxBricks];
  bullets= new Bullet[maxBullets];
  enemybullets=new EnemyBullet[maxEnBullets];

  ammokits=new AmmoKit[10];
  healthkits=new HealthKit[10];
  coins=new Coin[maxCoins];

  divebomber= new DiveBomber();

  nextlevel=new nextLevel();


  mechboss= new MechBoss();
  nullboss= new nullBoss();

  ammokits[0]=new AmmoKit();
  healthkits[0]=new HealthKit();

  checkpoints=new CheckPoints();

  for (int i=0; i<maxHealthKits; i++){
    healthkits[i]=new HealthKit();
  }
  for (int i=0; i<maxAmmoKits; i++){
    ammokits[i]=new AmmoKit();
  }
  for (int i=0; i<maxCoins; i++){
    coins[i]=new Coin();
  }
  for(int i=0;i<maxBullets;i++){
    bullets[i]=new Bullet();
  }
  for(int i=0;i<maxEnBullets;i++){
    enemybullets[i]=new EnemyBullet();
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
boolean inPlay=true;
boolean gameOver=false;
boolean levelBeaten=false;
boolean hardMode=false;


//COUNTERS
int level=0;
int timeFrames=0;
int timeSeconds=ceil(timeFrames/60)-1;


//DRAW//
void draw(){

  frameRate(60);
  levelEnd=(groundBricks-1)*20;
  println(square.xPos);
  stroke(0);




  background (50);



  fill(255);



  //Update Variables
  if(inPlay==true){
    timeFrames++;
  }
  timeSeconds=ceil(timeFrames/60);
  //println(timeSeconds);
  healthFillLen=map(square.health, 0,square.maxHealth, 0,healthBarLen);

  if(bounce>=2*PI){
    bounce=0; 
  }
  bounce+=PI/40;

  transChange.updateTrans();

  rightBound=abs(trans)+width;
  leftBound=abs(trans);
  currentAngle();

  pushMatrix();
  {

    imageMode(CORNER);
    //image(bg,0,0);
    imageMode(CENTER);

  }
  popMatrix();


  //DRAW LEVEL
  pushMatrix();
  {
    translate(trans,0);

    if(square.dead==false){
      square.render();
    }
    square.onGround=false;
    if(level==0){
      Level0();
    }
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

  if(level>0){
    HUD();
  }
  deadScreen();

  {
    noStroke();
    fill(255,100);
    ellipse(mouseX,mouseY,15,15);
    stroke(0);
    noFill();
    ellipse(mouseX,mouseY,5,5);
    ellipse(mouseX,mouseY,11,11);
    line(mouseX-2.5,mouseY,mouseX+2.5,mouseY); 
    fill(255);
  }



}
//

//CUSTOM FUNCTIONS
void Level0(){
  groundBricks=31;
  square.ammo=10;
  textAlign(CENTER);
  text("GAME\n\nA: LEFT\nD: RIGHT",width/2,100);
  textAlign(LEFT);
  text("<-- Hard Mode",50,200);
  textAlign(RIGHT);
  text("Easy Mode -->",width-50,200);
  for (int i=0; i<groundBricks; i++){
    bricks[currentBrick]=new Brick();
    bricks[currentBrick].xPos=i*20; 
    bricks[currentBrick].render();
    currentBrick++;
  }
  nextlevel.hardModeChoice();

  textAlign(LEFT);
}
void Level1(){
  groundBricks=50;
  for (int i=0; i<groundBricks/2; i++){
    bricks[currentBrick]=new Brick();
    bricks[currentBrick].xPos=i*20; 
    bricks[currentBrick].yPos=380;
    bricks[currentBrick].render();
    currentBrick++;
  } 

  for (int i=0; i<groundBricks; i++){
    bricks[currentBrick]=new Brick();
    bricks[currentBrick].xPos=i*20; 
    bricks[currentBrick].render();
    currentBrick++;
  }
  fill(100);
  textAlign(RIGHT);
  text("Controls:\nA: \nW: \nD: \nLEFT CLICK:",80,100);
  textAlign(LEFT);
  text("\nLEFT\nJUMP\n RIGHT\nSHOOT",90,100);
  fill(255);
  nullboss.render();
  nextlevel.run();
  nextlevel.levelbeaten();

}

void Level2(){
  groundBricks=450;
  ammokits[0].render();
  healthkits[0].render();
  coins[0].render();
 
  checkpoints.CPLevel2();
  //sixteenth Line
  for (int i=0; i<groundBricks; i++){
    if(i==398||(i>408&&i<412)){
      bricks[currentBrick]=new Brick();
      bricks[currentBrick].xPos=i*20; 
      bricks[currentBrick].yPos=5*20;
      bricks[currentBrick].render();
      currentBrick++;
    }
  }


  //eleventh Line
  for (int i=0; i<groundBricks; i++){
    if(i==395){
      bricks[currentBrick]=new Brick();
      bricks[currentBrick].xPos=i*20; 
      bricks[currentBrick].yPos=10*20;
      bricks[currentBrick].render();
      currentBrick++;
    }
  }

  //tenth Line
  for (int i=0; i<groundBricks; i++){
    if(i==148||i==149||i==152||(i>163&&i<170)||i==211||i==214){
      bricks[currentBrick]=new Brick();
      bricks[currentBrick].xPos=i*20; 
      bricks[currentBrick].yPos=11*20;
      bricks[currentBrick].render();
      currentBrick++;
    }
  }
  //ninth Line
  for (int i=0; i<groundBricks; i++){
    if(i==148||i==149||i==152||i==208||i==211||i==214){
      bricks[currentBrick]=new Brick();
      bricks[currentBrick].xPos=i*20; 
      bricks[currentBrick].yPos=12*20;
      bricks[currentBrick].render();
      currentBrick++;
    }
  }
  //eigth Line
  for (int i=0; i<groundBricks; i++){
    if(i==148||i==149||i==152||(i>385&&i<388)||i==205||i==208||i==211||i==214){
      bricks[currentBrick]=new Brick();
      bricks[currentBrick].xPos=i*20; 
      bricks[currentBrick].yPos=13*20;
      bricks[currentBrick].render();
      currentBrick++;
    }
  }
  //seventh Line
  for (int i=0; i<groundBricks; i++){
    if(i==148||i==149||i==152||(i>375&&i<378)||i==202||i==205||i==208||i==211||i==214){
      bricks[currentBrick]=new Brick();
      bricks[currentBrick].xPos=i*20; 
      bricks[currentBrick].yPos=14*20;
      bricks[currentBrick].render();
      currentBrick++;
    }
  }

  //sixth Line
  for (int i=0; i<groundBricks; i++){
    if(i==148||i==149||i==152||(i>365&&i<368)||i==199||i==202||i==205||i==208||i==211||i==214){
      bricks[currentBrick]=new Brick();
      bricks[currentBrick].xPos=i*20; 
      bricks[currentBrick].yPos=15*20;
      bricks[currentBrick].render();
      currentBrick++;
    }
  }
  //fifth Line
  for (int i=0; i<groundBricks; i++){
    if(i==69||(i>125&&i<130)||(i>355&&i<358)||i==143||i==148||i==149||i==152||i==196||i==199||i==202||i==205||i==208||i==211||i==214){
      bricks[currentBrick]=new Brick();
      bricks[currentBrick].xPos=i*20; 
      bricks[currentBrick].yPos=16*20;
      bricks[currentBrick].render();
      currentBrick++;
    }
  }

  //fourth Line
  for (int i=0; i<groundBricks; i++){
    if((i>=25&&i<35)||(i>67&&i<70)||(i>80&&i<90)||(i>330&&i<348)||i==148||i==149||i==152||i==193||i==196||i==199||i==202||i==205||i==208||i==211||i==214){
      bricks[currentBrick]=new Brick();
      bricks[currentBrick].xPos=i*20; 
      bricks[currentBrick].yPos=17*20;
      bricks[currentBrick].render();
      currentBrick++;
    }
  } 

  //third line
  for (int i=0; i<groundBricks; i++){
    if(i==0||(i>66&&i<70)||(i>=89&&i<=90)||i==149||i==148||i==152||i==161||i==160||i==190||i==193||i==196||i==199||i==202||i==205||i==208||i==211||i==214){
      bricks[currentBrick]=new Brick();
      bricks[currentBrick].xPos=i*20; 
      bricks[currentBrick].yPos=18*20;
      bricks[currentBrick].render();
      currentBrick++;
    }
  } 

  //second line
  for (int i=0; i<groundBricks; i++){
    if((i>=0&&i<=10)||i==39||(i>65&&i<70)||(i>=89&&i<=91)||i==148||i==149||i==152||i==153||i==214){
      bricks[currentBrick]=new Brick();
      bricks[currentBrick].xPos=i*20; 
      bricks[currentBrick].yPos=19*20;
      bricks[currentBrick].render();
      currentBrick++;
    }
  } 
  //groundBricks
  for (int i=0; i<groundBricks; i++){

    if((i<30||i>33)&&(i<70||i>80)&&(i<100||i>103)&&(i<105||i>108)&&(i<150||i>170)&&(i<250||i>257)&&(i<261||i>268)&&(i<271||i>280)&&(i<350||i>400)){
      // if(i<70||i>85||i==75||i==76){
      bricks[currentBrick]=new Brick();
      bricks[currentBrick].graphic=1;
      if(i>=419){
        bricks[currentBrick].graphic=2;
      }
      bricks[currentBrick].xPos=i*20; 
      bricks[currentBrick].render();

      currentBrick++;
    }
  }
  if(square.xPos>600&&abs(trans)<levelEnd-width-100){
    divebomber.withinRange=true;
    divebomber.render();

  }
  else{ 
    divebomber.reset();
  }

  mechboss.render();
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
    rect(12+(i)*10 ,25, 5,5);
  }


  fill(200 );
  text("Ammo: " + nf(square.ammo,2)+"\nCoins  : "+nf(square.coins,2), healthBarLen+15,20);
  text("Level: " + nf(level,2)+"\n"+nf(timeSeconds,4),width-50,20);

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
    text("You Died!\n\nYou have " + square.lives + " lives left!\nPress SPACE to respawn",width/2,height/2);
    textAlign(LEFT);
  } 
  if (square.dead==true&&gameOver==true){
    fill(0,200);
    noStroke();
    rect( width/2,height/2,width,height);
    fill(255);
    stroke(0);
    textAlign(CENTER);
    text("GAME OVER\nPress SPACE to start over",width/2,height/2);
    textAlign(LEFT);


  }
}

void completereset(){
  square.xPos=150;
  square.respawn();

  square.coins=0;
  square.dead=false;
  mechboss.reset();
  nullboss.reset();
  square.lives=square.origLives;
  square.ammo=square.origAmmo;
  timeFrames=0;
  checkpoints.currentCheckpoint=150;
  if(gameOver==true){


    level=0;
    square.xPos=width/2;
  }
  gameOver=false;
  levelBeaten=false;

  for(int i=0;i<maxAmmoKits;i++){
    ammokits[i].collected=false; 

  }
  for(int i=0;i<maxHealthKits;i++){
    healthkits[i].collected=false; 

  }
  for(int i=0;i<maxCoins;i++){
    coins[i].collected=false; 

  }
  trans=0;

}

void nextLevel(){
}


//KEY AND MOUSE FUNCTIONS
void keyPressed(){
  if(key=='a'||key==CODED &&keyCode==LEFT){
    left=true; 
  }

  if(key=='d'||key==CODED &&keyCode==RIGHT){
    right=true;
  }
  if(key=='w'&&square.jumpCount>0||key==CODED &&keyCode==UP&&square.jumpCount>0){
    jump=true; 

    square.onGround=false;
    square.jumpCount--;
    square.yVel=-square.jumpVel;
  }
  if(key=='s'&&square.onGround==true||key==CODED &&keyCode==DOWN&&square.onGround==true){
    crouch=true;
  }
}


void keyReleased(){
  if (key=='a'||key==CODED &&keyCode==LEFT){
    left=false;
  }

  if (key=='d'||key==CODED &&keyCode==RIGHT){
    right=false;
  }
  if(key=='w'||key==CODED &&keyCode==UP){

  }
  if(key=='s'||key==CODED &&keyCode==DOWN){
    crouch=false; 
  }


  if (key==' '&&square.dead==true&&gameOver==false){
    square.respawn(); 
  } 
  else if (key==' '&&square.dead==true&&gameOver==true){

    completereset();
  } 
  else if (key==' '&&levelBeaten==true){
    nextlevel.levelreset();
  }

  if((key=='l'||key=='L')&&square.lives<10&&inPlay==true){
    square.lives++; 
    timeFrames+=15*60;
  }
}


void mousePressed(){
  if(mouseButton==LEFT&&bullets[currentBullet].drawn==false&&square.dead==false&&gameOver==false&&square.ammo>0&&inPlay==true){
    bullets[currentBullet].drawn=true;
    bullets[currentBullet].xPos=square.xPos;
    bullets[currentBullet].yPos=square.yPos; 
    bullets[currentBullet].bulAngle=angle;
    square.ammo--;
  } 



}








