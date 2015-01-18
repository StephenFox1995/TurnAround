/* An enemy can come from any of the four directions
 * upon intilisation it is randomly chosen for the
 * enemy which direction they will spawn.
 * i.e. spawn and enter game area from north, south
 * easr, west.
 */

class Enemy extends GameObject{
  
  int random = (int)random(0, 200);
  int sideToSpawn;
  String directionToMove = "";
  
  Enemy() {  
    
    // Determines the side the enemy will spawn.
    // Mod by four as theres only four possiblities.
    sideToSpawn = random % 4;
    
    
    switch(sideToSpawn){
      //0 - Top
      case 0:
        // Setup left spawn;
        println("NORTH");
        this.pos = new PVector(random(w, width), random(-height * 2, 0));
        directionToMove = "South";
        break;
     
     //1 - Right   
     case 1:
       println("EAST");
       this.pos = new PVector(random(width, width *2), random(h, height));
       directionToMove = "West";
       break;
     
     case 2:
       println("SOUTH");
       this.pos = new PVector(random(w, width), random(height, height* 2));
       directionToMove = "North";
       break;
       
     case 3:
     println("WEST");
     this.pos = new PVector(random(-width*2, 0), random(h, height));
     directionToMove = "East";
     break;
      
    }
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
      pos.y++;
    } else if (directionToMove == "North") {
      pos.y--;
    } else if(directionToMove == "East") {
      pos.x++;
    } else if(directionToMove == "West") {
      pos.x--;
    }
    
  }

}
