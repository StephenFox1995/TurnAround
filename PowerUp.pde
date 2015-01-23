class PowerUp extends GameObject{
  PImage image;
  
  
  PowerUp(String imageName) {
    this.w = 15;
    this.h = 15;
    this.image = loadImage(imageName);
    this.colour = color(0, 255, 255);
    setupSpawn();
  }
  
  void setupSpawn() {
    this.pos = new PVector(random(0, (width - w)), random(0, (height - h)));
  }
  
  void display() {
    fill(colour);
    stroke(colour);
    image(image, pos.x, pos.y);
  }
  
  void update() {
  }
  
  void move() {
  }
}
  
