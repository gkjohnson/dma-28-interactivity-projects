PFont font1;

String enterArea="";


void setup(){
  size(400,400);
  font1=loadFont("ArialMT-20.vlw");
  textFont(font1);
}

void draw(){
  background(205);
  text(enterArea,100,100);
  
  
}

void keyPressed(){
 if (key!=ENTER && key!=RETURN && enterArea.length()<20&&key!=DELETE&&key!=BACKSPACE){
  enterArea=enterArea+key;
 }
 if ((key==DELETE||key==BACKSPACE)&&enterArea.length()>0){
  enterArea=enterArea.substring(0,enterArea.length()-1); 
 }
}
