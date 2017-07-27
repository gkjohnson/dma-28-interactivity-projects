// Compatible with Wacom Tablet or Mouse
// Pressure sensitive



void setup() {
  smooth();
  size(400, 400);


  noStroke();


}
float prevx=0;
float prevy=0;


void draw(){
  fill(15,200);
  
  float press= mousePressed ? 1 : 0;
  if (press==0){
    press=.7;}


  frameRate(50*press+10);


  //background(255);
  float randx = random(-20,20);
  float randy = random(-20,20);
  float circdist= sqrt(pow(randx,2)+pow(randy,2));
  float randcirc=map(circdist, 0,sqrt(800), 20,0);


  float currx= mouseX+press*(cos(randx)*randx);
  float curry= mouseY+press*(sin(randx)*randy);

  if(mousePressed && mouseButton==LEFT){
    ellipse(prevx,prevy,randx*pow(2*press,1),randx*pow(2*press,1));
    ellipse(width-prevx,prevy,randx*pow(2*press,1),randx*pow(2*press,1));
  } 
  else if (mousePressed&& mouseButton==RIGHT){
    fill(205,200);
    ellipse(prevx,prevy,randx*pow(2*press,1),randx*pow(2*press,1));
    ellipse(width-prevx,prevy,randx*pow(2*press,1),randx*pow(2*press,1));
  }

  prevx=currx;
  prevy=curry;



}

void keyReleased(){
 if(key==' '){
  background (205);
 } 
}