import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

/*
    DIT OOP Assignment 2 Starter Code
    =================================
    
    Loads player properties from an xml file
    See: https://github.com/skooter500/DT228-OOP 
*/

Minim minim;
ArrayList<GameObject> objects = new ArrayList<GameObject>();
ArrayList<Splashscreen> splashscreenItems = new ArrayList<Splashscreen>();

boolean[] keys = new boolean[526];
float centX;
float centY;
boolean splashScreen = true;
boolean startGame;
boolean gameOver;


Button startGameButton;

void setup()
{ 
  background(0);
  size(900, 500);
  
  float buttonIndent = ((width/2) - (110));
  minim = new Minim(this);
  centX = width /2;
  centY = height/2;
  
  setUpPlayerControllers();
  
  startGameButton = new Button(buttonIndent, centY, "Images/Splashscreen/button.png");
  startGameButton.imageNameOnHover= "Images/Splashscreen/buttonOnHover.png";
  splashscreenItems.add(startGameButton);
  
  
}

void draw()
{ 
  
  if(splashScreen){
    splashScreen();
  } else if(startGame) {
    gameRunning();
  } else if( gameOver){
    gameOver();
  }
  
  
}

// Display the splashscreen.
void splashScreen(){
  for (int i = 0; i < splashscreenItems.size(); i++){
    splashscreenItems.get(i).display();
    splashscreenItems.get(i).hover();
    
    
    if(splashscreenItems.get(0).clicked()){
      splashScreen = false;
      startGame = true;
    }
  }
  
}

void gameRunning(){
  fill(0);
  background(255);
  for(int i = 0; i < objects.size(); i++){
    objects.get(i).update();
    objects.get(i).display();
  }
  
  line(0, 300, 0, 300);
}

void gameOver(){
}

void keyPressed() {
  keys[keyCode] = true;
}

void keyReleased() {
  keys[keyCode] = false;
}

boolean checkKey(char theKey){
  return keys[Character.toUpperCase(theKey)];
}

char buttonNameToKey(XML xml, String buttonName) {
  String value =  xml.getChild(buttonName).getContent();
  if ("LEFT".equalsIgnoreCase(value)){
    return LEFT;
  }
  if ("RIGHT".equalsIgnoreCase(value)) {
    return RIGHT;
  }
  if ("UP".equalsIgnoreCase(value)) {
    return UP;
  }
  if ("DOWN".equalsIgnoreCase(value)) {
    return DOWN;
  }
  //.. Others to follow
  return value.charAt(0);  
}

void setUpPlayerControllers(){
  XML xml = loadXML("arcade.xml");
  XML[] children = xml.getChildren("player");
  int gap = width / (children.length + 1);
  
  for(int i = 0 ; i < children.length ; i ++) {
    XML playerXML = children[i];
    Player p = new Player(
            i
            , color(random(0, 255), random(0, 255), random(0, 255))
            , playerXML);
    int x = (i + 1) * gap;
    p.pos.x = x;
    p.pos.y = 300;
   objects.add(p);         
  }
}
