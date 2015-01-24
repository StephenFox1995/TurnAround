class PowerUp extends GameObject{
  
  PImage image;
  int sideToSpawn;
  Direction directionToMove;
  String type;
  boolean active;
  PVector HUDPos;
  
  
  PowerUp(String imageName) {
    this.w = 20;
    this.h = 20;
    this.image = loadImage(imageName);
    this.colour = color(0, 255, 0);
    this.speed = 10;
    this.active = true;
    setupSpawnOrigin();
  }
  
  
  void display(){
    pushMatrix();
    fill(colour);
    stroke(colour);
    translate(pos.x, pos.y);
    rotate(theta);
    image(image, 0, 0);
    displayInHUD();
    popMatrix();
  }
  
  void update() {
    // If offscreen, kill!
    if (directionToMove == Direction.South && pos.y > height) {
      kill();
    } else if(directionToMove == Direction.North && pos.y < 0){
      kill();
    } else if (directionToMove == Direction.East && pos.x > width) {
      kill();
    } else if(directionToMove == Direction.West && pos.x < 0) {
      kill();
    }
  }
  
  void move(){
    
    if(directionToMove == Direction.South) {
      pos.y += speed;
    } else if (directionToMove == Direction.North) {
      pos.y -= speed;
    } else if(directionToMove == Direction.East) {
      pos.x += speed;
    } else if(directionToMove == Direction.West) {
      pos.x -= speed;
    }
  }
  
  void displayInHUD() {
  }
  
  void kill(){
    active = false;
  }
  
  boolean isActive(){
    if (active){
      return true;
    } else {
      return false;
    }
  }
  
   void setupSpawnOrigin(){
    // Determine the side the enemy will spawn
    sideToSpawn = (int)random(0, 4);
    
    switch(sideToSpawn){
      //0 - North
      case 0:
        this.pos = new PVector(random(w, width - 2), random(-height * 2, 0));
        directionToMove = Direction.South;
        break;
     
     //1 - East   
     case 1:
       this.pos = new PVector(random(width, width *2), random(h, height));
       directionToMove = Direction.West;
       break;
     
     //2 - South
     case 2:
       this.pos = new PVector(random(w, width - w), random(height, height* 2));
       directionToMove = Direction.North;
       break;
     
     //3 - West
     case 3:
     this.pos = new PVector(random(-width*2, 0), random(h, height));
     directionToMove = Direction.East;
     break;
    }
  }
}
  
