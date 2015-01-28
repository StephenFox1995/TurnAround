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
AudioPlayer audioPlayer;
AudioInput input;

ArrayList<GameObject> objects = new ArrayList<GameObject>();
ArrayList<SplashScreen> splashScreenItems = new ArrayList<SplashScreen>();
ArrayList<SplashScreen> gameOverSplashScreen = new ArrayList<SplashScreen>();

boolean[] keys = new boolean[526];

float centX;
float centY;
float buttonIndent;

boolean splashScreen = true;
boolean startGame;
boolean gameOver;

PImage splashScreenTitle;
PImage gameOverTitle;

PImage howToPlayInfo;
boolean showGameInfo = false;

Score score = new Score();

Difficulty difficulty;
boolean devMode = false;

Player playerOne;
Player playerTwo;


boolean sketchFullScreen() {
  return !devMode;
}

void setup() {
 
 smooth();
 background(0); 
 minim = new Minim(this);
 audioPlayer = minim.loadFile("soundtrack.mp3");
 audioPlayer.loop();
 
 if(devMode) {
    size(800, 800);
  } else {
    size(displayWidth, displayHeight);
  } 
  
  
  
  centX = width /2;
  centY = height/2;
  buttonIndent = (centX - 110);
  
  // Call these methods to set up
  // all aspects of the game when it 
  // is running
  setUpPlayerControllers();
  setUpSplashScreenAttributes();
  setupPowerUps();
  setupPoint();
  setUpScore();
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
  
  background(0);
  float buttonIndent = (centX - 110);
  
  
  image(splashScreenTitle, width/2 - 225, 50);
  
  if(showGameInfo) {
    image(howToPlayInfo, width/2 - 250, height * 0.15f);
     splashScreenItems.get(4).setToUnHidden();
  }
  
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
    if(splashScreenItems.get(3).clicked()) {
      fill(255);
      stroke(255);
      
      // Hide these elements as we want to overlay
      // how to play instructions.
      splashScreenItems.get(0).setToHidden();
      splashScreenItems.get(1).setToHidden();
      splashScreenItems.get(2).setToHidden();
      splashScreenItems.get(3).setToHidden();
     
      showGameInfo = true; 
      
    }
    if(splashScreenItems.get(4).clicked()) {
      
      splashScreenItems.get(0).setToUnHidden();
      splashScreenItems.get(1).setToUnHidden();
      splashScreenItems.get(2).setToUnHidden();
      splashScreenItems.get(3).setToUnHidden();
      splashScreenItems.get(4).setToHidden();
      
      showGameInfo = false;
    }
  }
}


// Implement gameplay here
void gameRunning(){
  fill(255);
  background(0);
  
  switch(difficulty) {
    case Easy:
      text("EASY", width/2, 40);
      break;
      
    case Medium:
      text("MEDIUM", width/2, 40);
      break;
    
    case Hard:
      text("HARD", width/2, 40);
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
      
      if(!player.isAlive()) {
        setUpGameOverScreen();
        startGame = false;
        gameOver = true; 
      }
      
      // Check if speed boost should be activated
      if(player.speedBoost){
        player.speedBoost();
      }
      
      // Check if shield should be activated
      if(player.shieldActive) {
        player.activateShield();
      }
      
      // Hit detection between player and enemy
      for(int j = 0; j < objects.size(); j++) { 
        if(objects.get(j) instanceof Enemy) {
               
          Enemy enemy = (Enemy)objects.get(j);
          
          if(player.collides(enemy)) {
            player.decreaseHealthBar(20);
            enemy.respawn();
          }
        }
        // Hit detection for player and powerup
        else if(objects.get(j) instanceof PowerUp) {
          
          PowerUp powerUp = (PowerUp)objects.get(j);
          
          if(player.collides(powerUp)) {
            
            // As player one if the one doing all the
            // moving, chances are he/ she will pick up
            // majority of powerups, just apply
            // powerups to all players.
            if(player == playerOne) {
              playerOne.activatePowerUp(powerUp.type);
              playerTwo.activatePowerUp(powerUp.type);
              powerUp.respawn();
            }
            else if(player == playerTwo) {
              playerTwo.activatePowerUp(powerUp.type);
              playerOne.activatePowerUp(powerUp.type);
              powerUp.respawn();
            } 
          }
        }
        
        else if(objects.get(j) instanceof Point) {
          
         Point point = (Point)objects.get(j);
         
         if(player.collides(point)) {
           point.moveToNewPosition();
           score.updateScore(50);
         } 
        }
      }
    }
  }  
}

