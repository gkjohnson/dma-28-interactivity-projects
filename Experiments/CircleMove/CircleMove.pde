void setup(){
  size(500,500);
  smooth();
  noStroke(); 
}
float y=0;
float x=0;

void draw(){
  background(20);
  int c= ceil(random(0,255));
  fill(c);
  ellipse(x-25,250+y,50,50);
  fill(c,200);
  ellipse(x-25-10,250+y,50,50);
  fill(c,150);
  ellipse(x-25-20,250+y,50,50);
  fill(c,100);
  ellipse(x-25-30,250+y,50,50);
  fill(c,50);
  ellipse(x-25-40,250+y,50,50);
  x+=5;
  if(x>width+50){
    x=0;
  }
if(x>=230 && x<=270){
  ellipse(250,100,30,30);
}
if( x>3*width){
  x=0;
  y=0;
}
}
