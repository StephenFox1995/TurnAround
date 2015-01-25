/* An enemy can come from any of the four directions
 * upon intilisation it is randomly chosen for the
 * enemy which direction they will spawn.
 * i.e. spawn and enter game area from north, south
 * east, west.
 */

class Enemy extends GameObject{
  
  int sideToSpawn;
  Direction directionToMove;
  
  Enemy() {
    this.colour = color(255); 
    this.speed = 2.0f;
    this.alive = true;
    this.radius = 10;
    
    // Set spawn
    setupSpawnOrigin();
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
  
  
  
  // Respawns enemy to new co-ordinates
  void respawn() {
    alive = true;
    setupSpawnOrigin();
  }
  
  void kill(){
    alive = false;
  }
  
  void display(){
    pushMatrix();
    fill(colour);
    stroke(colour);
    translate(pos.x, pos.y);
    rotate(theta);
    ellipse(0, 0, radius, radius);
    popMatrix();
  }
  
  void move(){
    
    if(directionToMove == Direction.South) {
      pos.y += speed;
    } else if (directionToMove == Direction.North) {
      pos.y -= speed;
    } else if(directionToMove == Direction.East) {
      pos.x += speed;
    } else if(directionToMove == Direction.North) {
      pos.x -= speed;
    }
  }
  
  boolean isAlive(){
    if (alive){
      return true;
    } else {
      return false;
    }
  }

}
