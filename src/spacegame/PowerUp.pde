class PowerUps {
  int x, y, diam, speed;
  char type;
  //PImage powerUps;

  //Contructor
  PowerUps() {
    x = int(random(width));
    y = -50;
    diam = int(random(50, 100));
    speed = int(random(2, 10));
   // powerUps = loadImage("powerup.png");
   int rand = int(random(3));
    if (rand==0) {
      type = 'A';
    } else if (rand==1) {
      type = 'H';
    } else {
      type ='T';
    }
    }
  

  void display() {
    fill(0, 222, 0);
    ellipse(x, y, diam, diam);
    fill(0);
    text(type,x,y);
    //powerUps.resize(diam, diam);
    //imageMode(CENTER);
   // image(powerUps, x, y);
  }

  void move() {
    y += speed;
  }

  boolean reachedBottom() {
    if (y>height) {
      return true;
    } else {
      return false;
    }
  }
boolean intersect(SpaceShip ship) { 
  float d = dist (x,y,ship.x,ship.y);
  if (d<50) {
    return true;
  } else {
    return false;
  }
}
}
