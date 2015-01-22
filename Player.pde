class Player extends GameObject {
  PVector pos;
  char up;
  char down;
  char left;
  char right;
  char start;
  char button1;
  char button2;
  int index;
  color colour;
  PImage image;
  float healthBarLength = width * 0.2;
  
  float fireRate = 10.0f;
  float ellapsed = 0.0f;
  float toPass = 1.0f / fireRate;
    
  Player(){
    this.health = 100.0f;
    this.alive = true;
    this.theta = 0;
    this.speed = 3;
    this.pos = new PVector(width / 2, height / 2);
    this.h = 20;
    this.w = 20;
    this.theta = 0;
  }
  
  Player(int index, color colour, char up, char down, char left, char right, char start, char button1, char button2)
  {
    this();
    this.index = index;
    this.colour = colour;
    this.up = up;
    this.down = down;
    this.left = left;
    this.right = right;
    this.start = start;
    this.button1 = button1;
    this.button2 = button2;
  }
  
  Player(int index, color colour, XML xml)
  {
    this(index
        , colour
        , buttonNameToKey(xml, "up")
        , buttonNameToKey(xml, "down")
        , buttonNameToKey(xml, "left")
        , buttonNameToKey(xml, "right")
        , buttonNameToKey(xml, "start")
        , buttonNameToKey(xml, "button1")
        , buttonNameToKey(xml, "button2")
        );
  }
  
  
  void display(){
    
    float halfWidth = w / 2;
    float halfHeight = h /2;
    displayHealthBar();
    
    pushMatrix();
    
    translate(pos.x, pos.y);
    rotate(theta);  
    
    stroke(colour);
    strokeWeight(1);
    fill(colour);

    line(-halfWidth, halfHeight, 0, - halfHeight);
    line(0, - halfHeight, halfWidth, halfWidth);
    line(halfWidth, halfHeight, 0, 0);
    line(0,0,  - halfWidth, halfHeight);
        
    popMatrix();
    
  } 
  
  // Displays players health bar
  void displayHealthBar() {
    
    pushMatrix();
    translate(width * 0.05, height * 0.05);
    stroke(0, 255, 0);
    strokeWeight(4);
    line(0, 0, healthBarLength, 0);
    popMatrix();
    
  }
  
  // Decrease amount from heatlh bar
  void decreaseHealthBar(float amount) {
    healthBarLength = healthBarLength - (healthBarLength * 0.5);
  }
  
  void update() {
    ellapsed += timeDelta;
    
    if (checkKey(left)) {
      theta -= 0.1f;
    }    
    if (checkKey(right)) {
      theta += 0.1f;
    }
    if(checkKey(up)) {
      //pos.y -= speed;
    }
    if(checkKey(down)) {
      //pos.y += speed;
    }
    if (checkKey(start)){
      println("Player " + index + " start");
    }
    if (checkKey(button1)) { 
         if(ellapsed > toPass) {
         
           Bullet bullet = new Bullet(pos.x, 
                                      pos.y, 
                                      objects.get(0).theta);
           objects.add(bullet);
           ellapsed = 0.0f;
         }
    }
    if (checkKey(button2)) {
      println("Player " + index + " button 2");
    }    
  }
  
  boolean isAlive(){
    return alive;
  }
   
}
