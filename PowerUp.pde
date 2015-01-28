class PowerUp extends GameObject{
  
  int sideToSpawn;
  int type;
  PVector HUDPos;
  Direction directionToMove;
  
  
  
  PowerUp(String imageName, int type) {
    this.image = loadImage(imageName);
    this.radius = 20;
    this.colour = color(0, 255, 0);
    this.speed = 2;
    this.alive = true;
    this.type = type;
    setupSpawnOrigin();
  }
  
  
  void display(){
    
    pushMatrix();
    fill(colour);
    stroke(colour);
    translate(pos.x, pos.y);
    rotate(theta);
    image(image, 0, 0);
    popMatrix();
  }
  
  void update() {
    // If offscreen, respawn
    if (directionToMove == Direction.South && pos.y > height) {
      respawn();
    } else if(directionToMove == Direction.North && pos.y < 0){
      respawn();
    } else if (directionToMove == Direction.East && pos.x > width) {
      respawn();
    } else if(directionToMove == Direction.West && pos.x < 0) {
      respawn();
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
  
  void respawn() {
    alive = true;
    setupSpawnOrigin();
  }
  
  void kill(){
    alive = false;
  }
  
  
  void setupSpawnOrigin(){
    // Determine the side the enemy will spawn
    sideToSpawn = (int)random(0, 4);
    
    switch(sideToSpawn){
      //0 - North
      case 0:
        this.pos = new PVector(random(w, width - radius), random(-height * 2, 0));
        directionToMove = Direction.South;
        break;
     
     //1 - East   
     case 1:
       this.pos = new PVector(random(width, width * 4), random(radius, height));
       directionToMove = Direction.West;
       break;
     
     //2 - South
     case 2:
       this.pos = new PVector(random(w, width - radius), random(height, height * 4));
       directionToMove = Direction.North;
       break;
     
     //3 - West
     case 3:
     this.pos = new PVector(random(-width * 4, 0), random(radius, height));
     directionToMove = Direction.East;
     break;
    }
  }
  
  
  boolean collides(GameObject object) {
    float distance = PVector.dist(object.pos, pos);
    return(distance < object.radius + radius);
  }
  
  
  boolean isAlive(){
    if(alive) {
      return true;
    } else {
      return false;
    }
  }
}
  
