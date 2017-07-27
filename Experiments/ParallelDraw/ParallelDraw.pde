void setup(){
  size(500,500);
  strokeWeight(3);
  //smooth();
  frameRate(100);
  smooth();
}

float prvx=0;
float prvy=0;
float prvInvx=0;
float prvInvy=0;
float paradist=10;
void draw(){
  //println((-mouseX+pmouseX)+"=y," + (mouseY-pmouseY)+"=x"); // prints




  float magn=sqrt(pow(-mouseX+pmouseX,2)+pow(mouseY-pmouseY,2));

  if(abs(magn) >2){
    float invyslope=-mouseX+pmouseX;
    float invxslope=mouseY-pmouseY;
    float currx=invxslope*paradist/magn+mouseX; //currentx
    float curry=invyslope*paradist/magn+mouseY; //currenty
    float currInvx=-invxslope*paradist/magn+mouseX; //currentx
    float currInvy=-invyslope*paradist/magn+mouseY; //currenty

    println(magn);



    if (mousePressed && mouseButton==LEFT){
      //line(invxslope*paradist/magn+mouseX,invyslope*paradist/magn+mouseY,-invxslope*paradist/magn+mouseX,-invyslope*paradist/magn+mouseY)

      line (currx,curry,prvx,prvy);
      line (currInvx,currInvy,prvInvx,prvInvy);
    } 
    prvx=currx;
    prvy=curry;
    prvInvx=currInvx;
    prvInvy=currInvy;
  }
  if (mousePressed && mouseButton==RIGHT){
    paradist=0;
    background(205);
  }

}

void mouseReleased(){
 //paradist=0 ;
}


