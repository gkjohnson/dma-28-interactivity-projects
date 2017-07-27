void setup(){
  size(700,300); 



}
float charposx=0; // x position of character
float charposy=0; // y position of character
float fallRate=0; // fall rate
float posxAcc=0;
float posyAcc=0;

//parameters
float charaWid=10; // for character width
float accAm=5; // acceleration amount
float sloaccAm=.5; //
float jumpAcc=4; //jump acceleration amount
float maxspeed=6; // square's max speed
char leftKey='a';
char rightKey='d';
char jumpKey='w';
char stopKey='s';

float doubleJump=0;
int keyRelToZero=0;



void draw(){
  frameRate(60);
  background(205);
  float groundHeight=(height-height/10);
  line (0,groundHeight, width, groundHeight);


  //println(posxAcc);

  charposy=charposy + fallRate;
  charposx=charposx + posxAcc - posyAcc;

  //println(keyRelToZero);

  if(abs(keyRelToZero)==1 && charposy==groundHeight-charaWid-1){
    if(posxAcc/abs(posxAcc)==1  ){
      posxAcc-=.5;
    }
    if(posxAcc/abs(posxAcc)==-1)
    {
      posxAcc+=.5;    
    }
  } 
  else if (keyRelToZero==2 && charposy==groundHeight-charaWid-1){
    if(posxAcc/abs(posxAcc)==1  ){
      posxAcc-=.5;
    }
    if(posxAcc/abs(posxAcc)==-1)
    {
      posxAcc+=.5;    
    }
  }



  //boundries
  //Ground
  if(charposy<groundHeight-charaWid-1){
    fallRate+=.1;
  } 
  else if (charposy>groundHeight-charaWid){
    fallRate=0;
    charposy=groundHeight-charaWid-1;
    doubleJump=2;

  } 
  //Right wall
  if (charposx>=width-charaWid){
    posxAcc=0;
    charposx=width-charaWid;
  }
  //Left wall
  if (charposx<=0){
    posxAcc=0;
    charposx=0;
  }

  // draws rectangular character
  rect(charposx,charposy, charaWid,charaWid); 












}

void keyPressed(){
  float groundHeight=(height-height/10);
  // jump animation
  if (key==jumpKey && doubleJump>0 && charposy==groundHeight-charaWid-1){

    println("changed!!!");
    fallRate+=-jumpAcc;
    doubleJump--;

  } 
  else if (key==jumpKey && doubleJump>0 && charposy<groundHeight-charaWid){

    println("changed!!!");
    fallRate=-jumpAcc;
    doubleJump--;
  }

  // move right Key

  if (key==rightKey && posxAcc>=-maxspeed && posxAcc<=maxspeed-accAm &&charposx!=width-charaWid && charposy==groundHeight-charaWid-1){
    posxAcc+=accAm;
    keyRelToZero=0;
  } 
  else if (key==rightKey && posxAcc>=-maxspeed && posxAcc<=maxspeed &&charposx!=width-charaWid && charposy==groundHeight-charaWid-1){
    posxAcc=maxspeed;
    keyRelToZero=0;
  }
  else if (key==rightKey && charposy<groundHeight-charaWid-1 && posxAcc<maxspeed){
    posxAcc+=sloaccAm;
    keyRelToZero=0;
  }

  // move left Key
  if ( key==leftKey && posxAcc<=maxspeed && posxAcc>=-maxspeed+accAm &&charposx!=0 && charposy==groundHeight-charaWid-1){
    posxAcc-=accAm; 
    keyRelToZero=0;
  }
  else if (key==leftKey && posxAcc<=maxspeed && posxAcc<=maxspeed &&charposx!=width-charaWid && charposy==groundHeight-charaWid-1){
    posxAcc=-maxspeed;
    keyRelToZero=0;
  } 
  else if (key==leftKey && charposy<groundHeight-charaWid-1 &&posxAcc>-maxspeed){
    posxAcc-=sloaccAm;
    keyRelToZero=0;
  }



}

void keyReleased(){
  float groundHeight=(height-height/10);
  if (key==leftKey && charposy==groundHeight-charaWid-1){
    keyRelToZero=-1;
    println(keyRelToZero);

  } 
  else if (key==leftKey && charposy<groundHeight-charaWid-1){
    keyRelToZero=2;
  };

  if (key==rightKey && charposy==groundHeight-charaWid-1){

    keyRelToZero=1;
    println(keyRelToZero);

  } 
  else if (key==rightKey && charposy<groundHeight-charaWid-1){
    keyRelToZero=2;
  };
}










