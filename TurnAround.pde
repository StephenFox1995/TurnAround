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
ArrayList<SplashScreen> splashScreenItems = new ArrayList<SplashScreen>();

boolean[] keys = new boolean[526];

float centX;
float centY;

boolean splashScreen = true;
boolean startGame;
boolean gameOver;
PImage splashScreenTitle;

Score score = new Score();


Difficulty difficulty;

boolean devMode = true;

boolean sketchFullScreen() {
  return !devMode;
}

void setup() {
 
 if(devMode) {
    size(800, 800);
  } else {
    size(displayWidth, displayHeight);
  } 

  background(0);  
  
  minim = new Minim(this);
  centX = width /2;
  centY = height/2;
  
  setUpPlayerControllers();
  setUpSplashScreenAttributes();
  setupPowerUps();
  
  score.setPosition(width * 0.8f, height * 0.05f);
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
  
  image(splashScreenTitle, centX - 255, 50);
  for (int i = 0; i < splashScreenItems.size(); i++){
    
    splashScreenItems.get(i).display();
    splashScreenItems.get(i).hover();
    
    if(splashScreenItems.get(0).clicked()) {
      difficulty = Difficulty.Easy;
      setupEnemies(difficulty);
      startGame();
    }
    if(splashScreenItems.get(1).clicked()) {
      difficulty = Difficulty.Medium;
      setupEnemies(difficulty);
      startGame();
    }
    if(splashScreenItems.get(2).clicked()) {
      difficulty = Difficulty.Hard;
      setupEnemies(difficulty);
      startGame();
    }
  }
  
}

// Implement gameplay here
void gameRunning(){
  fill(255);
  background(0);
  
  switch(difficulty) {
    case Easy:
      text("EASY", width * 0.05, 20);
      break;
      
    case Medium:
      text("MEDIUM", width * 0.05, 20);
      break;
    
    case Hard:
      text("HARD", width * 0.05, 20);
      break;
  }
  
  for(int i = 0; i < objects.size() - 1; i++){
    
    objects.get(i).update();
    objects.get(i).display();
    objects.get(i).move();
    
    if(objects.get(i) instanceof Enemy){
      if(!objects.get(i).alive) {
        objects.get(i).respawn();
      }
    }
    
    
    if(objects.get(i) instanceof Bullet){
      
      Bullet bullet = (Bullet)objects.get(i);
      
      if(!bullet.alive) {
        objects.remove(i);
      }
      
      // Hit detection between bullets and enemy.
      for(int j = 0; j < objects.size(); j++){
        
        if(objects.get(j) instanceof Enemy) {
          
          Enemy enemy = (Enemy)objects.get(j);
          
          if(bullet.collides(enemy)) {
            
            enemy.respawn();
            score.updateScore(10);
          }
        }
      } 
    }
    
    
    if(objects.get(i) instanceof Player) {
      
      Player player = (Player)objects.get(i);
      
      // Hit detection between player and enemy
      for(int j = 0; j < objects.size(); j++) { 
        if(objects.get(j) instanceof Enemy) {
               
          Enemy enemy = (Enemy)objects.get(j);
          
          if(player.collides(enemy)) {
            player.decreaseHealthBar(5);
          }
        }
      }
    }
  }  
}

void gameOver(){
}

void startGame() {
  // Remove splash screen and start game
  splashScreen = false;
  startGame = true;
}

void setUpSplashScreenAttributes() {
  
  Button startGameButton;
  Button mediumGameButton;
  Button hardGameButton;
  
  float buttonIndent = (centX - 110);
  
  splashScreenTitle = loadImage("Images/Splashscreen/TurnAround.png");
  
  startGameButton = new Button(buttonIndent, height * 0.3f, "Images/Splashscreen/EasyButton.png");
  startGameButton.setImageOnHover("Images/Splashscreen/EasyHover.png");
  splashScreenItems.add(startGameButton);
  
  mediumGameButton = new Button(buttonIndent, height * 0.4f, "Images/Splashscreen/MediumButton.png");
  mediumGameButton.setImageOnHover("Images/SplashScreen/MediumHover.png");
  splashScreenItems.add(mediumGameButton);
  
  hardGameButton = new Button(buttonIndent, height * 0.5f, "Images/Splashscreen/HardButton.png");
  hardGameButton.setImageOnHover("Images/SplashScreen/HardHover.png");
  splashScreenItems.add(hardGameButton);
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


void setupPowerUps() {
  PowerUp powerUp = new PowerUp("Images/Game/powerup.png");
  objects.add(powerUp);
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
    
    Player p = new Player(0, "Images/Game/Player.png", playerXML);
   objects.add(p);         
  }
}
