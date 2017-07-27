class Dog{
  float x;
  float y;
  float angle=0;
  void render(){
    x=mouseX;
    y=mouseY;
    getAngle();
          fill(175);
pushMatrix();{
   translate(x,y);
  rotate(angle);

    ellipse(0,0,12,9);
    ellipse(5,0,7,7);
}popMatrix();
fill(255);
  }
  
  void getAngle(){
    if(dist(mouseX,mouseY,pmouseX,pmouseY)!=0){
      angle=atan2(mouseY-pmouseY,mouseX-pmouseX);
    }
    
  }
  
  
  
  
}
