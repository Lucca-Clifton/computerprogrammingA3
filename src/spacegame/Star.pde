class Star {
  int x, y, diam, speed;
  //PImage rock;

  //Contructor
  Star() {
    x = int(random(width));
    y = int(random(height));
    diam = int(random(1, 4));
    speed = int(random(1, 2));
  }

  void display() {
    noStroke();
    fill(255, 255, 255);
    ellipse(x, y, diam, diam);
  }

  void move() {
    if (y>height+5) {
      y = -5;
    } else {
      y += speed;
    }
  }

  boolean reachedBottom() {
    return true;
  }
}
