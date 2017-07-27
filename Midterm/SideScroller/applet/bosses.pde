class MechBoss{
  float xPos=levelEnd;

  float xBound=levelEnd-180;

  float maxHealth=100;
  float health=100;
  float maxMiniGunHealth=30;
  float miniGunHealth1=30;
  float miniGunHealth2=30;

  float miniGunWidth=60;
  float miniGunHeight=25;

  boolean drawn=false;
  boolean xStop=true;
  boolean bossOn=false;
  boolean dead=false;
  boolean exploding=false;
  boolean miniGun1Dead=false;
  boolean miniGun2Dead=false;
  boolean vulnerable=false;

  boolean maingunhit=false;
  boolean minigun1hit=false;
  boolean minigun2hit=false;


  //mini gun
  float miniXPos=xPos-25;
  float miniYPos1=0;
  float miniYPos2=0;

  float rotXPos=xPos-52;
  float rotYPos=150;
  float rotGunAngle=0;
  //Counters

  int origMiniGunCount=45;
  int miniGunCount=origMiniGunCount;

  int origmainGunCount=300;
  int mainGunCount=origmainGunCount;

  int currentFill=0;
  int animationShot=0;

  int mainNumShot=20;

  float expCount=-10;

  int mainattackedcount=0;
  int mini1attackedcount=0;
  int mini2attackedcount=0;


  //RENDER//
  void render(){

    if(dead==false){
      beingDrawn();
    }

    briks();
    line (xBound,0, xBound,height);


    if(drawn==true){

      if(bossOn==true){ 
        miniGunCount--;
        mainGunCount--;

      }



      if(square.xPos>xBound&&xStop==true){
        square.xVel=0;
        square. xPos=xBound; 
      }

      /* fill(255);
       rectMode(CORNER);
       rect(xPos-20,-10,20,120);
       rect(xPos-140,5*20+10,140,100);
       rect(xPos-100,210, 100,40);
       rect(xPos-30,250,30,160);
       */

      rectMode(CENTER);
      if(animationShot==0){
        vulnerable=false;
        image(mechbosscl,xPos-90,height/2);
      }
      else if (animationShot==1){
        vulnerable=false;
        image(mechbossop1,xPos-90,height/2);
      }
      else if (animationShot==2){
        vulnerable=true;
        image(mechbossop2,xPos-90,height/2);
      }



      //println(mainGunCount);

      if(dead==false&&bossOn==true){
        mainShootAnimation();
        attacked();
      }
    }
    if (miniGunCount<0){
      miniGunCount=origMiniGunCount; 
    }
    if(mainGunCount<=0){
      mainGunCount=origmainGunCount;
    }



    for(int i=0;i<maxEnBullets;i++){
      if(enemybullets[i].drawn==true){
        enemybullets[i].render();
      }
    }




    if(drawn==true){

      miniGun1();
      miniGun2();
      rotatingGun();
    }  
    image(wires,xPos-90,height/2);
    if(square.xPos>=xBound-100){
      bossOn=true; 
      trans=levelEnd-width;
    }
    if(bossOn==true){
      bossHUD();
    }
    explosion();
    dead();
  }
  int shot;
  int mainShot=mainNumShot;


  //mini gun shoot countdown timer

  void miniGun1(){
    if(miniGun1Dead==false){ 
      shot=1;
      miniYPos1= constrain(square.yPos, 10,100);
      miniGunShoot(-PI,miniXPos,miniYPos1);
      //rect(miniXPos,miniYPos1,miniGunWidth,miniGunHeight);
      image(mechbossMiniGun,-20+miniXPos,miniYPos1);
      if(bossOn==true){ 

      }
    }
    else if (miniGun1Dead==true){

      //rect(miniXPos,miniYPos1,miniGunWidth,miniGunHeight);
      image(mechbossMiniGunDead,-20+miniXPos,miniYPos1);
    }

  }



  void miniGun2(){
    if(miniGun2Dead==false){
      shot=1;
      miniYPos2= constrain(square.yPos, 260,380);
      miniGunShoot(-PI,miniXPos,miniYPos2);
      //rect(miniXPos,miniYPos2,miniGunWidth,miniGunHeight);
      image(mechbossMiniGun,-20+miniXPos,miniYPos2);
      if(bossOn==true){

      }
    }
    else if (miniGun2Dead==true){

      // rect(miniXPos,miniYPos2,miniGunWidth,miniGunHeight);
      image(mechbossMiniGunDead,-20+miniXPos,miniYPos2);

    }

  }

  void rotatingGun(){
    if(dead==false){
      shot=1;
      if(bossOn==true){
        miniGunShoot(rotGunAngle+PI,rotXPos, rotYPos);
      }
      pushMatrix();
      {
        translate(rotXPos,rotYPos);
        // line(0,0,120*cos((rotGunAngle+PI)),120*sin((rotGunAngle+PI)));
        rotGunAngle=atan((square.yPos-rotYPos)/(square.xPos-rotXPos));
        rotate(rotGunAngle);
        //rect(-20,0,50,20);
        image(mechbossRotGun,-20,0);
      }
      popMatrix();
    }
    else if (dead==true){
      pushMatrix();
      {
        translate(rotXPos,rotYPos);
        //line(0,0,120*cos((rotGunAngle+PI)),120*sin((rotGunAngle+PIa
        rotate(rotGunAngle);
        image(mechbossRotGun,-20,0);
      }
      popMatrix();
    }
  }




  void miniGunShoot(float bulletAngle,float bulXPos, float bulYPos){
    for(int i=0;i<maxEnBullets;i++){
      if (enemybullets[i].drawn==false&&shot==1&&miniGunCount==0){
        enemybullets[i].xPos=bulXPos;
        enemybullets[i].yPos=bulYPos;
        enemybullets[i].bulAngle=bulletAngle;
        currentEnBullet=i;
        shot--;
      }
    }


    if(miniGunCount==0){
      enemybullets[currentEnBullet].drawn=true;
    }
  }



  void mainGunShoot(){
    for(int i=0;i<maxEnBullets;i++){
      if (enemybullets[i].drawn==false&&mainShot>=0){
        enemybullets[i].xPos=xPos-130;
        enemybullets[i].yPos=150;
        enemybullets[i].bulAngle=PI/2+(PI/mainNumShot)*(mainShot);

        currentEnBullet=i;
        enemybullets[currentEnBullet].drawn=true;
        mainShot--;
      }
    }
  }



  void beingDrawn(){
    if (xBound>abs(trans)&&xBound<abs(trans)+width){
      drawn=true; 
    } 
    else {
      drawn=false; 
    }
  }



  void bossHUD(){
    //healthBars
    rectMode(CORNER);
    noStroke();
    rect(abs(trans)+225,10,map(health,0,maxHealth,0,250),8);

    rect(abs(trans)+225,20,map(miniGunHealth1,0,maxMiniGunHealth,0,120),8);

    rect(abs(trans)+225+130,20,map(miniGunHealth2,0,maxMiniGunHealth,0,120),8);
    stroke(0);
    noFill();
    rect(abs(trans)+225,10,250, 8);
    rect(abs(trans)+225,20,120,8);

    rect(abs(trans)+225+130,20,120,8);
    fill(255);

    rectMode(CENTER);
  }

  void attacked(){

    if(miniGun1Dead==false){
      for(int i=0; i<maxBullets;i++){
        if(bullets[i].damaging==true&&bullets[i].xPos>miniXPos-miniGunWidth/2&&bullets[i].xPos<miniXPos+miniGunWidth/2 && bullets[i].yPos>miniYPos1-miniGunHeight/2 && bullets[i].yPos<miniYPos1+miniGunHeight/2){
          miniGunHealth1-=bullets[i].damage;
          bullets[i].exploding=true;
        } 

      }

    }
    if(miniGun2Dead==false){
      for(int i=0; i<maxBullets;i++){
        if(bullets[i].damaging==true&&bullets[i].xPos>miniXPos-miniGunWidth/2&&bullets[i].xPos<miniXPos+miniGunWidth/2 && bullets[i].yPos>miniYPos2-miniGunHeight/2 && bullets[i].yPos<miniYPos2+miniGunHeight/2){
          miniGunHealth2-=bullets[i].damage;
          bullets[i].exploding=true;
        } 

      }
    }
    if(vulnerable==true){
      for(int i=0; i<maxBullets;i++){
        if(bullets[i].damaging==true&&bullets[i].xPos>xPos-150&&bullets[i].xPos<xPos-120&&bullets[i].yPos>115&&bullets[i].yPos<115+90){
          println("TRUE");
          health-=bullets[i].damage;
          bullets[i].exploding=true;
        }
      }
    }

  }


  void mainShootAnimation(){
    mainShot=mainNumShot;

    if(health>=maxHealth/2){
      mainNumShot=10;
      if(mainGunCount==95||mainGunCount==5){
        //println("OPEN 1");
        currentFill=155;
        animationShot=1;
      } 
      else if (mainGunCount==90){
        //println("OPEN FULL");
        currentFill=255;
        animationShot=2;
      } 
      else if (mainGunCount==0){
        //println("CLOSED");
        currentFill=0;
        animationShot=0;
      }
      if(mainGunCount==45){
        // println("SHOOT)");
        mainGunShoot(); 
      }
    }
    else if (health>=maxHealth/4){
      mainNumShot=13;

      if(mainGunCount==200||mainGunCount==155||mainGunCount==50||mainGunCount==5){
        // println("OPEN 1");
        currentFill=155;
        animationShot=1;
      } 
      else if (mainGunCount==195||mainGunCount==45){
        //  println("OPEN FULL");
        currentFill=255;
        animationShot=2;
      } 
      else if (mainGunCount==0||mainGunCount==150){
        // println("CLOSED");
        currentFill=0;
        animationShot=0;
      }

      if(mainGunCount==177||mainGunCount==27){
        // println("SHOOT)");
        mainGunShoot(); 
      }
    }
    else if (health>0&&health<maxHealth/4)
    {
      if(origmainGunCount==300){
        origmainGunCount=75;
        currentFill=0;
        animationShot=0;  
      }
      mainNumShot=16;      



      if(mainGunCount==40||mainGunCount==5){
        // println("OPEN 1");
        currentFill=155;
        animationShot=1;
      } 
      else if (mainGunCount==35){
        // println("OPEN FULL");
        currentFill=255;
        animationShot=2;
      } 
      else if (mainGunCount==0){
        // println("CLOSED");
        currentFill=0;
        animationShot=0;
      }

      if(mainGunCount==20){
        //

        mainGunShoot(); 
      }
    }
  }

  void dead(){
    if (miniGunHealth1<=0||dead==true){
      miniGunHealth1=0;
      miniGun1Dead=true;
    } 
    if (miniGunHealth2<=0||dead==true){
      miniGunHealth2=0;
      miniGun2Dead=true;
    } 
    if(health<=0){
      dead=true;
      health=0; 
    }

  }


  void explosion(){
    if(dead==true&&expCount<30){
      //fill(255,map(expCount,0,30,255,0));
      if(expCount>0){
        fill(255,map(expCount,15,30,255,0));
        ellipse(xPos-75,height/2,3*pow(expCount,2),3*pow(expCount,2));

        if(expCount==15){
          drawn=false;
        }
      }
      expCount+=.5;
      fill(255);
    }

  }



  int ammoKitCollectedCount=180;
  void briks(){

    for (int i=0; i<3;i++){
      bricks[currentBrick]=new Brick();
      bricks[currentBrick].xPos=xPos-600+bricks[currentBrick].Width*i; 
      bricks[currentBrick].graphic=2;
      bricks[currentBrick].yPos=380;
      bricks[currentBrick].render();
      currentBrick++; 
    }

    for (int i=0; i<3;i++){
      bricks[currentBrick]=new Brick();
      bricks[currentBrick].xPos=xPos-410+bricks[currentBrick].Width*i; 
      bricks[currentBrick].graphic=2;
      bricks[currentBrick].yPos=380-80;
      bricks[currentBrick].render();
      currentBrick++; 
    }


    for (int i=0; i<6;i++){
      bricks[currentBrick]=new Brick();
      bricks[currentBrick].xPos=xPos-390+bricks[currentBrick].Width*i; 
      bricks[currentBrick].graphic=2;
      bricks[currentBrick].yPos=380-240;
      bricks[currentBrick].render();
      currentBrick++; 
    }

    for (int i=0; i<2;i++){
      bricks[currentBrick]=new Brick();
      bricks[currentBrick].xPos=xPos-570+bricks[currentBrick].Width*i; 
      bricks[currentBrick].graphic=2;
      bricks[currentBrick].yPos=380-160;
      bricks[currentBrick].render();
      currentBrick++; 
    }


    bricks[currentBrick]=new Brick();
    bricks[currentBrick].graphic=2;
    bricks[currentBrick].xPos=xPos-530; 
    bricks[currentBrick].yPos=380-180;
    bricks[currentBrick].render();
    currentBrick++; 

    if(drawn==true){
      for (int i=0; i<5;i++){
        bricks[currentBrick]=new Brick();
        bricks[currentBrick].graphic=2;                                                                                                                                              
        bricks[currentBrick].xPos=xPos-100; 
        bricks[currentBrick].yPos=120+bricks[currentBrick].Width*i;
        bricks[currentBrick].render();
        currentBrick++;
      } 
    }

    //AmmoKit
    if(bossammokit.collected==true){
      ammoKitCollectedCount=60; 
      bossammokit.collected=false;
    }
    if(ammoKitCollectedCount==0&&bossOn==true){
      bossammokit.xPosOrig=xPos-570+10;
      bossammokit.yPosOrig=380-190;
      bossammokit.render();

    }
    if(ammoKitCollectedCount>0){
      ammoKitCollectedCount--; 
    }

  }

  void reset(){






    health=maxHealth;

    miniGunHealth1=maxMiniGunHealth;
    miniGunHealth2=maxMiniGunHealth;




    drawn=false;
    xStop=true;
    bossOn=false;
    dead=false;
    exploding=false;
    miniGun1Dead=false;
    miniGun2Dead=false;
    vulnerable=false;


    //mini gun
    miniXPos=xPos-25;
    miniYPos1=0;
    miniYPos2=0;

    rotXPos=xPos-52;
    rotYPos=150;
    rotGunAngle=0;
    //Counters


    miniGunCount=origMiniGunCount;


    mainGunCount=origmainGunCount;

    currentFill=0;
    animationShot=0;

    mainNumShot=20;

    expCount=-10;

  }
}


class nullBoss{
  float xPos=levelEnd-width;
  float yPos=0;
  boolean bossOn=false;


  void render(){

    if(bossOn==true){
      text("SORRY, NO BOSS HERE :(",  levelEnd-width/2,50);
    }

    if(square.xPos>levelEnd-width+300){
      bossOn=true; 
    }
    //println(bossOn);


  }

  void reset(){
    bossOn=false;



  }


}





