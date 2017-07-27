import processing.core.*; 
import processing.xml.*; 

import java.applet.*; 
import java.awt.*; 
import java.awt.image.*; 
import java.awt.event.*; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class project1 extends PApplet {



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
public void setup(){
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
public void draw(){

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
    line(mouseX-2.5f,mouseY,mouseX+2.5f,mouseY); 
    fill(255);
  }



}
//

//CUSTOM FUNCTIONS
public void Level0(){
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
public void Level1(){
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

public void Level2(){
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

public void HUD(){
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


public void bulletCycle(){
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

public void currentAngle(){
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


public void deadScreen(){
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

public void completereset(){
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

public void nextLevel(){
}


//KEY AND MOUSE FUNCTIONS
public void keyPressed(){
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


public void keyReleased(){
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


public void mousePressed(){
  if(mouseButton==LEFT&&bullets[currentBullet].drawn==false&&square.dead==false&&gameOver==false&&square.ammo>0&&inPlay==true){
    bullets[currentBullet].drawn=true;
    bullets[currentBullet].xPos=square.xPos;
    bullets[currentBullet].yPos=square.yPos; 
    bullets[currentBullet].bulAngle=angle;
    square.ammo--;
  } 



}








class MechBoss{
  float xPos=levelEnd;

  float xBound=levelEnd-180;

  float maxHealth=100;
  float health=100;
  float maxMiniGunHealth=30;
  float miniGunHealth1=30;
  float miniGunHealth2=30;

  float miniGunWidth=60;
  float miniGunHeight=25;

  boolean drawn=false;
  boolean xStop=true;
  boolean bossOn=false;
  boolean dead=false;
  boolean exploding=false;
  boolean miniGun1Dead=false;
  boolean miniGun2Dead=false;
  boolean vulnerable=false;

  boolean maingunhit=false;
  boolean minigun1hit=false;
  boolean minigun2hit=false;


  //mini gun
  float miniXPos=xPos-25;
  float miniYPos1=0;
  float miniYPos2=0;

  float rotXPos=xPos-52;
  float rotYPos=150;
  float rotGunAngle=0;
  //Counters

  int origMiniGunCount=45;
  int miniGunCount=origMiniGunCount;

  int origmainGunCount=300;
  int mainGunCount=origmainGunCount;

  int currentFill=0;
  int animationShot=0;

  int mainNumShot=20;

  float expCount=-10;

  int mainattackedcount=0;
  int mini1attackedcount=0;
  int mini2attackedcount=0;


  //RENDER//
  public void render(){

    if(dead==false){
      beingDrawn();
    }

    briks();
    line (xBound,0, xBound,height);


    if(drawn==true){

      if(bossOn==true){ 
        miniGunCount--;
        mainGunCount--;

      }



      if(square.xPos>xBound&&xStop==true){
        square.xVel=0;
        square. xPos=xBound; 
      }

      /* fill(255);
       rectMode(CORNER);
       rect(xPos-20,-10,20,120);
       rect(xPos-140,5*20+10,140,100);
       rect(xPos-100,210, 100,40);
       rect(xPos-30,250,30,160);
       */

      rectMode(CENTER);
      if(animationShot==0){
        vulnerable=false;
        image(mechbosscl,xPos-90,height/2);
      }
      else if (animationShot==1){
        vulnerable=false;
        image(mechbossop1,xPos-90,height/2);
      }
      else if (animationShot==2){
        vulnerable=true;
        image(mechbossop2,xPos-90,height/2);
      }



      //println(mainGunCount);

      if(dead==false&&bossOn==true){
        mainShootAnimation();
        attacked();
      }
    }
    if (miniGunCount<0){
      miniGunCount=origMiniGunCount; 
    }
    if(mainGunCount<=0){
      mainGunCount=origmainGunCount;
    }



    for(int i=0;i<maxEnBullets;i++){
      if(enemybullets[i].drawn==true){
        enemybullets[i].render();
      }
    }




    if(drawn==true){

      miniGun1();
      miniGun2();
      rotatingGun();
    }  
    image(wires,xPos-90,height/2);
    if(square.xPos>=xBound-100){
      bossOn=true; 
      trans=levelEnd-width;
    }
    if(bossOn==true){
      bossHUD();
    }
    explosion();
    dead();
  }
  int shot;
  int mainShot=mainNumShot;


  //mini gun shoot countdown timer

  public void miniGun1(){
    if(miniGun1Dead==false){ 
      shot=1;
      miniYPos1= constrain(square.yPos, 10,100);
      miniGunShoot(-PI,miniXPos,miniYPos1);
      //rect(miniXPos,miniYPos1,miniGunWidth,miniGunHeight);
      image(mechbossMiniGun,-20+miniXPos,miniYPos1);
      if(bossOn==true){ 

      }
    }
    else if (miniGun1Dead==true){

      //rect(miniXPos,miniYPos1,miniGunWidth,miniGunHeight);
      image(mechbossMiniGunDead,-20+miniXPos,miniYPos1);
    }

  }



  public void miniGun2(){
    if(miniGun2Dead==false){
      shot=1;
      miniYPos2= constrain(square.yPos, 260,380);
      miniGunShoot(-PI,miniXPos,miniYPos2);
      //rect(miniXPos,miniYPos2,miniGunWidth,miniGunHeight);
      image(mechbossMiniGun,-20+miniXPos,miniYPos2);
      if(bossOn==true){

      }
    }
    else if (miniGun2Dead==true){

      // rect(miniXPos,miniYPos2,miniGunWidth,miniGunHeight);
      image(mechbossMiniGunDead,-20+miniXPos,miniYPos2);

    }

  }

  public void rotatingGun(){
    if(dead==false){
      shot=1;
      if(bossOn==true){
        miniGunShoot(rotGunAngle+PI,rotXPos, rotYPos);
      }
      pushMatrix();
      {
        translate(rotXPos,rotYPos);
        // line(0,0,120*cos((rotGunAngle+PI)),120*sin((rotGunAngle+PI)));
        rotGunAngle=atan((square.yPos-rotYPos)/(square.xPos-rotXPos));
        rotate(rotGunAngle);
        //rect(-20,0,50,20);
        image(mechbossRotGun,-20,0);
      }
      popMatrix();
    }
    else if (dead==true){
      pushMatrix();
      {
        translate(rotXPos,rotYPos);
        //line(0,0,120*cos((rotGunAngle+PI)),120*sin((rotGunAngle+PIa
        rotate(rotGunAngle);
        image(mechbossRotGun,-20,0);
      }
      popMatrix();
    }
  }




  public void miniGunShoot(float bulletAngle,float bulXPos, float bulYPos){
    for(int i=0;i<maxEnBullets;i++){
      if (enemybullets[i].drawn==false&&shot==1&&miniGunCount==0){
        enemybullets[i].xPos=bulXPos;
        enemybullets[i].yPos=bulYPos;
        enemybullets[i].bulAngle=bulletAngle;
        currentEnBullet=i;
        shot--;
      }
    }


    if(miniGunCount==0){
      enemybullets[currentEnBullet].drawn=true;
    }
  }



  public void mainGunShoot(){
    for(int i=0;i<maxEnBullets;i++){
      if (enemybullets[i].drawn==false&&mainShot>=0){
        enemybullets[i].xPos=xPos-130;
        enemybullets[i].yPos=150;
        enemybullets[i].bulAngle=PI/2+(PI/mainNumShot)*(mainShot);

        currentEnBullet=i;
        enemybullets[currentEnBullet].drawn=true;
        mainShot--;
      }
    }
  }



  public void beingDrawn(){
    if (xBound>abs(trans)&&xBound<abs(trans)+width){
      drawn=true; 
    } 
    else {
      drawn=false; 
    }
  }



  public void bossHUD(){
    //healthBars
    rectMode(CORNER);
    noStroke();
    rect(abs(trans)+225,10,map(health,0,maxHealth,0,250),8);

    rect(abs(trans)+225,20,map(miniGunHealth1,0,maxMiniGunHealth,0,120),8);

    rect(abs(trans)+225+130,20,map(miniGunHealth2,0,maxMiniGunHealth,0,120),8);
    stroke(0);
    noFill();
    rect(abs(trans)+225,10,250, 8);
    rect(abs(trans)+225,20,120,8);

    rect(abs(trans)+225+130,20,120,8);
    fill(255);

    rectMode(CENTER);
  }

  public void attacked(){

    if(miniGun1Dead==false){
      for(int i=0; i<maxBullets;i++){
        if(bullets[i].damaging==true&&bullets[i].xPos>miniXPos-miniGunWidth/2&&bullets[i].xPos<miniXPos+miniGunWidth/2 && bullets[i].yPos>miniYPos1-miniGunHeight/2 && bullets[i].yPos<miniYPos1+miniGunHeight/2){
          miniGunHealth1-=bullets[i].damage;
          bullets[i].exploding=true;
        } 

      }

    }
    if(miniGun2Dead==false){
      for(int i=0; i<maxBullets;i++){
        if(bullets[i].damaging==true&&bullets[i].xPos>miniXPos-miniGunWidth/2&&bullets[i].xPos<miniXPos+miniGunWidth/2 && bullets[i].yPos>miniYPos2-miniGunHeight/2 && bullets[i].yPos<miniYPos2+miniGunHeight/2){
          miniGunHealth2-=bullets[i].damage;
          bullets[i].exploding=true;
        } 

      }
    }
    if(vulnerable==true){
      for(int i=0; i<maxBullets;i++){
        if(bullets[i].damaging==true&&bullets[i].xPos>xPos-150&&bullets[i].xPos<xPos-120&&bullets[i].yPos>115&&bullets[i].yPos<115+90){
          println("TRUE");
          health-=bullets[i].damage;
          bullets[i].exploding=true;
        }
      }
    }

  }


  public void mainShootAnimation(){
    mainShot=mainNumShot;

    if(health>=maxHealth/2){
      mainNumShot=10;
      if(mainGunCount==95||mainGunCount==5){
        //println("OPEN 1");
        currentFill=155;
        animationShot=1;
      } 
      else if (mainGunCount==90){
        //println("OPEN FULL");
        currentFill=255;
        animationShot=2;
      } 
      else if (mainGunCount==0){
        //println("CLOSED");
        currentFill=0;
        animationShot=0;
      }
      if(mainGunCount==45){
        // println("SHOOT)");
        mainGunShoot(); 
      }
    }
    else if (health>=maxHealth/4){
      mainNumShot=13;

      if(mainGunCount==200||mainGunCount==155||mainGunCount==50||mainGunCount==5){
        // println("OPEN 1");
        currentFill=155;
        animationShot=1;
      } 
      else if (mainGunCount==195||mainGunCount==45){
        //  println("OPEN FULL");
        currentFill=255;
        animationShot=2;
      } 
      else if (mainGunCount==0||mainGunCount==150){
        // println("CLOSED");
        currentFill=0;
        animationShot=0;
      }

      if(mainGunCount==177||mainGunCount==27){
        // println("SHOOT)");
        mainGunShoot(); 
      }
    }
    else if (health>0&&health<maxHealth/4)
    {
      if(origmainGunCount==300){
        origmainGunCount=75;
        currentFill=0;
        animationShot=0;  
      }
      mainNumShot=16;      



      if(mainGunCount==40||mainGunCount==5){
        // println("OPEN 1");
        currentFill=155;
        animationShot=1;
      } 
      else if (mainGunCount==35){
        // println("OPEN FULL");
        currentFill=255;
        animationShot=2;
      } 
      else if (mainGunCount==0){
        // println("CLOSED");
        currentFill=0;
        animationShot=0;
      }

      if(mainGunCount==20){
        //

        mainGunShoot(); 
      }
    }
  }

  public void dead(){
    if (miniGunHealth1<=0||dead==true){
      miniGunHealth1=0;
      miniGun1Dead=true;
    } 
    if (miniGunHealth2<=0||dead==true){
      miniGunHealth2=0;
      miniGun2Dead=true;
    } 
    if(health<=0){
      dead=true;
      health=0; 
    }

  }


  public void explosion(){
    if(dead==true&&expCount<30){
      //fill(255,map(expCount,0,30,255,0));
      if(expCount>0){
        fill(255,map(expCount,15,30,255,0));
        ellipse(xPos-75,height/2,3*pow(expCount,2),3*pow(expCount,2));

        if(expCount==15){
          drawn=false;
        }
      }
      expCount+=.5f;
      fill(255);
    }

  }



  int ammoKitCollectedCount=180;
  public void briks(){

    for (int i=0; i<3;i++){
      bricks[currentBrick]=new Brick();
      bricks[currentBrick].xPos=xPos-600+bricks[currentBrick].Width*i; 
      bricks[currentBrick].graphic=2;
      bricks[currentBrick].yPos=380;
      bricks[currentBrick].render();
      currentBrick++; 
    }

    for (int i=0; i<3;i++){
      bricks[currentBrick]=new Brick();
      bricks[currentBrick].xPos=xPos-410+bricks[currentBrick].Width*i; 
      bricks[currentBrick].graphic=2;
      bricks[currentBrick].yPos=380-80;
      bricks[currentBrick].render();
      currentBrick++; 
    }


    for (int i=0; i<6;i++){
      bricks[currentBrick]=new Brick();
      bricks[currentBrick].xPos=xPos-390+bricks[currentBrick].Width*i; 
      bricks[currentBrick].graphic=2;
      bricks[currentBrick].yPos=380-240;
      bricks[currentBrick].render();
      currentBrick++; 
    }

    for (int i=0; i<2;i++){
      bricks[currentBrick]=new Brick();
      bricks[currentBrick].xPos=xPos-570+bricks[currentBrick].Width*i; 
      bricks[currentBrick].graphic=2;
      bricks[currentBrick].yPos=380-160;
      bricks[currentBrick].render();
      currentBrick++; 
    }


    bricks[currentBrick]=new Brick();
    bricks[currentBrick].graphic=2;
    bricks[currentBrick].xPos=xPos-530; 
    bricks[currentBrick].yPos=380-180;
    bricks[currentBrick].render();
    currentBrick++; 

    if(drawn==true){
      for (int i=0; i<5;i++){
        bricks[currentBrick]=new Brick();
        bricks[currentBrick].graphic=2;                                                                                                                                              
        bricks[currentBrick].xPos=xPos-100; 
        bricks[currentBrick].yPos=120+bricks[currentBrick].Width*i;
        bricks[currentBrick].render();
        currentBrick++;
      } 
    }

    //AmmoKit
    if(bossammokit.collected==true){
      ammoKitCollectedCount=60; 
      bossammokit.collected=false;
    }
    if(ammoKitCollectedCount==0&&bossOn==true){
      bossammokit.xPosOrig=xPos-570+10;
      bossammokit.yPosOrig=380-190;
      bossammokit.render();

    }
    if(ammoKitCollectedCount>0){
      ammoKitCollectedCount--; 
    }

  }

  public void reset(){






    health=maxHealth;

    miniGunHealth1=maxMiniGunHealth;
    miniGunHealth2=maxMiniGunHealth;




    drawn=false;
    xStop=true;
    bossOn=false;
    dead=false;
    exploding=false;
    miniGun1Dead=false;
    miniGun2Dead=false;
    vulnerable=false;


    //mini gun
    miniXPos=xPos-25;
    miniYPos1=0;
    miniYPos2=0;

    rotXPos=xPos-52;
    rotYPos=150;
    rotGunAngle=0;
    //Counters


    miniGunCount=origMiniGunCount;


    mainGunCount=origmainGunCount;

    currentFill=0;
    animationShot=0;

    mainNumShot=20;

    expCount=-10;

  }
}


class nullBoss{
  float xPos=levelEnd-width;
  float yPos=0;
  boolean bossOn=false;


  public void render(){

    if(bossOn==true){
      text("SORRY, NO BOSS HERE :(",  levelEnd-width/2,50);
    }

    if(square.xPos>levelEnd-width+300){
      bossOn=true; 
    }
    //println(bossOn);


  }

  public void reset(){
    bossOn=false;



  }


}






class Brick{
  float xPos=0;
  float yPos=height;

  float squareYPos=square.yPos+square.yVel;
  float squareXPos=square.xPos+square.xVel;
  float Width=20;

  float rightside=xPos+Width/2+square.Width/2;
  float leftside=xPos-Width/2-square.Width/2;


  //y hits
  float hitTop=yPos-Width/2-square.Height/2;
  float hitBottom=yPos+Width/2+square.Height/2;
  //x hits

  //boolean
  boolean hit=false;
  boolean drawn=false;



  //graphic type
  int graphic=2;
  //functions
  public void render(){

    beingDrawn();
    if(drawn==true){
      //y hits update
      hitTop=yPos-Width/2-square.Height/2;
      hitBottom=yPos+Width/2+square.Height/2;
      // x hits update
      rightside=xPos+Width/2+square.Width/2;
      leftside=xPos-Width/2-square.Width/2;


      rectMode(CENTER);

      if(graphic==1){
        //rect(xPos,yPos,Width,Width);
        image(brick1,xPos,yPos+1);
      }
      else if (graphic==2){
        //rect(xPos,yPos,Width,Width);
        image(brick2,xPos,yPos+1);
      }
      else if (graphic==3){
        rect(xPos,yPos,Width,Width);
        //image(brick3,xPos,yPos+1);
      }


      fill(255);
      hit();
    }

  }



  public void hit(){

    if(square.xPos>xPos-Width/2-square.Width/2&&square.xPos<xPos+Width/2+square.Width/2&&square.yPos>=hitTop&&square.yPos<hitBottom){
      //Square Hit
      if (squareYPos+square.yVel<hitBottom&&abs(square.yVel)/square.yVel==-1){
        hit=true;
        square.yVel=0;
        square.yPos=hitBottom;


      } 
      else if (squareYPos+square.yVel>=hitTop){
        square.onGround=true;


        jump=false;
        hit=true;
        square.yPos=hitTop;
      }     
    }

    if(square.yPos>hitTop&&square.yPos<hitBottom){
      if(square.xPos+square.xVel<rightside&&square.xPos+square.xVel>leftside){

        if(square.xVel/abs(square.xVel)==1){
          square.xPos=leftside;
          square.xVel=0;  
          println("HIT LEFT"+HIT);
          HIT++;
        }
        //}else if(square.xVel/abs(square.xVel)==-1){
        else if(square.xVel < 0.0f){
          square.xPos=rightside;
          square.xVel=0;  
          println("HIT RIGHT"+HIT);
          HIT++;
        } 
      }
    }

    //Bullet Hit
    for (int i = 0; i<maxBullets; i++){
      if(bullets[i].xPos<xPos+Width/2+5 && bullets[i].xPos>xPos-Width/2-5 && bullets[i].yPos<yPos+Width/2 && bullets[i].yPos>yPos-Width/2){
        bullets[i].exploding=true; 
      }
    }

    //diveBomberHit

    if(divebomber.xPos<xPos+Width/2+5 && divebomber.xPos>xPos-Width/2-5 && divebomber.yPos<yPos+Width/2+10 && divebomber.yPos>yPos-Width/2-10){
      divebomber.destroyed=true; 
    }


  }




  public void beingDrawn(){
    if (xPos>abs(trans)-Width&&xPos<abs(trans)+width+Width){
      drawn=true; 
    }
  }



}



class Bullet{
  //Parameters
  float maxVel=15;
  float origWidth=4;
  float Width=origWidth;
  //Variables
  float xPos=0;
  float yPos=0;
  float bulAngle=0;
  float xVel=maxVel*cos(bulAngle);
  float yVel=maxVel*sin(bulAngle);
  float damage=1;

  //counters


  //booleans
  boolean rightBul=true;
  boolean leftBul=false;
  boolean upBul=false;
  boolean drawn=false;
  boolean exploding=false;
  boolean damaging=false;


  public void render(){
    xVel=maxVel*cos(bulAngle);
    yVel=maxVel*sin(bulAngle);
    if(drawn==true&&exploding==false){
      xPos+=xVel;
      yPos+=yVel;
    }
    stroke(0);
    fill(205);
    ellipse(xPos,yPos,Width,Width);

    fill(255,50);
    noStroke();

    ellipse(xPos,yPos,Width+3,Width+3);

    drawn();
    explode();



  }

  public void drawn(){
    if(xPos>abs(trans)+width||xPos<abs(trans)||yPos<0||yPos>height){
      drawn=false;
    }
    damaging=true;
  }



  int explodeCount=8;
  public void explode(){
    if(exploding==true&&explodeCount>0){
      Width+=3;
      explodeCount--;
      damaging=false;
    } 
    else if (explodeCount<=0){
      xPos=-10;
      yPos=-10;
      drawn=false;
      exploding=false;
      explodeCount=5;
      Width=origWidth; 
    }


  }
}












class EnemyBullet{
  //Parameters
  float maxVel=5;
  float origWidth=8;
  float Width=origWidth;
  float damage=1;
  //Variables
  float xPos=0;
  float yPos=0;
  float bulAngle=0;
  float xVel=maxVel*cos(bulAngle);
  float yVel=maxVel*sin(bulAngle);
  //booleans
  boolean drawn=false;

  public void render(){
    xVel=maxVel*cos(bulAngle);
    yVel=maxVel*sin(bulAngle);

    xPos+=xVel;
    yPos+=yVel;
    fill(255,150,150);
    stroke(2);
    stroke(255,0,0);
    ellipse(xPos,yPos,Width,Width);
    fill(255);
    drawn();
    squareHit();



  }

  public void drawn(){
    if(xPos>abs(trans)+width+10||xPos<abs(trans)-10||yPos<-10||yPos>height+10){
      drawn=false;
    }

  }

  public void squareHit(){
    if(xPos+Width/2>square.xPos-square.Width/2 && xPos-Width<square.xPos+square.Width/2 && yPos+Width>square.yPos-square.Width/2 && yPos-Width<square.yPos+Width/2&&drawn==true&&square.invinc==false){
      square.health-=square.bulletDamage;
      drawn=false;
      if(mechboss.bossOn==true){
        square.xVel=1*(xVel/abs(xVel));
      }
      square.hitCountBlink=square.maxHitCountBlink;
      square.invincCount=square.maxHitCountBlink;

    }

  }

}


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

  public void render(){
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


  public void dive(){
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

  public void explodes(){
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

  public void hitSquare(){
    if(yPos<square.yPos+square.Width/2&&yPos>square.yPos-square.Width/2&&xPos<square.xPos+square.Width/2&&xPos>square.xPos-square.Width/2){
      square.health-=3*square.bulletDamage;
      reset();
      square.hitCountBlink=square.maxHitCountBlink;
      square.invincCount=square.maxHitCountBlink;
    }

  }


  public void resetTimer(){
    if(xPos<abs(trans)&&timer==0||xPos>abs(trans)+width&&timer==0){
      offscreentimer--;
    }
    if(offscreentimer<=0){
      reset();
      //println("RESET");

    } 

  }

  public void reset(){
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

class nextLevel{


  public void run(){

    if(square.xPos>=levelEnd-10){
      levelBeaten=true;

    }
  }

  public void hardModeChoice(){
    if(level==0&&square.xPos<10){
      hardMode=true;
      level=1;
      square.health=10;
      square.yPos=250; 
      completereset();

    }
    else if (level==0&&square.xPos>width-10){
      hardMode=false;
      level=1;
      square.health=20;
      square.yPos=250; 
      completereset();
    }
  }
  public void levelbeaten(){



    if(levelBeaten==true){
      fill(0,100);
      rect(abs(trans)+width/2,height/2,width,height);
      textAlign(CENTER); 
      fill(255);
      text("You have completed LEVEL01\nPress SPACE to move on to LEVEL02",abs(trans)+width/2,height/2);
      textAlign(LEFT);
      inPlay=false;
    }
  }


  public void levelreset(){
    if(levelBeaten==true){
      if(level==0){
        level=1;
        completereset();
        square.yPos=200;
        inPlay=true;

      }
      else if(level==1){
        level=2;
        completereset();
        square.yPos=200;
        inPlay=true;
      } 
      else if (level==2){

      }

    }
  }

}

class CheckPoints{
  float currentCheckpoint=150;


  public void CPLevel1(){
  }
  public void CPLevel2(){
    println(currentCheckpoint);
    if(square.xPos>1915&&currentCheckpoint<1915){
      currentCheckpoint=1915; 
    } 
    else if(square.xPos>3654&&currentCheckpoint<3654){
      currentCheckpoint=3654; 
    } 
    else if (square.xPos>5691&&square.xPos<8250){
      currentCheckpoint=5691; 
    } 
    else if (square.xPos>8250){
      currentCheckpoint=square.xPos;
    }
  }
}



class AmmoKit{
  float xPosOrig=100;
  float yPosOrig=350;
  float xPos=100;
  float yPosBase=350;
  float yPos=0;

  float Width=10;
  float Height=14;
  boolean collected=false;


  public void render(){
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

  public void collected(){
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

  public void render(){
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


  public void collected(){
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

  public void render(){
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


  public void collected(){
    if(xPos+Width/2>square.xPos-square.Width/2 && xPos-Width/2<square.xPos+square.Width/2 && yPos+Width/2>square.yPos-square.Height/2 && yPos-Width/2<square.yPos+square.Height/2 && collected==false){
      collected=true;
      square.coins++;
    }
  }

}

class OneUP{
  
}


class Square{
  //PARAMETERS
  float Width=20;
  float origHeight=20;
  float Height=origHeight;
  float crouchHeight=Height/2;
  float maxVel=5;
  float grav=.5f;

  int maxHitCountBlink=6;
  int maxInvincCount=60;
  float bulletDamage=1;

  float jumpVel=10;
  int origJump=1;

  float slowRate=1.3f;

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
  public void render(){
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
  public void bounds(){
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
  public void keys(){
    //LEFT
    if(left==true&&crouch==false){
      if(xVel>=maxVel*-1){
        if(jump==false){
          xVel--;
        }
        else if (jump==true){
          xVel-=.5f;
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
          xVel+=.5f;
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
      if(left!=true&&right!=true&&abs(xVel)>.1f){
        xVel=xVel/slowRate;
      }
      else if (left!=true&&right!=true&&xVel<.1f){
        xVel=0;
      }
    }
  }

  //how to die
  public void die(){
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

  public void respawn(){
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







class Translate{
  float transRightBound=rightBound-300;
  float transLeftBound=leftBound+100;

  public void updateTrans(){
    transRightBound=rightBound-300;
    transLeftBound=leftBound+200;
    if (square.xPos>=transRightBound&&abs(square.xVel)/square.xVel==1&&-trans+width<=levelEnd){
      trans-=square.xVel; 
    }
    if (square.xPos<=transLeftBound&&abs(square.xVel)/square.xVel==-1&&-trans>=0){
      trans-=square.xVel;
    }
    if(trans>0){
      trans=0;
    }
    else if (trans<-levelEnd+width){
      trans=-levelEnd+width; 
    }




    if(mechboss.bossOn==true||nullboss.bossOn==true){
      trans=-levelEnd+width;
    }

  }
}




  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#EBE9ED", "project1" });
  }
}
