class nextLevel{


  void run(){

    if(square.xPos>=levelEnd-10){
      levelBeaten=true;

    }
  }

  void hardModeChoice(){
    if(level==0&&square.xPos<10){
      hardMode=true;
      level=1;
      square.health=10;
      square.yPos=250; 
      completereset();

    }
    else if (level==0&&square.xPos>width-10){
      hardMode=false;
      level=1;
      square.health=20;
      square.yPos=250; 
      completereset();
    }
  }
  void levelbeaten(){



    if(levelBeaten==true){
      fill(0,100);
      rect(abs(trans)+width/2,height/2,width,height);
      textAlign(CENTER); 
      fill(255);
      text("You have completed LEVEL01\nPress SPACE to move on to LEVEL02",abs(trans)+width/2,height/2);
      textAlign(LEFT);
      inPlay=false;
    }
  }


  void levelreset(){
    if(levelBeaten==true){
      if(level==0){
        level=1;
        completereset();
        square.yPos=200;
        inPlay=true;

      }
      else if(level==1){
        level=2;
        completereset();
        square.yPos=200;
        inPlay=true;
      } 
      else if (level==2){

      }

    }
  }

}

class CheckPoints{
  float currentCheckpoint=150;


  void CPLevel1(){
  }
  void CPLevel2(){
    println(currentCheckpoint);
    if(square.xPos>1915&&currentCheckpoint<1915){
      currentCheckpoint=1915; 
    } 
    else if(square.xPos>3654&&currentCheckpoint<3654){
      currentCheckpoint=3654; 
    } 
    else if (square.xPos>5691&&square.xPos<8250){
      currentCheckpoint=5691; 
    } 
    else if (square.xPos>8250){
      currentCheckpoint=square.xPos;
    }
  }
}



