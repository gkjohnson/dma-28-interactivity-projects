float grav=2.5;
float fric=.2;

PFont font;

Piece [] pieces;
int maxPieces=100;

Piece body,lArm1,lArm2,rArm1,rArm2,lLeg1,lLeg2,rLeg1,rLeg2;


boolean gravOn=true;

float headX=0;
float headY=0;
float headWidth=40;
float ground=400-10;
void setup(){
  size(400,400);

  pieces = new Piece[maxPieces];

  for(int i=0;i<maxPieces;i++){
    pieces[i]=new Piece(10); 
  }
  
  font= loadFont("ArialMT-10.vlw");
  
  textFont(font);


  body=new Piece(100); 
  lArm1=new Piece(50,mouseX-20,mouseX-20,-PI/40); 
  lArm2=new Piece(50); 
  rArm1=new Piece(50,mouseX-20,mouseX-20,PI/40); 
  rArm2=new Piece(50); 
  lLeg1=new Piece(60,-PI/30);     
  lLeg2=new Piece(60);     
  rLeg1=new Piece(60,PI/30);     
  rLeg2=new Piece(60); 

  noCursor();
  smooth();

}




void draw(){
  background(205);
//line(0,400,width,400);
fill(255);
  text("Controls:",260,12);
  text("G : Toggle Gravity\nCLICK : Random Pose",  280,24);
  
  //println(gravOn);
  body.physics();
  body.render(headX,headY);

  //line(headX-5*cos(body.angle+PI/2),headY-5*sin(body.angle+PI/2),headX+5*cos(body.angle+PI/2),headY+5*sin(body.angle+PI/2));

  lArm1.physics();
  lArm1.render(body.x1+5,body.y1+5);
  lArm2.physics();
  lArm2.render(lArm1.x2,lArm1.y2);

  rArm1.physics();
  rArm1.render(body.x1-5,body.y1+5);
  rArm2.physics();
  rArm2.render(rArm1.x2,rArm1.y2);

  rLeg1.physics();
  rLeg1.render(body.x2-2,body.y2);
  rLeg2.physics();
  rLeg2.render(rLeg1.x2,rLeg1.y2);

  lLeg1.physics();
  lLeg1.render(body.x2+2,body.y2);
  lLeg2.physics();
  lLeg2.render(lLeg1.x2,lLeg1.y2);

  pushMatrix();
  headX=mouseX;
  headY=mouseY;
  
  if(headY+headWidth/2-5>ground){
    headY=ground-headWidth/2+5;
  }
  
  translate(headX,headY);
  rotate(body.angle+PI);
  ellipse(-20,0,40,40);
  ellipse(-25,-8,5,5);
  ellipse(-25,8,5,5);
  line(-18,-14,-18,14);

  //spaz();
  popMatrix();
  /*for(int i=1;i<maxPieces;i++){
   
   pieces[i].physics();
   pieces[i].render(pieces[i-1].x2,pieces[i-1].y2);
   
   }*/

  //ellipse(pieces[maxPieces-1].x2,pieces[maxPieces-1].y2,25,25);
}

boolean clicked=false;

float v=0;
void spaz(){

  if (clicked==true){
    float lAngle=0+random(-PI/2,PI/2);
    float rAngle=PI+random(-PI/2,PI/2);
    lArm1.x2=lArm1.x1+lArm1.Length*cos(lAngle+random(-PI/2,PI/2));
    lArm1.y2=lArm1.y1+lArm1.Length*sin(lAngle+random(-PI/2,PI/2));
    lArm2.x2=lArm2.x1+lArm2.Length*cos(lAngle+random(-PI/2,PI/2));
    lArm2.y2=lArm2.y1+lArm2.Length*sin(lAngle+random(-PI/2,PI/2));


    rArm1.x2=rArm1.x1+rArm1.Length*cos(rAngle+random(-PI/2,PI/2));
    rArm1.y2=rArm1.y1+rArm1.Length*sin(rAngle+random(-PI/2,PI/2));
    rArm2.x2=rArm2.x1+rArm2.Length*cos(rAngle+random(-PI/2,PI/2));
    rArm2.y2=rArm2.y1+rArm2.Length*sin(rAngle+random(-PI/2,PI/2));


    rLeg1.x2=rLeg1.x1+rLeg1.Length*cos(rAngle+random(-PI/2,PI/2));
    rLeg1.y2=rLeg1.y1+rLeg1.Length*sin(rAngle+random(-PI/2,PI/2));
    rLeg2.x2=rLeg2.x1+rLeg2.Length*cos(rAngle+random(-PI/2,PI/2));
    rLeg2.y2=rLeg2.y1+rLeg2.Length*sin(rAngle+random(-PI/2,PI/2));

    lLeg1.x2=lLeg1.x1+lLeg1.Length*cos(lAngle+random(-PI/2,PI/2));
    lLeg1.y2=lLeg1.y1+lLeg1.Length*sin(lAngle+random(-PI/2,PI/2));
    lLeg2.x2=lLeg2.x1+lLeg2.Length*cos(lAngle+random(-PI/2,PI/2));
    lLeg2.y2=lLeg2.y1+lLeg2.Length*sin(lAngle+random(-PI/2,PI/2));

    v+=.1;

  }
}

void mousePressed(){
  if(mousePressed){
    clicked=true;

    rLeg1.angle=0;

    grav=0;

    //println("CLICKED");

  }
}


void mouseReleased(){
  if(mouseButton==LEFT||mouseButton==RIGHT){
    clicked=true;
    if(gravOn==true){ 
      grav=2;
    } 
  }
  spaz();
}



void keyReleased(){
  if(key=='g'){
    if(gravOn==true){
      gravOn=false;
      grav=0;
    }
    else{
      gravOn=true;
      grav=2;
    }
  } 
}

