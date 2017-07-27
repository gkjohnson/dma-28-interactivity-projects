void setup(){
  smooth();
  size(600,600);
}
float prevx=0;
float prevy=0;
  
void draw(){
  //background(255);
  fill(0);
  float randx = random(-20,20);
  float randy = random(-20,20);
  
 
  float currx= mouseX+(cos(randx)*randx);
  float curry= mouseY+(sin(randx)*randy);
  
  
  if(mousePressed==true && mouseButton==LEFT){
    line(prevx,prevy,currx,curry);
  }

  prevx=currx;
  prevy=curry;
}