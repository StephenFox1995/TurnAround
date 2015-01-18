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
    
  Player(){
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
    
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(theta);  
    
    stroke(colour);
    fill(colour);

    line(-halfWidth, halfHeight, 0, - halfHeight);
    line(0, - halfHeight, halfWidth, halfWidth);
    line(halfWidth, halfHeight, 0, 0);
    line(0,0,  - halfWidth, halfHeight);    
    
    popMatrix();
    
  } 
  
  void update() {
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
         Bullet bullet = new Bullet(pos.x, pos.y, objects.get(0).theta);
         objects.add(bullet);
    }
    if (checkKey(button2)) {
      println("Player " + index + " button 2");
    }    
  }
  
   
}
