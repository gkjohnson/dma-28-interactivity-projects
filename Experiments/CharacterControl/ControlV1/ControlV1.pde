void setup(){
  size(100,100); 



}
float charposx=0; // x position of character
float charposy=0; // y position of character
float fallRate=0; // fall rate
float posxAcc=0;
float posyAcc=0;

//parameters
float charaWid=10; // for character width
float accAm=.5; // acceleration amount
float sloaccAm=accAm; //
float jumpAcc=4; //jump acceleration amount
float maxspeed=5; // square's max speed
char leftKey='a';
char rightKey='d';
char jumpKey='w';
char stopKey='s';






void draw(){
  frameRate(60);
  background(205);
  float groundHeight=(height-height/10);
  line (0,groundHeight, width, groundHeight);


  println(posxAcc);

  charposy=charposy + fallRate;
  charposx=charposx + posxAcc - posyAcc;


  //boundries
  //Ground
  if(charposy<groundHeight-charaWid-1){
    fallRate+=.1;
  } 
  else if (charposy>groundHeight-charaWid){
    fallRate=0;
    charposy=groundHeight-charaWid-1;

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

  // jump animation
  if (keyPressed && key==jumpKey && charposy==groundHeight-charaWid-1){
    fallRate+=-jumpAcc;
  }

  // move right animation
  if (keyPressed && key==rightKey && posxAcc>=-maxspeed && posxAcc<=maxspeed-accAm &&charposx!=width-charaWid){
    posxAcc+=accAm;
  } 

  // move left animation
  if (keyPressed && key==leftKey && posxAcc<=maxspeed && posxAcc>=-maxspeed+accAm &&charposx!=0){
    posxAcc-=accAm; 
  }
  //stop animation
  if (keyPressed && key==stopKey && abs(posxAcc)>0){
    posxAcc-= (posxAcc/(abs(posxAcc)))*sloaccAm;
  }
  
  
  



}









