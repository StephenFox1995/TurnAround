class Player extends GameObject {
  
  PVector pos;
  char up;
  char down;
  char left;
  char right;
  char start;
  char button1;
  char button2;
  int index;
  color colour;
  boolean allowedToMove;
  boolean allowedToShoot;
  
  float healthBarLength;
  float healthBarPosition;
  
  float speedPowerUpTime = 5;
  boolean speedBoost = false;
  float speedPowerUpTimeEllapsed = 0.0f;
  
  float shieldPowerUpTime = 6;
  boolean shieldActive = false;
  float shieldPowerUpTimeEllapsed = 0.0f;
  int shieldSize = 40;
  
  float fireRate = 10.0f;
  float ellapsed = 0.0f;
  float toPass = 1.0f / fireRate;
  
  AudioPlayer audioPlayer;
  AudioInput input;
  
    
  Player(){
    this.health = 100.0f;
    this.alive = true;
    this.theta = 0;
    this.speed = 5;
    this.pos = new PVector(width / 2, height / 2);
    this.radius = 20;
    this.theta = 0;
    
  }
  
  Player(int index, char up, char down, char left, char right, char start, char button1, char button2, String imageName)
  {
    this();
    this.colour = color(125,125,125);
    this.index = index;
    this.up = up;
    this.down = down;
    this.left = left;
    this.right = right;
    this.start = start;
    this.button1 = button1;
    this.button2 = button2;
    this.image = loadImage(imageName);
    audioPlayer = minim.loadFile("pew.wav");
    setupPlayer();
    
  }
  
  Player(int index, String imageName, XML xml)
  {
    this(index
        , buttonNameToKey(xml, "up")
        , buttonNameToKey(xml, "down")
        , buttonNameToKey(xml, "left")
        , buttonNameToKey(xml, "right")
        , buttonNameToKey(xml, "start")
        , buttonNameToKey(xml, "button1")
        , buttonNameToKey(xml, "button2")
        , imageName
        );
  }
  
  void setupPlayer() {
      
      // Restrict movement for second player 
      if(index == 1) {
        this.pos = new PVector(width/2, height/2);
        this.allowedToMove = false;
        this.allowedToShoot = true;
        this.healthBarLength = width * 0.2;
        this.healthBarPosition = height * 0.1f;
      }
      else if(index == 0) {
        this.pos = new PVector(width/2 - radius-10, height/2);
        this.allowedToMove = true;
        this.allowedToShoot = false;
        this.healthBarLength = width * 0.2;
        this.healthBarPosition = height * 0.03f;
      }
  }
  
  void display(){
    
    displayHealthBar();
    
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);  
    stroke(colour);
    fill(colour);
    image(image, -radius/2, -radius/2);
    popMatrix();
  }
  
  void displayHealthBar() {
    
    int playerNumber = index + 1;
    stroke(255);
    
    pushMatrix();
    text("P" + playerNumber, width * 0.01, healthBarPosition);
    translate(width * 0.05, healthBarPosition);
    stroke(0, 255, 0);
    strokeWeight(4);
    line(0, 0, healthBarLength, 0);
    popMatrix();
    
  }
  
  boolean collides(GameObject object) {
    float distance = PVector.dist(object.pos, pos);
    return(distance < object.radius + radius);
  }
  
  void decreaseHealthBar(float amount) {
    
    if(!shieldActive) {
      health -= amount;
      if (healthBarLength <=0){
        healthBarLength = healthBarLength;
        alive = false;
      } else {
        healthBarLength -= amount;
      }
    }
  }
  
  
  void update() {   
    if(pos.x > width) {
      pos.x = pos.x - width;
    }
    if(pos.x < 0) {
      pos.x = pos.x + width;
    }
    if(pos.y > height) {
      pos.y = pos.y - height;
    }
    if(pos.y < 0){
      pos.y = pos.y + height;
    }
  }
  
  
  void move() {
    
    PVector forward = new PVector(sin(theta) * speed, -cos(theta) * speed);
    
    ellapsed += timeDelta;
    
    if(checkKey(left)) {
      theta -= 0.1f;
    }    
    if(checkKey(right)) {
      theta += 0.1f;
    }
    if(checkKey(up) && allowedToMove) {
      pos.add(forward);
    }
    if(checkKey(down) && allowedToMove) {
      pos.sub(forward);
    }
    if (checkKey(start)) {
      println("Player " + index + " start");
    }
    if (checkKey(button1) && allowedToShoot) {
      if(ellapsed > toPass) {
           
           audioPlayer.play();
           audioPlayer.rewind();
           
           Bullet bullet = new Bullet(pos.x, 
                                      pos.y, 
                                      objects.get(1).theta);
           objects.add(bullet);
           ellapsed = 0.0f;
        }
      
    } 
    if (checkKey(button2)) {
      println("Player " + index + " button 2");
    }
    
  }
  
  boolean isAlive(){
    if(alive) {
      return true;
    } else {
      return false;
    }
  }
  
  
  void activatePowerUp(int type) {
    switch(type) {
      case 0:
      speedBoost = true;
      break;
      
      case 1:
      increaseHealthBar(20);
      break;
      
      case 2:
      shieldActive = true;
      break;
      
      default: 
      break;
    }
  }
  
  void speedBoost() {
    
    speedPowerUpTimeEllapsed += timeDelta;
    
    if(speedBoost && speedPowerUpTimeEllapsed < speedPowerUpTime ) {
      speed = 10;
    } 
    else {
      speedPowerUpTimeEllapsed = 0;
      speedBoost = false;
      speed = 5;
    }
  }
  
  
  void increaseHealthBar(float amount) {
    health += amount;
    if(healthBarLength >= width * 0.2) {
      healthBarLength = healthBarLength;
    }
    else {
      healthBarLength += amount;
    }
  }
  
  
  void activateShield() {
    
    shieldPowerUpTimeEllapsed += timeDelta;
    
    if(shieldActive && shieldPowerUpTimeEllapsed < shieldPowerUpTime){
      strokeWeight(1);
      stroke(0, 255, 0);
      fill(0,0,0,0);
      ellipse(pos.x, pos.y, shieldSize, shieldSize);
    }
    else {
      shieldPowerUpTimeEllapsed = 0;
      shieldActive = false;
    }
  }
}