void gameOver(){
  
  background(0);
  
  int highscore;
  
  image(gameOverTitle,  width/2 - 225, 50);
  
  highscore = score.readScoreFromFile("HighscoreText.txt");
  
  // If new highscore, save it to file
  if(score.scoreValue > highscore) {
    score.saveScoreToFile("HighscoreText.txt");
    text("Highscore: " + score.scoreValue, buttonIndent + 25, height * 0.45f);
  }
  else {
    text("Highscore: " + highscore, buttonIndent + 25, height * 0.45f);
  }
  
  text("Score: " + score.scoreValue, buttonIndent + 40, height * 0.4f);
  
  
  for(int i = 0; i < gameOverSplashScreen.size(); i++) {
    gameOverSplashScreen.get(i).display();
    gameOverSplashScreen.get(i).hover();
    
    if(gameOverSplashScreen.get(0).clicked()) {
       
       // Reset all aspects of the game
       // User will be brought back to splash screen
       objects.clear();
       splashScreenItems.clear();
       gameOverSplashScreen.clear();
       
       setUpPlayerControllers();
       setUpSplashScreenAttributes();
       setupPowerUps();
       setupPoint();
       setUpScore();
       
       splashScreen = true;
       gameOver = false;
       startGame = false;               
    }
  }
  
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
  Button howToPlayButton;
  Button exitGameInfoButton;
  
  
  splashScreenTitle = loadImage("Images/Splashscreen/TurnAround.png");
  howToPlayInfo = loadImage("Images/Splashscreen/HowToPlay.png");
  
  startGameButton = new Button(buttonIndent, height * 0.3f, "Images/Splashscreen/EasyButton.png");
  startGameButton.setImageOnHover("Images/Splashscreen/EasyHover.png");
  splashScreenItems.add(startGameButton);
  
  mediumGameButton = new Button(buttonIndent, height * 0.4f, "Images/Splashscreen/MediumButton.png");
  mediumGameButton.setImageOnHover("Images/SplashScreen/MediumHover.png");
  splashScreenItems.add(mediumGameButton);
  
  hardGameButton = new Button(buttonIndent, height * 0.5f, "Images/Splashscreen/HardButton.png");
  hardGameButton.setImageOnHover("Images/SplashScreen/HardHover.png");
  splashScreenItems.add(hardGameButton);
  
  howToPlayButton = new Button(buttonIndent + 18, height * 0.6f, "Images/Splashscreen/HowToPlayButton.png");
  howToPlayButton.setImageOnHover("Images/SplashScreen/HowToPlayHover.png");
  splashScreenItems.add(howToPlayButton);
  
  exitGameInfoButton = new Button(width * 0.2f, height * 0.16f, "Images/Splashscreen/X.png");
  exitGameInfoButton.setImageOnHover("Images/SplashScreen/XHover.png");
  exitGameInfoButton.w = 45;
  exitGameInfoButton.h = 49;
  splashScreenItems.add(exitGameInfoButton);
  exitGameInfoButton.setToHidden();
}


// Create specific number of enemies
// depending on the difficulty.
void setupEnemies(Difficulty difficulty){
  
  int enemyCount = 0;
  
  switch (difficulty) {
    case Easy:
      enemyCount = 8;
      break;
      
    case Medium:
      enemyCount = 15;
      break;
      
    case Hard:
      enemyCount = 22;
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

void setupPoint() {
  Point point = new Point();
  objects.add(point);
}


void setupPowerUps() {
  // Power Up types
  // 0 - Speed Increase
  // 1 - Health
  // 2 - Shield
  PowerUp speedPowerUp = new PowerUp("Images/Game/SpeedPowerUp.png", 0);
  objects.add(speedPowerUp);
  
  PowerUp heartPowerUp = new PowerUp("Images/Game/HeartPowerUp.png", 1);
  objects.add(heartPowerUp);
  
  PowerUp shieldPowerUp = new PowerUp("Images/Game/ShieldPowerUp.png", 2);
  objects.add(shieldPowerUp);
}

void setUpGameOverScreen(){
  Button playAgainButton = new Button(buttonIndent, height * 0.2, "Images/GameOver/PlayAgain.png");
  playAgainButton.setImageOnHover("Images/GameOver/PlayAgainHover.png");
  gameOverSplashScreen.add(playAgainButton);
  
  gameOverTitle = loadImage("Images/GameOver/GameOver.png");
}


void setUpScore() {
  score.setPosition(width * 0.8f, height * 0.05f);
  score.scoreValue = 0;
  objects.add(score);
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
  
  XML playerOneXML = children[0];
  XML playerTwoXML = children[1];
  
  playerOne = new Player(0, "Images/Game/Player0.png", playerOneXML);
  playerTwo = new Player(1, "Images/Game/Player1.png", playerTwoXML);
  
  objects.add(playerOne);
  objects.add(playerTwo);   
}
