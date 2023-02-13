//Lucca Clifton | Nov 2022 | Calculator
Button[] numButtons = new Button[10];
Button[] opButtons = new Button[12];
String dVal = "0";
boolean left = true;
boolean newNum = false;
float l, r, result;
char  op = ' ';

void setup() {
  size(320, 540);
  numButtons[0] = new Button(20, 460, 140, 60, '0');
  numButtons[1] = new Button(20, 380, 60, 60, '1');
  numButtons[2] = new Button(100, 380, 60, 60, '2');
  numButtons[3] = new Button(180, 380, 60, 60, '3');
  numButtons[4] = new Button(20, 300, 60, 60, '4');
  numButtons[5] = new Button(100, 300, 60, 60, '5');
  numButtons[6] = new Button(180, 300, 60, 60, '6');
  numButtons[7] = new Button(20, 220, 60, 60, '7');
  numButtons[8] = new Button(100, 220, 60, 60, '8');
  numButtons[9] = new Button(180, 220, 60, 60, '9');

  opButtons[0] = new Button(260, 460, 40, 60, '=');
  opButtons[1] = new Button(260, 380, 40, 60, '+');
  opButtons[2] = new Button(260, 300, 40, 60, '-');
  opButtons[3] = new Button(260, 220, 40, 60, '*');
  opButtons[4] = new Button(260, 140, 40, 60, '÷');
  opButtons[5] = new Button(180, 460, 60, 60, '.');
  opButtons[6] = new Button(260, 80, 40, 40, '_');
  opButtons[7] = new Button(20, 20, 120, 40, '√');
  opButtons[8] = new Button(180, 20, 120, 40, 'o');
  opButtons[9] = new Button(180, 160, 60, 40, 's');
  opButtons[10] = new Button(20, 160, 60, 40, 'C');
  opButtons[11] = new Button(100, 160, 60, 40, '?');
}

void draw() {
  background(#EDE9E3); //background
  for (int i=0; i<numButtons.length; i++) {
    numButtons[i].display();
    numButtons[i].hover(mouseX, mouseY);
  }
  for (int i=0; i<opButtons.length; i++) {
    opButtons[i].display();
    opButtons[i].hover(mouseX, mouseY);
  }
  updateDisplay();
}

void keyPressed() {
  println("key:" + key);
  println("keyCode:" + keyCode);
  if (keyCode == 49 || keyCode==97) {
    handleEvent("1", true);
  } else if (keyCode ==46 || keyCode ==110) {
    handleEvent(".", true);
  } else if (keyCode ==98 || keyCode ==50) {
    handleEvent("2", true);
  } else if (keyCode ==99 || keyCode ==51) {
    handleEvent("3", true);
  } else if (keyCode ==100 || keyCode ==52) {
    handleEvent("4", true);
  } else if (keyCode ==53 || keyCode ==101) {
    handleEvent("5", true);
  } else if (keyCode ==102 || keyCode ==54) {
    handleEvent("6", true);
  } else if (keyCode ==103 || keyCode ==55) {
    handleEvent("7", true);
  } else if (keyCode ==104 || keyCode ==56) {
    handleEvent("8", true);
  } else if (keyCode ==105 || keyCode ==57) {
    handleEvent("9", true);
  } else if (keyCode ==96 || keyCode ==48) {
    handleEvent("0", true);
  }
}

void handleEvent(String val, boolean num) {
  if (num && dVal.length () <8) {
    if (dVal.equals("0.0")) {
      dVal=val;
    } else {
      dVal+=val;
      if (left) {
        l =  float(dVal);
      } else {
        r = float(dVal);
      }
    }
  } else if (val.equals("C")) {
    dVal="0.0";
    left = true;
    l = 0.0;
    r = 0.0;
    result = 0.0;
    op = ' ';
  } else if (val.equals (".")) {
    if (!dVal.contains(".")) {
      dVal += ".";
    }
  }
}

void mouseReleased() {
  for (int i=0; i<numButtons.length; i++) {
    if (numButtons[i].on) {
      handleEvent(str(numButtons[i].val), true);
    }
  }

  for (int i=0; i<opButtons.length; i++) {
    if (opButtons[i].on && opButtons[i].val == 'C') {
      handleEvent(str(opButtons[i].val), false);
    } else if (opButtons[i].on && opButtons[i].val == '+') {
      op='+';
      dVal = "0.0";
      left = false;
      //dVal = str(op);
    } else if (opButtons[i].on && opButtons[i].val == '-') {
      op='-';
      dVal = "0.0";
      left = false;
      //dVal = str(op);
    } else if (opButtons[i].on && opButtons[i].val == '*') {
      op='*';
      dVal = "0.0";
      left = false;
      //dVal = str(op);
    } else if (opButtons[i].on && opButtons[i].val == '÷') {
      op='÷';
      dVal = "0.0";
      left = false;
      //dVal = str(op);
    } else if (opButtons[i].on && opButtons[i].val == 'o') {
      //dVal = str(op);
    } else if (opButtons[i].on && opButtons[i].val == '√') {
      //dVal = str(op);
    } else if (opButtons[i].on && opButtons[i].val == '?') {
      // dVal = str(op);
    } else if (opButtons[i].on && opButtons[i].val == '.') {
      handleEvent(".", false);
    } else if (opButtons[i].on && opButtons[i].val == 's') {
      // dVal = str(op);
    } else if (opButtons[i].on && opButtons[i].val == '=') {
      op='=';
      performCalculation();
    } else if (opButtons[i].on && opButtons[i].val == '_') {
      if (left) {
        l = l *-1;
        dVal = str(r);
      } else {
        r= r*-1;
        dVal=str(l);
      }
    }
  }
  println("l:" + l + " r:" + r + " op:" + op + " result:" + result + " left:" + left);
}

void updateDisplay() {
  fill(#66747C); //result color
  rect(20, 80, 220, 60);
  fill(10);
  textAlign(RIGHT);
  text(dVal, 100, 120);
  if (dVal.length() <8) {
    textSize(40);
  } else if (dVal.length() <9) {
    textSize(38);
  } else if (dVal.length() <10) {
    textSize(36);
  } else if (dVal.length() <11) {
    textSize(34);
  } else {
    textSize(24);
  }
}

void performCalculation() {
  if (op == '+') {
    result = l + r;
  } else if (op == '-') {
    result = l - r;
  } else if (op == '*') {
    result = l * r;
  } else if (op == '÷') {
    result = l/r;
  }
  dVal = str(result);
  l = result;
  left = true;
}
