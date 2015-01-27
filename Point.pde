class Point extends GameObject {
  
  float pointTime = 10;
  float timeElapsed = 0;
  
  Point() {
    this.radius = 20;
    this.pos = new PVector(random(0, width - radius), random(0, height - radius));
  }
  
  void display() {
    timeElapsed += timeDelta;
    println(timeElapsed);
    
    if(timeElapsed >= pointTime){
      moveToNewPosition();
    } else {
      stroke(255);
      fill(255);
      rect(pos.x, pos.y, radius, radius);
    }
    
  }
  
  void update() {
  }
  
  
  void moveToNewPosition() {
    timeElapsed = 0;
    pos = new PVector(random(0, width - radius), random(0, height - radius));
  }
  
}
