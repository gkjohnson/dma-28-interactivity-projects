import processing.core.*; 
import processing.xml.*; 

import java.applet.*; 
import java.awt.*; 
import java.awt.image.*; 
import java.awt.event.*; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class musicsketch2 extends PApplet {
  public void setup() {//Garrett Johnson
//Song:
//Tenacious D - FriendShip

size(400,400);
background(20);
smooth();
noStroke();
/*The ellipses in the background represent
 the constant and subtly varying guitar strum
 in the background
 */
for(int x=5; x<400; x+=10){
  for(int y=5; y<400 ; y+=10){
    float rand=ceil(random(2,7));
    fill(rand*10);
    ellipse(x,y, 5,5);
    if (x>100){
      noStroke();
      fill(255,(x-200)/2);
      ellipse(x,y, 5,5);
    }
  }
}
//End bg ellipses
/*The concentric circles on the left side 
 of the screen represent the bassdrum hits
 and/or snair drum hits in the background
 of the song -- beginning strong and fading
 outward
 */
noFill();
for (int i=0; i<5 ; i+=1){
  strokeWeight(5);
  stroke(255, (5-i)*15);
  int x=55;
  int y=325;
  ellipse(x,y-i*5,20*i,20*i);
}
for (int i=0; i<3 ; i+=1){
  strokeWeight(5);
  stroke(255, (5-i)*15);
  int x=55;
  int y=325;
  ellipse(x,y-i*5,20*i,20*i);
}

for (int i=0; i<10 ; i+=1){
  strokeWeight(5);
  stroke(255, (10-i)*10);
  int x=125;
  int y=255;
  ellipse(x,y-i*5,20*i,20*i);
}
for (int i=0; i<4 ; i+=1){
  strokeWeight(5);
  stroke(255, (8-i)*10);
  int x=125;
  int y=255;
  ellipse(x,y-i*5,20*i,20*i);
}
for (int i=0; i<2 ; i+=1){
  strokeWeight(5);
  stroke(255, (8-i)*10);
  int x=125;
  int y=255;
  ellipse(x,y-i*5,20*i,20*i);
}
for (int i=0; i<6 ; i+=1){
  strokeWeight(5);
  stroke(255, (6-i)*10);
  int x=105;
  int y=65;
  ellipse(x,y-i*5,20*i,20*i);

}
for (int i=0; i<3 ; i+=1){
  strokeWeight(5);
  stroke(255, (4-i)*15);
  int x=105;
  int y=65;
  ellipse(x,y-i*5,20*i,20*i);

}
//End concentric ellipses
/*The vertical lines represent the 
 smoother vocalsby Jack Black in the 
 beginning of the song
 */
for(int i=0; i<400; i+=1){
  fill(255);
  int x=170;
  println(i%3);
  int mod=i%3;
  rectMode(CENTER);
  rect (x,i, mod*1.5f,1);
}
for(int i=0; i<400; i+=1){
  fill(255);
  int x=170;
  float mod=sin(30*i);
  rectMode(CENTER);
  rect (x,i, mod*5,1);
}

for(int i=0; i<400; i+=1){
  fill(255);
  int x=150;
  float mod=sin(30*i);
  rectMode(CENTER);
  rect (x,i, mod*2,1);
}

for(int i=0; i<400; i+=1){
  fill(255);
  int x=360;
  float mod=sin(30*i);
  rectMode(CENTER);
  rect (x,i, mod*2,1);
}
for(int i=0; i<400; i+=1){
  noStroke();
  fill(255,80);
  int x=325;
  float mod=sin(30*i);
  rectMode(CENTER);
  rect (x,i, mod*6,1);
}

for(int i=0; i<400; i+=1){

  int x=100;
  float mod=sin(i);
  rectMode(CENTER);
  fill(255, 255-i/1.5f);
  rect (x,i, mod*15,1);
}

for(int i=0; i<400; i+=1){

  int x=100;
  float mod=sin(i);
  rectMode(CENTER);
  fill(255, 255-i/1.5f);
  rect (x,i, mod*i/10,1);
}

//End vocal chord lines
/*The circles near the bottom represent
the more vigorous and guitar strums and
vocals near the end of the song
 */
stroke(255);
strokeWeight(4);
fill(255,10);
ellipse(390,400, 40,40);
ellipse(400,375, 150,150);
stroke(255,200);
ellipse(400,300, 100,100);
stroke(255,150);
ellipse(370,370, 250,250);
stroke(255,100);
ellipse(270,270, 100,100);
stroke(255,50);
ellipse(260,310, 50,50);
ellipse (350,200, 40,40);
stroke(255,30);
ellipse (280,80,  60,60);
ellipse (200,230,  40,40);
stroke(255,80);
ellipse (170,430,  300,300);
stroke(255,30);
ellipse (50,310,  150,150);
ellipse (120,150,  80,80);
//end circles


  noLoop();
} 
  static public void main(String args[]) {
    PApplet.main(new String[] { "--bgcolor=#EBE9ED", "musicsketch2" });
  }
}
