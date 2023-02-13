//Lucca Clifton | Nov 28 | SpaceGame
import processing.sound.*;
SoundFile blaster, explosion;
SpaceShip s1;
Timer rockTimer, powerUpTimer;
ArrayList<Rock> rocks = new ArrayList<Rock>();
ArrayList<PowerUps> powerUps = new ArrayList<PowerUps>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
Star [] stars = new Star[100];
int score, level, rockCount, laserCount, health, ammo, rocksPassed;
boolean play;

void setup () {
  size (800, 800);
  blaster = new SoundFile(this, "blaster.wav");
  explosion = new SoundFile(this, "explode.wav");
  s1 = new SpaceShip();
  rockTimer = new Timer(500);
  rockTimer.start();
  powerUpTimer = new Timer(5000);
  powerUpTimer.start();
  for (int i=0; i<stars.length; i++) {
    stars[i] = new Star();
  }
  score = 0;
  level = 1;
  rockCount = 0;
  laserCount = 0;
  health = 1000;
  ammo = 100;
  play = false;
  rocksPassed = 0;
}

void draw() {
  if (!play) {
    startScreen();
  } else {
    background(15);
    //stars
    for (int i=0; i<stars.length; i++) {
      stars[i].display();
      stars[i].move();
    }
    infoPanel();
    noCursor();
    
    //add powerups
    if (powerUpTimer.isFinished()) {
      powerUps.add(new PowerUps());
      powerUpTimer.start();
    }
    
    //rendering powerups
    for (int i = 0; i < powerUps.size(); i++) {
      PowerUps pu = powerUps.get(i);
      if (pu.intersect(s1)) {
        if(pu.type =='H') {
        s1.health+=100;
        }else if(pu.type == 'A') {
          s1.ammo += 100;
        } else {
          s1.turretCount++;
        }
        powerUps.remove(pu);

      }
      if (pu.reachedBottom()) {
        powerUps.remove(pu);
        //println(rocks.size());
      } else {
        pu.display();
        pu.move();
      }
    }

    // r1.display();
    //r1.move();

    //add rocks
    if (rockTimer.isFinished()) {
      rocks.add(new Rock());
      rockTimer.start();
      println("Rocks:" + rocks.size());
    }
    //rendering rocks
    for (int i = 0; i < rocks.size(); i++) {
      Rock r = rocks.get(i);
      if (s1.intersect(r)) {
        s1.health-=r.diam;
        score-= r.diam;

        //to do: add sound of explosion
        //to do: add animation of explosion
        //to do: visual effect on the ship
        rocks.remove(r);
      }
      if (r.reachedBottom()) {
        rocks.remove(r);
        rocksPassed++;
        println(rocks.size());
      } else {
        r.display();
        r.move();
      }
    }
    //laser and rock collision
    for(int i=0;i<lasers.size(); i++) {
      Laser l = lasers.get(i);
      for (int j=0;j<rocks.size();j++) {
        Rock r = rocks.get(j);
        if (r.intersect(l)) {
          lasers.remove(l);
          r.diam -=50;
          if(r.diam<10) {
            rocks.remove (r);
          }
          score +=100;
        }
        if(l.reachedTop()) {
          lasers.remove(l);
          println(rocks.size());
        } else {
          l.display();
          l.move();
        }
      }
    }

    // r1.display();
    //r1.move();

    //laser add
    if (mousePressed) {
      for (int i=0; i<lasers.size(); i++) {
        Laser l = lasers.get(i);
        if (l.reachedTop()) {
          lasers.remove(l);
        } else {
          l.display();
          l.move();
        }
      }
    }

    //laser rendered
    for (int i = 0; i < lasers.size(); i++) {
      Laser l = lasers.get(i);
      if (l.reachedTop()) {
        lasers.remove(l);
        println(rocks.size());
      } else {
        l.display();
        l.move();
      }
    }
    //l1.display();
    // l1.move();

    //render spaceship
    s1.display();
    s1.move(mouseX, mouseY);

    if (s1.health<1 || rocksPassed>9) {
      gameOver();
    }
  }
}
void mousePressed() {
  blaster.stop();
  blaster.play();
  lasers.add(new Laser(s1.x, s1.y));
}
void keyPressed() {
  blaster.stop();
  blaster.play();
  if (key == ' ') {
    if (s1.fire() && s1.turretCount ==1) {
      lasers.add (new Laser(s1.x, s1.y));
      println("Lasers:" +lasers.size());
      // } else if (s1.fire() && s1.turretCount ==2);
      // lasers.add (new Laser(s1.x-20, s1.y));
      //lasers.add (new Laser(s1.x+20, s1.y));
    }
  }
}

void infoPanel() {
  fill(128, 127);
  rectMode(CENTER);
  rect(width/2, 25, width, 50);
  fill(255);
  PFont mono;
  mono = createFont("hi.otf", 30);
  textFont(mono);
  textSize(30);
  textAlign(LEFT);
  text( "Health:" + s1.health + "| Score: " + score + "Rocks Passed: " + rocksPassed, 15, 30);
}

void startScreen() {
  background (0);
  fill(255);
  textSize(50);
  textAlign(CENTER);
  text("Click or press any key to start...", width/2, height/2);
  if (mousePressed || keyPressed) {
    play = true;
  }
}

void gameOver() {
  background (0);
  fill(255);
  textAlign(CENTER);
  text("Game Over", width/2, height/2);
  textSize(15);
  text("Score" + score, width/2, height/2+25);
  play = false;
  noLoop();
}
