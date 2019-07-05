import processing.sound.*;

PFont f;
int counter = 0;
int fontSize = 300;
int buttonFontSize = 30;
boolean changeNumber = true;
int upperLimit = 1;
int lowerLimit = 0;
ArrayList listChosen = new ArrayList();
String upperLimitText = "";
String lowerLimitText = "";
String box = "upper";
String screen = "option";
int lowerButtonHeight;
int lowerButtonWidth;
int upperButtonHeight;
int upperButtonWidth;
int okButtonHeight;
int okButtonWidth;
int backButtonHeight;
int backButtonWidth;
int cheatButtonHeight;
int cheatButtonWidth;
SoundFile file;

//Cheat Command
String cheatNumberText = "";
int cheatNumber = 0;
boolean cheatOn = false;
boolean soundOn = true;

void setup() {
  size(500, 500);
  lowerButtonHeight = height/2+50+2;
  lowerButtonWidth = width/2-40;
  upperButtonHeight = height/2+2;
  upperButtonWidth = width/2-40;
  okButtonHeight = 403;
  okButtonWidth = width/2;
  backButtonHeight = 12;
  backButtonWidth = width-56;
  cheatButtonHeight = 14;
  cheatButtonWidth = 60;
  background(255);
  f = createFont("orange_kid.ttf", fontSize);
  textFont(f);
  textAlign(CENTER, CENTER);
  file = new SoundFile(this, "piao.mp3");
} 

void draw() {
  if(screen.equals("option")) {
    getLimits();
  } else if(screen.equals("piao")) {
    piaoDaCasaPropria();
  }
  textSize(30);
  textAlign(CENTER, CENTER);
  text("Developed by Mago Technologies", width/2, height-30);
}

void piaoDaCasaPropria() {
  if(changeNumber) {
    counter = (int)random(lowerLimit, upperLimit+1);
  }
  printCounter();
  textSize(20);
  text("BACK", backButtonWidth, backButtonHeight);
  textAlign(LEFT, CENTER);
  if(listChosen.size() > 20) {
    text(listChosen.subList(0, 20).toString(), 30, height-80);
    text(listChosen.subList(20, listChosen.size()).toString(), 30, height-60);
  } else {
    text(listChosen.toString(), 30, height-80);
  }
  rectMode(CENTER);
  noFill();
  stroke(0);
  rect(width-56, 14, 50, 20, 3);
  textSize(fontSize);
  textAlign(CENTER, CENTER);
}

void keyReleased() {
  if(screen.equals("piao")) {
    if(key == ' ') {
      while(listChosen.contains(counter)) {
        counter = (int)random(lowerLimit, upperLimit+1);
        printCounter();
      }
      if(changeNumber == true) {
        if(cheatOn) {
          counter = cheatNumber;
        }
        if(soundOn) {
          file.stop();
        }
        listChosen.add(counter);
      } else {
        if(soundOn) {
          file.play();
        }
      }
      changeNumber = !changeNumber;
    }
  }
  if(screen.equals("option")) {
    if(key == '0' || key == '1' || key == '2' || key == '3' || key == '4' || key == '5' || key == '6' || key == '7' || key == '8' || key == '9') {
      if(box.equals("upper") && upperLimitText.length() < 10) {
        upperLimitText += key;
      } else if(box.equals("lower") && lowerLimitText.length() < 10) {
        lowerLimitText += key;
      } else if(box.equals("cheat") && cheatNumberText.length() < 10 && cheatOn) {
        cheatNumberText += key;
      }
    }
    if(key == BACKSPACE) {
      if(box.equals("upper")) {
        if(upperLimitText.length() > 0) {
          upperLimitText = upperLimitText.substring(0, upperLimitText.length()-1);
        }
      } else if(box.equals("lower")) {
        if(lowerLimitText.length() > 0) {
          lowerLimitText = lowerLimitText.substring(0, lowerLimitText.length()-1);
        }
      } else if(box.equals("cheat") && cheatOn) {
        if(cheatNumberText.length() > 0) {
          cheatNumberText = cheatNumberText.substring(0, cheatNumberText.length()-1);
        }
      }
    }
  }
}

