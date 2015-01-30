class Point extends GameObject {

  float pointTime = 10;
  float timeElapsed = 0;

  Point() {
    this.radius = 30;
    this.image = loadImage("Images/Game/Point.png");
    this.pos = new PVector(random(0, width - radius), random(height * 0.03f, height - radius));
  }

  void display() {
    timeElapsed += timeDelta;

    if (timeElapsed >= pointTime) {
      moveToNewPosition();
    } else {
      stroke(255);
      fill(255);
      image(image, pos.x, pos.y);
      
    }
  }

  void dupdate() {
  }


  void moveToNewPosition() {
    timeElapsed = 0;
    pos = new PVector(random(0, width - radius), random(0, height - radius));
  }
}

