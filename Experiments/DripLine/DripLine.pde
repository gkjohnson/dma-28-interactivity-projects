
void setup() {
  smooth();
  size(600, 600);
}

float prevx=0;
float prevy=0;
void draw(){
  float press= mousePressed && mouseButton == LEFT ? 1 : 0; 
  
  frameRate(50*press+10);

  println(press);
  //background(255);
  fill(0);
  float randx = random(-20,20);
  float randy = random(-20,20);
  float circdist= sqrt(pow(randx,2)+pow(randy,2));
  float randcirc=map(circdist, 0,sqrt(800), 20,0);


  float currx= mouseX+press*(cos(randx)*randx);
  float curry= mouseY+press*(sin(randx)*randy);


  if(mousePressed==true && mouseButton==LEFT){
    ellipse(prevx,prevy,randx*pow(2*press,1),randx*pow(2*press,1));
    ellipse(width-prevx,prevy,randx*pow(2*press,1),randx*pow(2*press,1));
  }

  prevx=currx;
  prevy=curry;



}