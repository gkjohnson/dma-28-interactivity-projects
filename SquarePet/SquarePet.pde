// Pick up and throw the square high or hit him against the ground -- if it hits the ground with enoug velocity, it will take damage.
//Drop food for the square and run into the food in order to eat it. As the square eats more food, it will become bigger. Eating food
//will also add health if you hurt the square already.

// Controls:
// A: Move LEFT
// D: Move RIGHT
// W: JUMP
// LEFT CLICK on square: Pick square up
// RIGHT CLICK: Drop food


PFont font;            //define new font name
Pellet[] pellets;      // define new Pellet class array called pellets.
int currentPellet=0;   //set default current pellet number for array
int pelletCount=5;     //max number of pellets to be dropped

//SIZE DEPENDENT VARIABLES
float ground=0;       //define where line for ground will appear
float sqGround=0;     // boundry for square that takes into account square's width

//PARAMETERS
float gravity=.5;              //rate at which the square will fall
float originalSqWidth=10;      //sets minimum square width

float incVel=1;                //Rate at which the velocity will increase when moving left or right on the ground
float incVelSlow=incVel/8;     //Rate at which the velecity will increase when moving left or right in the air
float decFactor=1.1;           //"Friction" -- easing while on the ground to make square stop

float maxVel=5;                //max velocity that square can move at when not picked up

int maxJumps=2;                //number of times square can jump
float jumpVel=10;              //velocity upwards when jumping

float healthInc=.5;             //health points deducted when hurt
float healthDec=2;             //health points added when eating food
float maxHealth=20;            //Max amount of health square can have
float healthMeterLength=100;   //Max health bar meter length
float healthMeterHeight=10;    //health meter height


float maxThrowSpeed=40;        //speed at which square can be thrown in any direction (mouse must be moving VERY quickly in order to attain max speed)
float bounciness=.35;          //how much the square will bounce when it hits the ground
float painSpeed=20;            //velocity at which the square must be going to get hurt

float sunRadius=200;           //background 'suns' distance from the center of the ground
float sunWidth=70;             //'suns' diameter
float moonWidth=50;            //'moons' diameter
float sunTintFactor=2;         //how much the sun will blend into the background (fill divided by this)
float moonTintFactor=5;        //how much the moon will blend into the background (fill divided by this

//TIMES -- all will update in "Draw"
float s=0;                  //defines 'seconds' variable
String strS="empty";        //defines 'seconds' variable in string form
float m=0;                  //defines 'minutes' variable
String strM="empty";        //defines 'minutes' variable in string form
float h=0;                  //defines 'hours' variable
String strH="empty";        //defines 'hours' variable in string form
float currentTime=0;        //defines current time in seconds of the day
float sunAngle=0;           //gets sun's current position angle depending on the time of day

////SETUP////
void setup(){
  size(400,400);              //defines size to 400x400
  background(20);             //sets background color to dark gray
  smooth();                   //smooth

    ground=height-100;          //the ground is drawn 100 px about the bottom
  sqGround=ground-sqWidth/2;  //square's ground is half the width above the drawn ground (updates in draw with squares Width)
  leftBound+=0;               //adds zero to the left bound wall (updates in draw with squares width)
  rightBound+=width;          //adds the width the right bound wall (updates in draw with square's width)

  pellets=new Pellet[pelletCount];    //defines pellets as a new array capable of holding the max number of pellets

  for(int i =0; i<pelletCount;i++){   //creates all of the objects within the pellets array
    Pellet p=new Pellet();            //
    pellets[i]=p;                     //
  }                                   //

  font=loadFont("ArialMT-12.vlw");  //loads 12pt Sans Serif as "font"
  textFont(font);                     //sets "font" as default font

}
////GLOBAL VARIABLES////

//VARIABLES   (all update in draw)
float health=maxHealth;                   //sets health to max
float healthBarLength=map(health, 0, maxHealth, 0, healthMeterLength);  //sets bar length to max
float xPos=100;                           //sets dfault xpos to 100
float yPos=0;                             //sets default ypos to 100
float xVel=0;                             //sets default x veloicity to 0
float yVel=0;                             //sets default y velocity to 0
float sqWidth=0;                          //current square width
float leftBound=0;                        //where the left wall is
float rightBound=0;                       //where the right wall is
float dragDist=1;                         //how much square has been dragged when picked up


//COUNTERS
int jumpCount=0;    // how many jumps are left
int foodEaten=0;    //how much food has been eaten

//BOOLEANS
boolean pickedUp=false;    //true if square is picked up by mouse
boolean inAir=true;        //true if square is not on the ground
boolean died=false;        //true if health =0
boolean left=false;        //true if "A" is held
boolean right=false;       //true if "D" is held
boolean jump=false;        //true if "W" is held


