//Garrett Johnson
//Cliff1
size (400,400);
smooth();
noStroke();

background(#bdbdad);//bg color

fill(#f09277);//light orange
beginShape();//begin upper left orange shape
vertex(0,30);
bezierVertex(15,19,  25,15,  60,0);
vertex(60,0);
vertex(250,0);
vertex(250,150);
vertex(50,165);
vertex(0,210);


endShape();//end upper left orangeshape

fill(#b29772);//brown
beginShape();//bg brown shape
vertex(200,0);
vertex(240,340);
vertex(240,340);
bezierVertex(200,350,  210,375,   190,390);
vertex(190,390);
vertex(200,400);
vertex(400,400);
vertex(400,0);
endShape(); // end bg brown shape


fill(#a92732);//dark red
beginShape();// begin red line
vertex(345,180);
bezierVertex(300,320, 310,300, 290,400);
vertex(310,400);
vertex(297,400);
vertex(349,180);
endShape(); // end red line


fill(#f3dbb5);//beige
beginShape();// begin tan shape next to red line
vertex(347,180);
bezierVertex(305,320, 315,300, 297,400);
vertex(315,400);
vertex(400,400);
endShape(); // end tan line

fill(#807971); //blue
beginShape(); //begin blue spikeleft
vertex(240,0);
vertex(200,260);
vertex(250,0);
endShape(); //end blue spikeleft
beginShape();//begin blue spikeright
vertex(300,100);
vertex(250,200);
vertex(310,100);
endShape();//end blue spikeright

stroke(#757776); 
noFill();
strokeWeight(10);
bezier(105, 380,  140,400, 200,400,  280,410);
line(105,395,  120,410);

strokeWeight(10); // beigestrokes
stroke(#f3dbb5);
noFill();
bezier(350,400,  330,0,  310,200,  270,400);
line(270,400, 250,200); // end strokes
strokeWeight(15);
line(120,395, 105,410);

strokeWeight(20); // beigestrokes
stroke(#f3dbb5, 255/2);


noFill();
bezier(350,400,  330,0,  310,200,  280,400);

noStroke();
fill(#f3dbb5, 255/2);
bezier(270,400,   260,100,  240,100,  205,400); // end strokes



fill(#cab64a); // yellowgreen
beginShape();//green shape in upper right
vertex(250,0);
bezierVertex(247,10, 240,20, 242,60);
vertex(242,60);
vertex(275,90);
vertex(270,100);
vertex(305,120);
vertex(400,210);
vertex(400,0);
endShape();//end green shape in upper right

fill(#bca321); // darker yellowgreen
beginShape();//green shape in upper right
vertex(250,0);
bezierVertex(247,10, 240,20, 242,60);
vertex(242,60);
vertex(275,90);
vertex(270,100);
vertex(305,120);
vertex(360,170);

vertex(359,160);
vertex(250,50);
vertex(290,40);
vertex(340, 100);
vertex(365,100);



bezierVertex(350,0,  340,20,   320,10);
vertex(320,10);
vertex(323,0);
endShape();//end green shape in upper right


fill(#ff663c); // orange
quad(400,190, 340,140, 345,400, 400,400); // orange point on right

fill(#f3dbb5); // beige
beginShape(); //beige shape overlay on top of orange rect
vertex(400, 225);
vertex(390,240);
vertex(388,264);
vertex(385,265);
vertex(385,273);
vertex(391,279);
vertex(390,320);
vertex(387,350);
vertex(385,350);
vertex(385,355);
vertex(387,356);
vertex(385,400);
vertex(400,400);
endShape(); //end beige shape overlay

fill(#a92732,240);//dark red
beginShape();//begin red shape on left
vertex(0,85);
bezierVertex(0,80, 0,100, 35,110);
vertex(35,110);
vertex(70,108);
vertex(100,65);
vertex(130,30);
vertex(135,35);
vertex(135,45);
curveVertex(135,45);
curveVertex(150,70);
curveVertex(210,100);
curveVertex(233,110);
vertex(233,110);
vertex(238,145);
vertex(200,160);
vertex(160,230);
vertex(143,290);
vertex(140,360);
vertex(130,363);
vertex(125,360);
vertex(123,360);
vertex(123,369);
vertex(70,400);
vertex(0,400);
vertex(0,270);
vertex(26,250);
curveVertex(26,250);
curveVertex(31,210);
curveVertex(33,190);
curveVertex(35,160);
vertex(35,160);
bezierVertex(20,160, 10,150, 0,140);
vertex(0,140);
endShape();//end red shape on left


fill(#8d1118,255/2);
beginShape();
vertex(80,160);
vertex(100,145);
bezierVertex(100,130,  120,90,  120,140);
vertex(120,140);
vertex(125,150);
bezierVertex(125,140,  100,165, 125,165);
bezierVertex(140,165,  180,165, 190,175);
vertex(160,230);
vertex(143,290);
vertex(140,360);
vertex(130,363);
vertex(125,360);
vertex(123,360);
vertex(123,369);
vertex(70,400);
vertex(0,400);
vertex(0,270);
vertex(26,250);
curveVertex(26,250);
curveVertex(31,210);
curveVertex(33,190);


endShape();




fill(#bdbdad);//gray
beginShape();//inner triangle begin
vertex(60,160);
vertex(70,250);
vertex(73,250);
vertex(75,230);
vertex(100,150);
vertex(80,160);
endShape(); //inner triangle end
