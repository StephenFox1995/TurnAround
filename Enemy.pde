/* An enemy can come from any of the four directions
 * upon intilisation it is randomly chosen for the
 * enemy which direction they will spawn.
 * i.e. spawn and enter game area from north, south
 * east, west.
 */
class Enemy extends GameObject{
  
  int sideToSpawn;
  String directionToMove = ""; // Direction to move will always be opposite of sideToSpawn
  
  Enemy() {  
    this.speed = 5.0f;
    this.alive = true;
    
    // set spawn
    setupSpawnOrigin();
  }
  
  private void setupSpawnOrigin(){
    // Determine the side the enemy will spawn
    sideToSpawn = (int)random(0, 4);
    println(sideToSpawn);
    
    switch(sideToSpawn){
      //0 - North
      case 0:
        // Setup left spawn;
        this.pos = new PVector(random(w, width), random(-height * 2, 0));
        directionToMove = "South";
        break;
     
     //1 - East   
     case 1:
       this.pos = new PVector(random(width, width *2), random(h, height));
       directionToMove = "West";
       break;
     
     //2 - South
     case 2:
       this.pos = new PVector(random(w, width), random(height, height* 2));
       directionToMove = "North";
       break;
     
     //3 - West
     case 3:
     this.pos = new PVector(random(-width*2, 0), random(h, height));
     directionToMove = "East";
     break;
    }
  }
  
  void update(){
    // If offscreen, kill!
    if (directionToMove == "South" && pos.y > height) {
      kill();
    } else if(directionToMove == "North" && pos.y < 0){
      kill();
    } else if (directionToMove == "East" && pos.x > width) {
      kill();
    } else if(directionToMove == "West" && pos.x < 0) {
      kill();
    }
  }
  
  
  void kill(){
    alive = false;
  }
  
  void display(){
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    ellipse(10, 10, 10, 10);
    popMatrix();
  }
  
  void move(){
    
    if(directionToMove == "South") {
      pos.y += speed;
    } else if (directionToMove == "North") {
      pos.y -= speed;
    } else if(directionToMove == "East") {
      pos.x += speed;
    } else if(directionToMove == "West") {
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
