void setup(){
  size(400,400);
}
float sqCenterX=0;
float sqCenterY=0;
float multiFactor=.75;
void draw(){
  background (205);
  noFill();

  if (mousePressed && mouseButton==LEFT){
    sqCenterX=mouseX;
    sqCenterY=mouseY;
  }

  //parameters
  float centerX=width/2;
  float centerY=height/2;
  float topSqWid=100;
  float multiFDegrade=.005;

  //square attributes
  float sqUpY = sqCenterY-topSqWid/2;
  float sqDownY = sqCenterY+topSqWid/2;
  float sqLeftX= sqCenterX-topSqWid/2;
  float sqRightX= sqCenterX+topSqWid/2;

  rectMode(CENTER);

  //sq2 attributes
  float sq2posX= sqCenterX-(sqCenterX-centerX)*multiFactor;
  float sq2posY=sqCenterY-(sqCenterY-centerY)*multiFactor;
  float sq2Side=map(multiFactor,0,1 ,100,0);
  //sq2 corners
  float sq2UpY= sq2posY-sq2Side/2;
  float sq2DownY= sq2posY+sq2Side/2;
  float sq2LeftX= sq2posX-sq2Side/2;
  float sq2RightX= sq2posX+sq2Side/2;


  //square2
  if(mousePressed && mouseButton==RIGHT) { //&& multiFactor==1){
    multiFactor=0;
  }  
  if(multiFactor<1){
    rect(sq2posX,sq2posY, sq2Side,sq2Side);
    multiFactor+=multiFDegrade;
  }
  else if (multiFactor>=1){
    multiFactor=1;
  }

  //vectors
  line(sq2LeftX,sq2UpY, sqLeftX,sqUpY);
  line(sq2LeftX,sq2DownY, sqLeftX,sqDownY);
  line(sq2RightX,sq2UpY,sqRightX,sqUpY);
  line(sq2RightX,sq2DownY,sqRightX,sqDownY);
  rect(sqCenterX,sqCenterY,topSqWid,topSqWid);

  //line(centerX+10,

}

void mouseDragged() {
  // if (mousePressed && mouseButton==LEFT){
    sqCenterX=mouseX;
    sqCenterY=mouseY;
  //} 
}

/*void keyPressed(){
  if (key == 'a') {
  
  }
  if (key == 'b') {
  
  }  
}*/

