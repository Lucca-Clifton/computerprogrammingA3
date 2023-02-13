class Button {
  //Member Variables
  int x, y, w, h;
  char val;
  color c1, c2;
  boolean on;

  //Constructor
  Button(int x, int y, int w, int h, char val) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h= h;
    this.val = val;
    c1 = color(#C1AB96); //button color
    c2 = color(#DED6CE); //hover color
    on = false;
  }

  void display() {
    if (on) {
      fill(c2);
    } else {
      fill(c1);
    }
    rect(x, y, w, h);
    fill(0);
    textSize(20);
    textAlign(CENTER); 
    if (val=='C') {
      text("clear", x+30, y+30);
    } else if(val=='s') {
    text("x²", x+30,y+30);
    }else if(val=='o') {
    text("π", x+30,y+30);
    
    }else if(val=='_') {
   text("+/-", x+30,y+30);
    }else{
      text(val, x+30, y+30);
    }
    }

    void hover(int mx, int my) {
      on = (mx > x && mx < x+w && my>y && my<y+h);
    }
  }
