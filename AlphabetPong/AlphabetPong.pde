/*
Controls:
Mouse           - Move paddle up and down
SPACE           - Launch Ball
R                - Reset Ball
E               - Easy mode toggle
I               - Infinite play mode toggle
+ (in infplay)  - Velocity +1
- (in infplay)  - Velocity -1
B (after win)   - Bullet Time mode toggle
W               - Obligitory 'automatic win' button
*/





PFont pointsfont;
PFont lettersfont;

void setup(){
  size(400,400);
  pointsfont = loadFont("ArialMT-12.vlw");
  lettersfont = loadFont("Arial-BoldMT-60.vlw");
  smooth();
}

float frameCenterx=20;
float frameCentery=20;

//parameters
float overallVel=20;
float ballWidth=10;
float initVel=20;
float easyVel=1;
float bulletTimeVel=1;
int initialLaunchCounter=90;
float bulletTimeX=60;


//Paddle Attributes
float paddleXPos=10;
float paddleYPos=mouseY;
float paddleWidth=8;
float paddleTop=-27+mouseY;
float paddleBottom=27+mouseY;


//Ball Attributes
float ballPosX= frameCenterx;
float ballPosY= frameCentery;
float ballBoundUp= ballPosY-ballWidth/2;
float ballBoundDown= ballPosY+ballWidth/2;
float ballBoundLeft= ballPosX-ballWidth/2;
float ballBoundRight= ballPosX+ballWidth/2;

//L
int launchCounter=90;

//Saved Angles
float angle=0;
float angleSinY=0;
float angleCosX=0;

// Losses
float points=0;

//Ball Velocity
float xVel=0;
float yVel=0;

boolean inPlay=false;
boolean youWon=false;
boolean easyMode=false;
boolean bulletMode=false;
boolean wonOnce=false;
boolean infinitePlay=false;

//Letter Booleans hit/nothit
boolean bolA=false;
boolean bolB=false;
boolean bolC=false;
boolean bolD=false;
boolean bolE=false;

String easyOn= "Off";
String bulletOn= "Off";
//