////DRAW/////
void draw(){

  //UPDATE VARIABLES
  if(foodEaten<200){                     //updates sqWidth
    sqWidth=originalSqWidth+foodEaten;   //
  }                                      //

  sqGround=ground-sqWidth/2;
  leftBound=sqWidth/2;
  rightBound=-sqWidth/2+width;

  xPos+=xVel; // updates xposition variable by adding current Velocity
  yPos+=yVel; // updates yposition variable by adding current Velocity

  if(inAir==true&&pickedUp==false){     // If the square is in the air and it is not being held by the mouse, the yvelocity is gravity
    yVel+=gravity;                      //
  }                                     //

  if(abs(xVel)<.01){  // if the x velocity is less than .01, make it 0 (gets rid of infinite slowing down)
    xVel=0;           //
  }                   //

  if (inAir==false){      //if square is not in the air, reset jump count and set y velocity = to 0
    jumpCount=maxJumps;   //
    yVel=0;               //
  }                       //

  if (keyPressed==false&&inAir==false){    //"Friction" -- slows down square if on ground
    xVel=xVel/(decFactor);                 //
  }                                        //





  healthBarLength=map(health, 0, maxHealth, 0, healthMeterLength); //updates health bar length variable

  //update Times
  s=second();   // updates seconds
  m=minute();   // updates minutes
  h=hour();     // updates hours
  String strS=nf(second(),2);
  String strM=nf(minute(),2);
  String strH=nf(hour()%12,2);
  currentTime=h*60*60+m*60+s; // updates current time in seconds
  sunAngle=-map(currentTime, 0, 60*24*60, 0, 2*PI); // maps current time to an angle

  //BACKGROUND AND UI SETUP
  background(20); //BG Color


  sun();        //draw Sun

    rectMode(CORNER);     //draw ground
  stroke(40);           //
  fill(30);             //
  rect(-1, ground, width+1, height+1); //


  noStroke();      //draw health meter
  fill(100);       //
  rect(10,10,healthBarLength,healthMeterHeight); //


  stroke(150);           //draw health meter
  noFill();              //
  rect (10,10,healthMeterLength,healthMeterHeight);//

  noStroke();            //

  //TEXT
  fill(50);
  textAlign(LEFT);
  text("Health\nFood Eaten: " +nf(foodEaten,3),10,32);    //Health - Food Eaten

  textAlign(RIGHT);
  text("A/D  :\nW  :\nLEFT  :\nRIGHT  :",width-90,18);    //Controls

  textAlign(LEFT);
  String timeAMPM="NaN"; //defines timeAMPM
  if(h<12){              //updates timeAMPM by changing string based on time of day
    timeAMPM="AM";       //
  }                      //
  else if (h>=12){       //
    timeAMPM="PM";       //
  }                      //
  text("Left/Right \nJump\nPick up\nDrop food\n"+strH+":"+strM+" " + timeAMPM,width-70,18);     //What controls do and time







  ///BOUNDS///
  // hit the ground
  if(yPos==sqGround){
    if(yVel>6&&pickedUp!=true){
      if (yVel>painSpeed){
        health-=healthDec;
      }


      yVel=yVel*-1*bounciness;
      xVel=xVel*.5;


    } 
    else {
      inAir=false;
    }
  }
  else if(yPos>sqGround){
    yPos=sqGround;
    if(yVel>6&&pickedUp!=true){
      if (yVel>painSpeed){
        health-=healthDec;

      }


      yVel=yVel*-1*bounciness;
      xVel=xVel*.5;


    } 
    else {
      inAir=false;
    }
  }
  else if (yPos<sqGround){
    inAir=true;
  }

  //hits Right side of the screen
  if(xPos>rightBound){
    xPos=rightBound;
    xVel=xVel*-1;
  } // hits Left side of the screen
  else if (xPos<leftBound){
    xPos=leftBound;
    xVel=xVel*-1;
  }
  ///END BOUNDS///







  if(abs(xVel)>maxVel){               //checks if square is exceed max veloctity
    if(xVel/abs(xVel)==-1){           //
      xVel=-maxVel;                   //
    } 
    else if (xVel/abs(xVel)==1){    //
      xVel=maxVel;                    //
    }                                 //
  }                                   //


  //draw square
  square();
  if(died==false){
    keys();
    scaredSquare();
    dragDist=1;
  }



  //// UPDATE PELLETS////
  for(int i=0;i<pelletCount;i++){              //ques every pellet
    pellets[i].dropped();                      //runs dropped() function on every pellet


    if (pellets[currentPellet].dropped==1){    //if pellet is picked up
      currentPellet=currentPellet;             //currrent pellet is still current pellet
    }                                          //
    else if (pellets[i].dropped!=2){           //if current pellet is not on the ground
      currentPellet=i;                         //current pellet is the current qued pellet
    }                                          //
  }                                            //
  ////



  killedIt(); // checks if square is dead and displays end screen

}
////END DRAW////




float beforeExplode=1;
float explodeWidth=1;
float explodeOpa=1;
float deadX=0;
float deadY=0;


