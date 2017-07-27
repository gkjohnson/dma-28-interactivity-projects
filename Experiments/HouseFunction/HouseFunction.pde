// House function includes four parameters:
// x position of house
// y position of house
// house width
// house's roof height





void setup(){
  size(400,400);
}

void draw(){
  background(205);
  house(10,20,100,10);
  house(150,20,50,0);
  house(290,20,60,15);  
  house(10,150,50,40);  
  house(100,150,150,-50);  
  house(350,150,24,4);
  house(10,290,80,-8);
  house(120,290,130,30);
  house(290,290,60,100);
}

void house(float xpos,float ypos,float Width,float roofHeight){
  rect(xpos+Width/10,ypos,Width/5,-roofHeight);

  rect(xpos,ypos,Width,100);
  triangle(xpos, ypos, xpos+Width,ypos, xpos+Width/2, ypos-roofHeight);
  rect(xpos+Width/2-Width/10,ypos+100,Width/5,-50);

  for (int i=0; i<3;i++){
    rectMode(CENTER);
    rect(xpos+Width/4*(i+1),ypos+25, Width/10,30);
    rectMode(CORNER);
  }
  rectMode(CENTER);
  rect(xpos+Width/4,ypos+65, Width/5,Width/5);
  rectMode(CORNER);
  rect(xpos+Width, ypos+30,Width/5,70);
  triangle(xpos+Width, ypos+30, xpos+Width+Width/5, ypos+30, xpos+Width, ypos+30-roofHeight/2);
}


