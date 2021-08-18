String getColorHex(int x, int y) {
  color c = img.get(x, y);
  return hex(c, 6);
}

void decideOnColor(StringList list) {
  String black = "000000";
  String white = "FFFFFF";
  String lightblue = "00BAFF";

  // if list 4 values with FFFFFF
  if (list.hasValue(black)) {
    // black
    colorKreis = #FF0000;
    //println("black");
    if (radiusKreis > 10) {
      radiusKreis -= 1;
    }
  } else if (!list.hasValue(black)) {
    if (list.hasValue(white)) {
      // white
      colorKreis = #00FF00;
    }
  }
  if (!list.hasValue(black) && !list.hasValue(white)){
    if (list.hasValue(lightblue)) {
      // colorKreis-blue: Ziel
      imZiel = true;
    }
  }
}

void colorCollision() {
  // kollisoinsradius ist 1% kleiner als eigentlicher
  int radiusKollision = radiusKreis;
  // use radiusKreis, because changes, when it gets smaller
  int upperMiddleY = mouseY - radiusKollision;
  int lowerMiddleY = mouseY + radiusKollision;
  int leftMiddleX = mouseX - radiusKollision;
  int rightMiddleX = mouseX + radiusKollision;
 
  StringList colorValuesList = new StringList();

  // get color for the four points on circle
  colorValuesList.append(getColorHex(mouseX, upperMiddleY));
  colorValuesList.append(getColorHex(mouseX, lowerMiddleY));
  colorValuesList.append(getColorHex(leftMiddleX, mouseY));
  colorValuesList.append(getColorHex(rightMiddleX, mouseY));
  
  decideOnColor(colorValuesList);
  
}

void generiereScheibe(float startX, float startY) {
  fill(colorKreis);
  strokeWeight(0);
  ellipse(startX, startY, radiusKreis, radiusKreis);
}

void playAgain() {
  if (keyPressed) {
    if (key == CODED) {
      if (keyCode == ENTER || key == RETURN) {
        imZiel = false;
      }
    }
  }
}

void endingScreen(){
  playAgain();
  textSize(100);
  fill(#FFFFFF);
  background(#00BAFF);
  text("You Win", 700, 500);
  textSize(80);
  text("Do you want to play again?", 450, 600);
}
