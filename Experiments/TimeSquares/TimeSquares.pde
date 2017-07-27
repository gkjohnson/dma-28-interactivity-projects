PFont font;

void setup(){
  size (300,100);
  background(0);
  font = loadFont("ArabicTransparent-7.vlw");
  textFont(font);
}
int lastSecond=0;

void draw(){
  rectMode(CENTER);

  String s=nf(second(),2);
  float s2=second();
  String m=nf(minute(),2);
  float m2=minute();
  String h=nf(hour()%12,2);
  float h2=hour();

  if(s2!=0){
    background(0);
  } 
  else if (s2==0){
    fill(0,30);
    rect(width/2,height/2,width,height);
  }
  fill(255);
  timeBars(m2,m,width/60+1);
  timeBars(h2,h,width/30+2);
  timeBars(s2,s,0);
}

void timeBars(float t, String t2, float d){
  for (int i=0; i<t; i++){
    noStroke();
    rect((width/60)*(i+.5),d+ width/60,width/60 -1,width/60-1);
    textFont(font);
    if(i>=t-1){
      text(t2, (width/60)*(i+1)+1,d+width/60+2);
    }
  }
}