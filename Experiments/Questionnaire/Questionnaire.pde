//Answer to Question 0: yes/sure
//Answer to Question 1: -your name-
//Answer to Question 2: black
//Answer to Question 3: yes


PFont font;

void setup(){
  size(400,400);

  font = loadFont ("SansSerif-22.vlw");
  textFont(font);
  textAlign(CENTER);
}

String currentInput="";
String currentQuestion="";
int page =0;
boolean wrong=false;

String  question0="Are you ready?";
String  question1="What's your name?";
String  question2="What's your favorite Color?";
String  question3="Ahh, Black. A very nice color... \n Do you like kittens?";
String  finishedText="Your test is Finished... \n-- Good Bye --";

String  answer0="yes";
String  answer1="a1";
String  answer2="a2";
String  answer3="a3";

String name="";
String Color="";
String Wrong="Please enter a valid answer";


String yes="yes";
String no="no";
String sure="sure";
String Red="red";
String Orange="orange";
String Yellow="yellow";
String Green="green";
String Blue="blue";
String Purple="purple";
String White="white";
String Black="black";










void draw(){
  background(30);
  if(page==0){
    currentQuestion=question0;
  }
  else if (page==1){
    currentQuestion=question1;
  }
  else if (page==2){
    currentQuestion=question2;
  }
  else if (page==3){
    currentQuestion=question3;
  }
  else if (page==4){
    currentQuestion=finishedText;
  }



  if(name.length()>0){
    textAlign(LEFT);
    text("Hello "+name+",",5,50);
    textAlign(CENTER);
  }

  text(currentQuestion,width/2,100);

  if(page!=4){
    text(currentInput,width/2,height/2);
  }
  if(wrong==true){
    currentInput="";
    text(Wrong,width/2,300) ;
  }
}

void keyPressed(){
  if(page!=4){
    if (keyPressed&&key!=RETURN && key!=ENTER&&key!=DELETE&&key!=BACKSPACE&&key!=CODED){
      currentInput+=key;
      wrong=false;
            Wrong="Please enter a valid Answer";
    }
    else if ((key==BACKSPACE||key==DELETE) && currentInput.length()!=0){
      currentInput=currentInput.substring(0,currentInput.length()-1);
      wrong=false;

    }
    else if (key==ENTER||key==RETURN){

      if(page==0&&currentInput.length()>0){
        if(yes.equals(currentInput.toLowerCase())||sure.equals(currentInput.toLowerCase())){
          page++;
        } 
        else if (currentInput.equals("no")){
          question0="Oh... How about now?";
        }
        else{
          wrong=true;
        }
        currentInput="";
      }
      else if(page==1&&currentInput.length()>0){
        name=currentInput;      
        currentInput="";
        page++;
      }
      else if(page==2&&currentInput.length()>0){
        if(Red.equals(currentInput.toLowerCase())||Orange.equals(currentInput.toLowerCase())||Yellow.equals(currentInput.toLowerCase())||Green.equals(currentInput.toLowerCase())||Blue.equals(currentInput.toLowerCase())||Purple.equals(currentInput.toLowerCase())||White.equals(currentInput.toLowerCase())){
          Wrong="Wrong. Please choose a better color";
          wrong=true;

        }else if (Black.equals(currentInput.toLowerCase())){
    page++;
        }      else{wrong=true;}
        

      }
      else if(page==3&&currentInput.length()>0){
        if(yes.equals(currentInput.toLowerCase())){
        page++;
        } else if (no.equals(currentInput.toLowerCase())){
         Wrong="You must love kittens, right?";
         question3="No way... Everyone likes kittens...";
        wrong=true; 
        }else{wrong=true;}
      } 
      else {
        wrong=true;
        currentInput="";
      }
      currentInput="";

    }

  }

} 





