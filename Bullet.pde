class Bullet extends GameObject{
  PVector forward;
  float toLive = 5.0f;
  
  
  Bullet(float x, float y, float theta) {
    this.colour = color(255, 0, 255);
    this.pos = new PVector(x, y);
    this.speed = 20.0f;
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
    
    forward = new PVector(sin(theta) * speed, -cos(theta) * speed);
    pos.add(forward);
  }
  
  void update() {
    if(pos.x > width || pos.x < 0 || pos.y > height || pos.y < 0){
      kill();  
    }
  }
  
  void kill() {
    alive = false;
  }
  
  void display(){
    pushMatrix();
    fill(colour);
    stroke(colour);
    translate(pos.x, pos.y);
    rotate(theta);
    line(0, -5, 0, 5);
    popMatrix();
  }
  
  boolean isAlive(){
    if (alive){
      return true;
    } else {
      return false;
    }
  }
}
