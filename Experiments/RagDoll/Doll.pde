class Piece{

  float x1=width/2;
  float y1=width/2;
  float x2=x1-50;
  float y2=y1;
  float xDraw;
  float yDraw;

  float xVel;
  float yVel;
  float xAcc;
  float yAcc;


  float Length;

  float angle;
  float angleVal=0;
  Piece (float len,float newX,float newY){
    Length=len;
    x2=newX;
    y2=newY;

  } 
  
   Piece (float len,float newX,float newY,float newAngleVal){
    Length=len;
    x2=newX;
    y2=newY;
    angleVal=newAngleVal;
  } 
  Piece (float len){
    Length=len;


  } 
  Piece (float len,float newAngleVal){
    Length=len;
angleVal=newAngleVal;

  } 

  void render(float xTarget, float yTarget){
    stroke(0);
    x1=xTarget;
    y1=yTarget; 
    if(yTarget>=ground){
      y1=ground;

    }
    line (x1,y1,x2,y2);

  }

  float angle2=0;








  void physics(){

    angle=atan2(y1-y2,x1-x2);
    if(abs(x1-x2)!=0){
      angle2=angle+PI/2*((x1-x2)/abs(x1-x2));

    }
    else{
      angle2=0;
    }


    float overallAcc=grav*cos((PI/2-angle2+angleVal));
    // println(overallAcc);
    if(y2>=ground){
      y2=ground;
      yVel=0;
      overallAcc=0; 
    }
    xAcc=overallAcc*cos(angle2);


    yAcc=overallAcc*sin(angle2);
    xVel+=xAcc;
    yVel+=yAcc;


    x2=x2+xVel;
    y2=y2+yVel;

    // println(angle+" 1 ");
    angle=atan2(y1-y2,x1-x2);


    stroke(255,100,100);
    //line(x1,y1,x2,y2);
    x2=-Length*cos(angle)+x1;
    y2=-Length*sin(angle)+y1;
    



    if(abs(x1-x2)>0){
      line (x2,y2,overallAcc*20*cos(angle2)+x2,overallAcc*20*sin(angle2)+y2);
    }

    //println(yVel);


    // line (100,100,100+(yVel),100);
    //println(angle+" , "+PI/2);
    //if(abs(angle)>PI/2-PI/4&&abs(angle)<PI/2+PI/4){
    yVel*=.9;
    //}
    xVel=xVel*.95;
  }
}




