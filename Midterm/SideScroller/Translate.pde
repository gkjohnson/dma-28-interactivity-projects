class Translate{
  float transRightBound=rightBound-300;
  float transLeftBound=leftBound+100;

  void updateTrans(){
    transRightBound=rightBound-300;
    transLeftBound=leftBound+200;
    if (square.xPos>=transRightBound&&abs(square.xVel)/square.xVel==1&&-trans+width<=levelEnd){
      trans-=square.xVel; 
    }
    if (square.xPos<=transLeftBound&&abs(square.xVel)/square.xVel==-1&&-trans>=0){
      trans-=square.xVel;
    }
    if(trans>0){
      trans=0;
    }
    else if (trans<-levelEnd+width){
      trans=-levelEnd+width; 
    }




    if(mechboss.bossOn==true||nullboss.bossOn==true){
      trans=-levelEnd+width;
    }

  }
}



