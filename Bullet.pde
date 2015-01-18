class Bullet extends GameObject{
  PVector forward = new PVector(0,-1);
  
  Bullet(float x, float y, float theta) {
    this.pos = new PVector(x, y);
    this.speed = 10.0f;
    this.theta = theta;
    this.alive = true;
  }
  
  void move() {
    // Check to see if bullet has gone off screen
    // once bullet is off screen it is dead.
    if(pos.x > width) {
      alive = false;
    } else if(pos.x <= 0){
      alive = false;
    } else if(pos.y > height){
      alive = false;
    } else if(pos.y <= 0){
      alive = false;
    }
    
    forward.x = sin(theta);
    forward.y = -cos(theta);
    
    PVector velocity = PVector.mult(forward, speed);
    pos.add(forward);
  }
  
  void display(){
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);
    line(0, -5, 0, 5);
    popMatrix();
  }
  
  boolean isAlive(){
    return alive;
  }
}