void draw(){

  //Random angle generation
  angle=random(PI/2+.4, (3*PI)/2-.4);
  angleSinY=sin(angle);
  angleCosX=cos(angle);

  frameCenterx=width/2;
  frameCentery=height/2;
  int textPosX=width/2+10;
  int textPosY=20;

  if(youWon!=true){
    paddleYPos=mouseY; 
  }

  //Update Bounding Box
  ballBoundUp= ballPosY-ballWidth/2;
  ballBoundDown= ballPosY+ballWidth/2;
  ballBoundLeft= ballPosX-ballWidth/2;
  ballBoundRight= ballPosX+ballWidth/2;

  //updatePaddle
  paddleTop=-27+paddleYPos;
  paddleBottom=27+paddleYPos;

  //playing Field
  if(wonOnce==false || bulletMode==false || ballPosX>bulletTimeX ){
    
    background(20);

  } 
  else if (wonOnce==true&&bulletMode==true&&ballPosX<bulletTimeX){
    fill(20,25);
    noStroke();
    rect(frameCenterx,frameCentery,width, height);
    stroke(255);
    fill(255);
  }
  textAlign(LEFT);
  textFont(pointsfont,12);
  text("Losses: " + ceil(points),textPosX,textPosY);
  fill(50);
  if(inPlay==false){
    if (easyMode==false){// check if easy mode is on
      easyOn="Off";
    }
    else if (easyMode==true){
      easyOn="On";
    }
    if (bulletMode==false){// check if bullet mode is on
      bulletOn="Off";
    } 
    else if (bulletMode==true){
      bulletOn="On"; 
    }
    if (wonOnce==false){//check if okay to display bulletMode
      text("SPACE : Launch Ball\n E : Easy Mode Toggle -- "+easyOn+" \n R : Reset Ball", 10, height-40);
    } 
    else if (wonOnce==true){
      text("SPACE : Launch Ball\n E : Easy Mode Toggle -- "+easyOn+" \n B : Bullet Mode Toggle -- "+bulletOn+" \n R : Reset Ball", 10, height-60);
    }
  }
  fill(20);
  stroke(255);
  strokeWeight(1);
  line(frameCenterx,0, frameCentery,height);
  ellipse(frameCenterx, frameCentery, ballWidth*1.8, ballWidth*1.8);

  if (inPlay==false){
    ballPosX=frameCenterx;
    ballPosY=frameCentery;
  } 
  else if (inPlay==true){
    ballPosX+=xVel;
    ballPosY+=yVel;
  }

  fill(255);

  //Launch Ball from Center with LaunchCounter
  /*if(launchCounter>0){
   ballPosX=frameCenterx;
   ballPosY=frameCentery;
   launchCounter--;
   //println(launchCounter);
   } 
   else if (launchCounter==0){
   ballPosX+=xVel;
   ballPosY+=yVel;
   
   }
   if (launchCounter==1){
   xVel=overallVel*angleCosX;
   yVel=overallVel*angleSinY;
   }
   */


  //Bullet Time

  if (bulletMode==true && ballPosX>bulletTimeX && sqrt(pow(xVel,2)+pow(yVel,2))<=2){
    xVel=xVel*initVel;
    yVel=yVel*initVel;
    overallVel=initVel;
    println("right");
  } 
  else if (bulletMode==true && ballPosX<bulletTimeX && sqrt(pow(xVel,2)+pow(yVel,2))>=19){
    xVel=xVel/initVel;
    yVel=yVel/initVel;
    overallVel=bulletTimeVel;
    println("left");
  }
  //Top Boundry
  if (ballBoundUp<=0){
    ballPosY=ballWidth/2+1;
    yVel=-1*yVel; 
  }
  //Bottom Boundry
  if (ballBoundDown>=height){
    ballPosY=height-ballWidth/2-1;
    yVel=-1*yVel; 
  }
  //Left Boundtry
  if (ballBoundRight<=0){
    launchCounter=90;
    points++;
    //println(points);
    ballPosX=width/2;
    ballPosY=height/2;
    inPlay=false;
  }
  //Right Boundry
  if (ballBoundRight>=width){
    ballPosX=width-ballWidth/2-1;
    xVel=-1*xVel; 
  }
  //Paddle Boundry
  float deltaY = map(overallVel-abs(yVel), 0,overallVel, 0,overallVel/2);



  if (ballBoundLeft<=paddleXPos+(overallVel+1)/2+paddleWidth/2 && ballBoundLeft>=paddleXPos-(overallVel+1)/2+paddleWidth/2 && ballPosY>paddleTop+10 && ballPosY<paddleBottom-10){
    xVel=-1*xVel;
    ballPosX=paddleXPos+(overallVel+1)/2+paddleWidth/2+ballWidth/2+1;
  } //Top Boundry
  else if(ballBoundLeft<=paddleXPos+(overallVel+1)/2+paddleWidth/2 && ballBoundLeft>=paddleXPos-(overallVel+1)/2+paddleWidth/2 && ballPosY>paddleTop-20 && ballPosY<paddleTop+10){
   ballPosX=paddleXPos+(overallVel+1)/2+paddleWidth/2+ballWidth/2+1;
    println("bottombound");
    println(xVel + "  ,  " + yVel);
    println(deltaY);

    yVel= -1*(abs(yVel)+deltaY);
    xVel= sqrt(pow(overallVel,2)-pow(abs(yVel),2));


    println(xVel + "  ,  " + yVel);
  } //Bottom Boundry
  else if(ballBoundLeft<=paddleXPos+(overallVel+1)/2+paddleWidth/2 && ballBoundLeft>=paddleXPos-(overallVel+1)/2+paddleWidth/2 && ballPosY>paddleBottom-10 && ballPosY<paddleBottom+20){
        ballPosX=paddleXPos+(overallVel+1)/2+paddleWidth/2+ballWidth/2+1;
    println("bottombound");
    println(xVel + "  ,  " + yVel);
    println(deltaY);
    yVel= (abs(yVel)+deltaY);
    xVel= sqrt(pow(overallVel,2)-pow(abs(yVel),2));


    println(xVel + "  ,  " + yVel);
  }




  //Draw Letters
 if(infinitePlay==false){ fill(20);
  rect(width-50, height/2, 75, height);

  A(width-50, (height/5)-15);
  B(width-50, 2*(height/5)-15);
  C(width-50, 3*(height/5)-15);
  D(width-50, 4*(height/5)-15);
  E(width-50, 5*(height/5)-15);
  //line
  line(width-50-40,0, width-50-40,height);
  //draw boxes around letters
  for (int i=5; i>0; i-=1){
    stroke(255);
    noFill();
    rectMode(CENTER);
    rect (width-50, (6-i)*(height/5)-height/10, 75, (height/5)-2);
  }
 }
  // Draw ball and Paddle
  fill(255);
  ball(ballPosX,ballPosY,ballWidth);
  paddle(paddleXPos,paddleYPos,paddleTop,paddleBottom);
  youWon(frameCenterx, frameCentery);

} 
//paddle draw function
void paddle(float x, float y, float ptop, float pbot){
  noStroke();
  quad(0+x,-35+y, paddleWidth+x,ptop, paddleWidth+x,pbot, 0+x,35+y);
  stroke(255);
  line(x-2,-35+y, x-2, 35+y);
  line(x-4,-35+y, x-4, 35+y);
}
//ball draw function
void ball(float x,float y, float d){

    fill(255);
  noStroke();
  ellipse(x,y, d,d); }
