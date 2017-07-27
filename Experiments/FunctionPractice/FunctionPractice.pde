void setup(){
  size(600,600);
  rectMode(CENTER);
  noCursor();
}
void draw(){
  background(205);
  myShape(mouseX,mouseY, 10);

}
void myShape(float x, float y, float s){
  rect(x,y,s*2,s*2);
  ellipse(x,y,s*1,s*1);
}

