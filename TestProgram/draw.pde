void labyrinth() {
  noFill();
  stroke(#FFFFFF);
  strokeWeight(40.0);
  strokeJoin(MITER);
  beginShape();
  // array mit koordinaten
  vertex(50, 80);
  vertex(500, 80);
  vertex(500, 200);
  vertex(100, 400);
  vertex(500, 400);
  vertex(500, 300);
  endShape();
}

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
    light = #FF0000;
    println("black");
    if (radiusKreis > 10) {
      radiusKreis -= 1;
    }
  } else if (!list.hasValue(black)) {
    if (list.hasValue(white)) {
      // white
      light = #00FF00;
    }
    if (list.hasValue(lightblue)) {
      // light-blue: Ziel
      textSize(40);
      fill(#00BAFF);
      text("You Win", 100, 100);
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

void scheibe(float startX, float startY) {
  fill(light);
  strokeWeight(0);
  ellipse(startX, startY, radiusKreis, radiusKreis);
}

void ende(int endeX, int endeY) {
  fill(#1ac6ff);
  strokeWeight(0);
  circle(endeX, endeY, 50);
  textSize(20);
  fill(0);
  text("Ziel", 485, 305);
}

void edgeCircle() {
  /* Draws Hidden Edge & Updates Location of Circle based on mouse */
  noFill();
  if (abs(mouseX - mx) > 0.1) {
    mx = mx + (mouseX - mx) * easing;
  }
  if (abs(mouseY - my) > 0.1) {
    my = my + (mouseY- my) * easing;
  }
  
  // constrains, so ball can't "escape"
  mx = constrain(mx, inner, width - inner);
  my = constrain(my, inner, height - inner);
  
  scheibe(mx, my);
}