//key release function
void keyReleased(){
  if (key==' ' && inPlay==false && youWon==false){
    xVel=overallVel*angleCosX;
    yVel=overallVel*angleSinY;
    ballPosX+=xVel;
    ballPosY+=yVel;
    inPlay=true;
  } 
  else if(key==' ' && youWon==true){
    youWon=false;
    inPlay=false;
    bolA=false;
    bolB=false;
    bolC=false;
    bolD=false;
    bolE=false;
    points=0;
    background(20);
  }
  if (key=='e'&& easyMode==false &&youWon==false&&inPlay==false){
    overallVel=easyVel;

    easyMode=true;
    if(bulletMode==true){
      bulletMode=false;

    }
  } 
  else if (key=='e'&& easyMode==true &&youWon==false&&inPlay==false){
    overallVel=initVel;

    easyMode=false;
  }

  if (key=='r'&&inPlay==true &&youWon==false){
    inPlay=false;
    background(255);
  }

  if(key=='b' && bulletMode==false && youWon==false && wonOnce==true&&inPlay==false){
    bulletMode=true;
    if (easyMode==true){
      easyMode=false;
    }
  } 
  else if (key=='b' && bulletMode==true && youWon==false && wonOnce==true&&inPlay==false){
    bulletMode=false;

    xVel=xVel*20;
    yVel=yVel*20;

  }
  if (key=='w'){
    wonOnce=true;
  }
  if (key=='i' && infinitePlay==false && inPlay==false){
    infinitePlay=true;
  } else if (key=='i' && infinitePlay==true){
    infinitePlay=false;
    if(easyMode==false){
    overallVel=initVel;
    } else if (easyMode==true){
      overallVel=easyVel;
    }
  }
  
  if (key=='-' && infinitePlay==true && inPlay==false){
   overallVel--; 
   println(overallVel);
  }
  if (key=='=' && infinitePlay==true){
    overallVel++;
    println(overallVel);
  }
}

//Letter Functions
void A(float x,float y){
  if (bolA==true){
    fill(255,50);
  } 
  else if (bolA==false){
    fill(255);
    if(ballPosY>0&&ballPosY<(height/5)&&ballPosX>x-50){
      bolA=true;
      inPlay=false;

    }
  }

  textAlign(CENTER);
  textFont(lettersfont);
  text("A",x,y);


  fill(255);
}
void B(float x,float y){
  if (bolB==true){
    fill(255,50);
  } 
  else if (bolB==false){
    if(ballPosY>(height/5)&&ballPosY<y+15&&ballPosX>x-50){
      bolB=true;
      inPlay=false;
    }
  }
  textAlign(CENTER);
  textFont(lettersfont);
  text("B",x,y);
  fill(255);
}
void C(float x,float y){
  if (bolC==true){
    fill(255,50);
  } 
  else if (bolC==false){
    if(ballPosY>2*(height/5)&&ballPosY<y+15&&ballPosX>x-50){
      bolC=true;
      inPlay=false;
    }
  }
  textAlign(CENTER);
  textFont(lettersfont);
  text("C",x,y);
  fill(255);
}
void D(float x,float y){
  if (bolD==true){
    fill(255,50);
  } 
  else if (bolD==false){
    if(ballPosY>3*(height/5)&&ballPosY<y+15&&ballPosX>x-50){
      bolD=true;
      inPlay=false;
    }
  }
  textAlign(CENTER);
  textFont(lettersfont);
  text("D",x,y);
  fill(255);
}
void E(float x,float y){
  if (bolE==true){
    fill(255,50);
  } 
  else if (bolE==false){
    if(ballPosY>4*(height/5)&&ballPosY<y+15&&ballPosX>x-50){
      bolE=true;
      inPlay=false;
    }
  }
  textAlign(CENTER);
  textFont(lettersfont);
  text("E",x,y);
  fill(255);
}

void youWon(float x,float y){
  if(bolA==true&&bolB==true&&bolC==true&&bolD==true&&bolE==true&&youWon==false){
    youWon=true;
  }
  else if (bolA==true&&bolB==true&&bolC==true&&bolD==true&&bolE==true&&youWon==true){
    noStroke();
    fill(20,200);

    rect(frameCenterx,frameCentery,width,height);
    fill(255);
    textAlign(CENTER);
    textFont(lettersfont);
    text("You Won!\n",x,y-20);
    textFont(lettersfont,30);
    if(points==0){
      text("And you lost "+ ceil(points) + " times!!!",x,y+20);
      textFont(pointsfont);
      text("You unlocked Bullet Time!",x,y+70);
      wonOnce=true;
    } 
    else if(points<=8){
      text("And you only lost "+ ceil(points) + " times!",x,y+20);
      textFont(pointsfont);
      text("You unlocked Bullet Time!",x,y+70);
      wonOnce=true;
    } 
    else if(points>8){
      text("But you lost "+ ceil(points) + " times...",x,y+20);
      textFont(pointsfont);
      text("Beat it in under 8 losses to unlock Bullet Time",x,y+70);

    }
    textFont(pointsfont);
    text("Press SPACE to restart",x,y+95);
  }
}