void mouseClicked() {
  if(screen.equals("option")) {
    if(mouseX > width/2-90 && mouseY > lowerButtonHeight-30 && mouseY < lowerButtonHeight+30) {
      box = "lower";
    } else if(mouseX > width/2-90 && mouseY > upperButtonHeight-30 && mouseY < upperButtonHeight+30) {
      box = "upper";
    } else if(mouseX > width/2-17 && mouseY < 450 && mouseY > 370 && upperLimitText.length() > 0 && lowerLimitText.length() > 0) {
      upperLimit = Integer.parseInt(upperLimitText);
      lowerLimit = Integer.parseInt(lowerLimitText);
      if(upperLimit > lowerLimit) {
        if(cheatOn) {
          cheatNumber = Integer.parseInt(cheatNumberText);
          if(cheatNumber >= lowerLimit && cheatNumber <= upperLimit) {
            if(soundOn) {
              file.play();
            }
            screen = "piao";
          }
        } else {
          if(soundOn) {
            file.play();
          }
          screen = "piao";
        }
      }
    } else if(mouseX > cheatButtonWidth-20 && mouseX < cheatButtonWidth+25 && mouseY > cheatButtonHeight-20 && mouseY < cheatButtonHeight+20) {
       cheatOn = !cheatOn;
    } else if(cheatOn && mouseX > cheatButtonWidth+35 && mouseX < cheatButtonWidth+100 &&  mouseY > cheatButtonHeight && mouseY < cheatButtonHeight+40) {
       box = "cheat";
    }  else if(mouseX > width-30-20 && mouseX < width-30+20 && mouseY > 15-20 && mouseY < 15+20) {
       soundOn = !soundOn;
    }
  }
  if(screen.equals("piao")) {
    if(mouseX > backButtonWidth-20 && mouseY > backButtonHeight-20 && mouseY < backButtonHeight+20) {
      if(file.isPlaying()) {
        file.stop();
      }
      screen = "option";
      listChosen = new ArrayList();
      changeNumber = true;
      counter = 0;
    }
  }
}

void printCounter() {
  textSize(fontSize);
  background(255);
  fill(0);
  text(counter, width/2, height/2);
}

void getLimits() {
  background(255);
  fill(0);
  textSize(20);
  textAlign(LEFT, CENTER);
  text("CHEAT: ", cheatButtonWidth-50, cheatButtonHeight-2);
  if(cheatOn) {
    text("ON", cheatButtonWidth, cheatButtonHeight-2);
    text("CHEAT NUMBER: "+cheatNumberText, cheatButtonWidth-50, cheatButtonHeight-2+20);
    text("________", cheatButtonWidth+55, cheatButtonHeight-2+21);
  } else {
    text("OFF", cheatButtonWidth, cheatButtonHeight-2);
  }
  rectMode(CENTER);
  noFill();
  stroke(0);
  text("SOUND", backButtonWidth-40, backButtonHeight);
  if(soundOn) {
    text("ON", width-42, 12);
  } else {
    text("OFF", width-42, 12);
  }
  rect(width-30, 15, 30, 20, 3);
  textSize(buttonFontSize);
  textAlign(LEFT, CENTER);
  text("Upper limit: "+upperLimitText, upperButtonWidth-110, upperButtonHeight-2);
  text("Lower limit: "+lowerLimitText, lowerButtonWidth-110, lowerButtonHeight-2);
  text("__________", upperButtonWidth, upperButtonHeight);
  text("__________", lowerButtonWidth, lowerButtonHeight);
  noFill();
  stroke(0);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  rect(okButtonWidth, okButtonHeight, buttonFontSize, buttonFontSize, 3);
  rectMode(CORNER);
  rect(cheatButtonWidth-2, cheatButtonHeight-10, 30, 20, 3);
  text("OK", okButtonWidth, okButtonHeight-3);
  textSize(fontSize);
}
