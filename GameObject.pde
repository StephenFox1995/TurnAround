class GameObject{
  
  PVector pos;
  float w;
  float h;
  color colour;
  float speed;
  float theta;
  boolean alive;
  float timeDelta = 1.0f/ 60.0f;
  float health;
  float radius;
  PImage image;
  
  void display() {
  }
 
  void update() {
  }
  
  void move() {
  }
  
  void respawn() {
  }
  
  boolean isAlive(){
    return false;
  }
  
  boolean collides(GameObject object) {
    return false;
  }

  
  
}
