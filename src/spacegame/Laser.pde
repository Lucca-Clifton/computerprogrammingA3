class Laser {
  int x, y, w, h, speed;
  color c1;
  //PImage laser;

  //Contructor
  Laser(int x, int y) {
    this.x=x;
    this.y=y;
    w = 4;
    h = 10;
    speed = 5;
    c1=color(#98E8E6);
  }

  void display() {
    rectMode(CENTER);
    fill(c1);
    noStroke();
    rect(x, y, w, h);
  }

  void move() {
    y -= speed;
  }

  boolean reachedTop() {
    if (y<-0) {
      return true;
    } else {
      return false;
    }
  }
}
