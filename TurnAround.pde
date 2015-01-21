/*
 ** DT228/2 Object Orientated Programming Assignment
 ** See: https://github.com/StephenFox1995/TurnAround
 ** ==============================================
 ** - Author: Stephen Fox
 ** - Student No: C13475462
 ** - Email: c13475462@mydit.ie
 ** - GitHub: https://github.com/StephenFox1995
 **   
 ** - Forked from: https://github.com/skooter500/Assignment2StarterCode
 **   
 ** - Note: Changed project name from Assignment2StarterCode to TurnAround
 **   
*/

import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;


Minim minim;
ArrayList<GameObject> objects = new ArrayList<GameObject>();
ArrayList<Splashscreen> splashscreenItems = new ArrayList<Splashscreen>();

boolean[] keys = new boolean[526];

float centX;
float centY;

boolean splashScreen = true;
boolean startGame;
boolean gameOver;

Score score = new Score("Score:", 0);


Difficulty difficulty;

Button startGameButton;


void setup()
{ 

  background(0);
  size(700, 700);
  
  float buttonIndent = ((width/2) - (110));
  minim = new Minim(this);
  centX = width /2;
  centY = height/2;
  
  setUpPlayerControllers();
  
  startGameButton = new Button(buttonIndent, centY, "Images/Splashscreen/button.png");
  startGameButton.imageNameOnHover= "Images/Splashscreen/buttonOnHover.png";
  splashscreenItems.add(startGameButton);
  
  objects.add(score);
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

// Display the splashscreen
void splashScreen(){
  for (int i = 0; i < splashscreenItems.size(); i++){
    splashscreenItems.get(i).display();
    splashscreenItems.get(i).hover();
    
    
    if(splashscreenItems.get(0).clicked()){
      
      difficulty = Difficulty.Easy;
      setupEnemies(difficulty);
      
      // Set difficulty
      splashScreen = false;
      startGame = true;
    }
  }
  
}

// Implement gameplay here
void gameRunning(){
  fill(0);
  background(0);
  
  for(int i = 0; i < objects.size(); i++){
    objects.get(i).update();
    objects.get(i).display();
    objects.get(i).move();
    println(objects.size());
    
    if(objects.get(i) instanceof Enemy && !objects.get(i).alive){
      objects.get(i).respawn();
    }
    
    if(objects.get(i) instanceof Bullet && !objects.get(i).alive){
      objects.remove(i);
    }
    
  }  
}

void gameOver(){
}

// Create specific number of enemies
// depending on the difficulty.
void setupEnemies(Difficulty difficulty){
  
  int enemyCount = 0;
  
  switch (difficulty){
    case Easy:
      enemyCount = 10;
      break;
      
    case Medium:
      enemyCount = 20;
      break;
      
    case Hard:
      enemyCount = 30;
      break;
    
    default:
      enemyCount = 0;
      break;
  }
  
  // Create the amount of enemies
  // according to difficulty and
  // add to arraylist
  for(int i = 0; i < enemyCount; i++){
    objects.add(new Enemy());
  }
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
  
  for(int i = 0 ; i < children.length - 1 ; i ++) {
    XML playerXML = children[i];
    Player p = new Player(
            i
            , color(random(0, 255), random(0, 255), random(0, 255))
            , playerXML);
    int x = (i + 1) * gap;
   objects.add(p);         
  }
}
