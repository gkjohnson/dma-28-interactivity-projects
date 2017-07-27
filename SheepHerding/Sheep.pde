class Sheep{
  float x;
  float y;
  float yPrev;
  float xPrev;

  float v;

  float Vel=-.5;

  int num;
  boolean scared=false;
  boolean scaring=false;
  int ORIG_SCARED_COUNT=240;
  int scaredCount=120;

  boolean caught=false;

  Sheep(float newX, float newY,float newV,int newNum){
    x= newX;
    y= newY;
    v=newV;
    num=newNum;
    for (int i=0;i<trailLen;i++){
      trail[num][i][0]= newX;
      trail[num][i][1]=newY;
    } 
  }

  void render(){
    Vel=constrain(map(dist(mouseX,mouseY,x,y),0,SCARE_DIST,-5,0),-5,-1);
    /* if(inPlay==true){ 
     move();
     }
     else if (inPlay==false&&caught==false){
     move();
     }*/
         
    if(pause==false){
      move();
    }
hitCheck();
    noStroke();
    fill(0,100);
    ellipse(x+1.5,y+1.5,6,6);
    stroke(0);
    fill(255);
    ellipse(x,y,5.5,5.5);



    if(showTrail==true){
      addValues();
    }
    checkCaught();


  }

  void move(){
    if(dist(mouseX,mouseY,x,y)<SCARE_DIST){
      xPrev=x;
      yPrev=y;
      x+=Vel*cos(getAngle());
      y+=Vel*sin(getAngle());
      scared=true;
      scaring=true;
      scaredCount=ORIG_SCARED_COUNT;
      x+=cos((noise(v))*4*PI)*.01;
      y+=sin((noise(v))*4*PI)*.01;
      v+=.01;
      noStroke();
      fill(40);
      ellipse (x+cos(getAngle())*-2,y+sin(getAngle())*-2,5,5);
      stroke(0);
      fill(255);
    }
    else{
      x+=cos((noise(v))*4*PI)*.4;
      y+=sin((noise(v))*4*PI)*.4;
      scaring=false;

      noStroke();
      fill(40);
      ellipse (x+cos((noise(v))*4*PI)*2,y+sin((noise(v))*4*PI)*2,5,5);
      stroke(0);
      fill(255);
      if (relationships==true){
        stroke(0,0,255);
        line (x,y,x+cos((noise(v))*4*PI)*6.5,y+sin((noise(v))*4*PI)*6.5);
        stroke(0);
      }
      v+=.01;
      if(scaredCount>0){
        scaredCount--;
      }
      else {
        scared=false;
      }
    }
    if(x<BARRIER_WIDTH){
      x=BARRIER_WIDTH;
    }
    else if (x>width-BARRIER_WIDTH){
      x=width-BARRIER_WIDTH;
    }
    if(y<BARRIER_WIDTH){
      y=BARRIER_WIDTH;
    }
    else if (y>height-BARRIER_WIDTH){
      y=height-BARRIER_WIDTH;
    }
    if(scared==false){
      getDist();
    }
  }

  float getAngle(){
    float dx=mouseX-x;
    float dy=mouseY-y; 
    float angle = atan2(dy,dx);
    return angle;
  }

  void getDist(){
    float averageX=0;
    float averageY=0;
    int totalAdded=0;

    for (int i=0;i<sheepToRender;i++){
      float d=dist(sheep[num].x,sheep[num].y,sheep[i].x,sheep[i].y);
      if(d<50&&d>40&&d>0){
        if(relationships==true){ 
          stroke(255,0,0,20);
          line (sheep[num].x,sheep[num].y,sheep[i].x,sheep[i].y);
          stroke(0);    
        }
        averageX+=sheep[i].x;
        averageY+=sheep[i].y;
        totalAdded++;
      } 
      else if(d<40&&d>0){
        if(relationships==true){ 
          stroke(0,20);
          line (sheep[num].x,sheep[num].y,sheep[i].x,sheep[i].y);
          stroke(0);    
        }
      }
    }
    averageX=averageX/totalAdded;
    averageY=averageY/totalAdded;

    if(totalAdded!=0){
      flock(averageX,averageY);
    }
  }

  void flock(float newx,float newy){
    float dy=sheep[num].y-newy;
    float dx=sheep[num].x-newx;
    float newAngle=atan2(dy,dx);

    if(relationships==true){ 
      // line (x,y,x+cos(newAngle)*30,y+sin(newAngle)*30);
    }
    x+=cos(newAngle)*-.2;//*map(dx,0,50,.3,0);
    y+=sin(newAngle)*-.2;//*map(dy,0,50,.3,0);
  }

  void addValues(){
    //trail[num][n];
    //trail -- for loop to move all values up one spot in the array

    for (int i=trailLen-1;i>0;i--){
      trail[num][i][0]= trail[num][i-1][0];
      trail[num][i][1]=trail[num][i-1][1];

      trailDisp[num][i]= trailDisp[num][i-1];
      trailDisp[num][i]=trailDisp[num][i-1];
    }
    trail[num][0][0]=x;
    trail[num][0][1]=y; 

    if(scaring==false){
      trailDisp[num][0]=true;
    }
    else if (scaring==true){
      trailDisp[num][0]=false;
    }
  }


  void checkCaught(){
    if (x >corral.x-corral.Width/2-1&&x<corral.x+corral.Width/2+1&& y >corral.y-corral.Height/2-1&&y<corral.y+corral.Height/2+1){
      if(inPlay==true){
        caught=true;
        sheepCaught++;
      }
    } 
    else {
      caught=false;
    }
  }

  void hitCheck(){

    if(corral.right==true){
      if(x<corral.x+corral.Width/2+corral.wallWidth+corral.wallWidth&&x>corral.x+corral.Width/2-corral.wallWidth+corral.wallWidth&&y<corral.y+corral.Height/2+corral.wallWidth*2&&y>corral.y-corral.Height/2-corral.wallWidth*2){
        if(x-xPrev>0) {
          x=corral.x+corral.Width/2-corral.wallWidth+corral.wallWidth;
        }
        if(x-xPrev<0) {
          x=corral.x+corral.Width/2+corral.wallWidth+corral.wallWidth;
        }
      }
    }

    if(corral.left==true){
      if(x<corral.x-corral.Width/2-corral.wallWidth+corral.wallWidth&&x>corral.x-corral.Width/2-corral.wallWidth-corral.wallWidth&&y<corral.y+corral.Height/2+corral.wallWidth*2&&y>corral.y-corral.Height/2-corral.wallWidth*2){
        if(x-xPrev>0) {
          x=corral.x-corral.Width/2-corral.wallWidth-corral.wallWidth;
        }
        if(x-xPrev<0) {
          x=corral.x-corral.Width/2-corral.wallWidth+corral.wallWidth;
        }
      }
    }


    if(corral.down==true){
      if(y<corral.y+corral.Height/2+corral.wallWidth+corral.wallWidth&&y>corral.y+corral.Height/2-corral.wallWidth+corral.wallWidth&&x<corral.x+corral.Width/2+corral.wallWidth*2&&x>corral.x-corral.Width/2-corral.wallWidth*2){
        if(y-yPrev>0) {
          y=corral.y+corral.Height/2-corral.wallWidth+corral.wallWidth;
        }
        if(y-yPrev<0) {
          y=corral.y+corral.Height/2+corral.wallWidth+corral.wallWidth;
        }
      } 
    }
    if(corral.up==true){
      if(y<corral.y-corral.Height/2-corral.wallWidth+corral.wallWidth&&y>corral.y-corral.Height/2-corral.wallWidth-corral.wallWidth&&x<corral.x+corral.Width/2+corral.wallWidth*2&&x>corral.x-corral.Width/2-corral.wallWidth*2){
        if(y-yPrev>0) {
          y=corral.y-corral.Height/2-corral.wallWidth-corral.wallWidth;
        }
        if(y-yPrev<0) {
          y=corral.y-corral.Height/2-corral.wallWidth+corral.wallWidth;
        }
      }
    } 
  }

  void reset(float newX, float newY,float newV){


    x= newX;
    y= newY;
    v=newV;
    caught=false;
    for (int i=0;i<trailLen;i++){
      trail[num][i][0]= newX;
      trail[num][i][1]=newY;
    }
  }





}