/////SQUARE/////
void square(){
  if(died==false){
  }
  else if (died==true&&explodeWidth<2){
    explodeWidth+=.05;
    explodeOpa-=.05;
  }


  rectMode(CENTER);
  noStroke();
  fill(255,255*explodeOpa);
  rect(xPos,yPos,sqWidth*explodeWidth,sqWidth*explodeWidth);

}


/////Picked Up Square////
void scaredSquare(){
  if (pickedUp==true){
    rectMode(CENTER);
    fill(255,random(50,150));
    rect(xPos+random(-5,5)*dragDist,yPos+random(-5,5)*dragDist,sqWidth,sqWidth); 
    rect(xPos+random(-5,5)*dragDist,yPos+random(-5,5)*dragDist,sqWidth,sqWidth); 

    xPos=mouseX+random(-5,5);
    yPos=mouseY+random(-5,5);

    if(mouseY<=sqGround){
      xVel=map(mouseX-pmouseX, 0,200, 0,maxThrowSpeed);
      yVel=map(mouseY-pmouseY, 0,200, 0,maxThrowSpeed);
    } 
    else if (mouseY>sqGround){
      if(yVel>painSpeed*.75){
        health-=healthDec;
        xVel=0;
        yVel=0;
      }
      else{
        xVel=0;
        yVel=0;
      }
    }
  }
}



//// "SUN" ////
void sun(){
  float sunX=sunRadius*sin(sunAngle);
  float sunY=sunRadius*cos(sunAngle);

  for(int i=0; i<3; i++){
    fill((100+30*i)/sunTintFactor);
    ellipse(sunX+width/2,sunY+ground,sunWidth+30-10*i,sunWidth+30-10*i);
  }

  fill(255/sunTintFactor);
  ellipse(sunX+width/2,sunY+ground,sunWidth,sunWidth);
  fill(255/moonTintFactor);
  ellipse(-sunX+width/2,-sunY+ground,moonWidth,moonWidth);
}



void killedIt(){
  if(health<0){            //make sure health does not go below 0 and checks if dead
    health=0;              //
    died=true;             //
  } 
  else if (health==0){     //
    died=true;             //
  }                        //

  fill(20,180);
  if(died==true){
    rectMode(CORNER);
    rect(0,0,width,height);
    fill(255);
    textAlign(CENTER);
    text ("You killed your square!!!\n It's okay, LEFT CLICK to get a new one!",width/2,height/2);
  }
}




void keys(){
  //LEFT
  if(left==true&&inAir==false){
    xVel-=incVel;
  } 
  else if (left==true && inAir==true&&xVel>-maxVel){
    xVel-=incVelSlow;
  }

  //RIGHT
  if(right==true&&inAir==false){
    xVel+=incVel;      
  }
  else if (right==true&& inAir==true&&xVel<maxVel){
    xVel+=incVelSlow;
  } 

  //JUMP
  if(jump==true&&jumpCount>0){    
    //yVel=-jumpVel;
    //inAir=true;
    //jumpCount--;
  }
}

////KEY PRESSES////
void keyPressed(){
  //LEFT
  if(key=='a'){
    left=true;
  }

  //RIGHT
  if(key=='d'){
    right=true;
  }

  //JUMP
  if(key=='w'&&jumpCount>0){    
    jump=true;
    yVel=-jumpVel;
    inAir=true;
    jumpCount--;
  }
}


void keyReleased(){
  if (key=='a'){
    left=false;
  }

  if(key=='d'){
    right=false;
  }

  if(key=='w'){
    jump=false;
  }
}

void mousePressed(){
  if (mousePressed&&mouseButton==LEFT&&abs(mouseX-xPos)<sqWidth/2&&abs(mouseY-yPos)<sqWidth&&died==false){
    pickedUp=true;
    jumpCount=0;
  }
  else if (mousePressed&&mouseButton==LEFT&&died==true){ //reset to default
    xPos=100;
    yPos=0;
    explodeOpa=beforeExplode;
    explodeWidth=beforeExplode;

    for(int i=0; i<pelletCount; i++){
      pellets[i].dropped=0; 
    }


    health=maxHealth;
    foodEaten=0;
    died=false;
  }
  else if(mouseButton==RIGHT&&pellets[currentPellet].dropped==0&&currentPellet<pelletCount&&pickedUp!=true){
    pellets[currentPellet].dropped=1;
  }
}




void mouseReleased(){
  if (mouseButton==LEFT&&pickedUp==true){
    pickedUp=false;
  }

  if (mouseButton==RIGHT&&pellets[currentPellet].dropped==1&&currentPellet<pelletCount&&died==false){
    pellets[currentPellet].dropped=2;
    pellets[currentPellet].x=mouseX;
    pellets[currentPellet].y=mouseY; 
  }
}


void mouseDragged(){
  dragDist= dist(mouseX,mouseY,pmouseX,pmouseY)/20+1;
}


