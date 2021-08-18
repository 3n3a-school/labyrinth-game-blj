String getColorHex(int x, int y) {
  color c = img.get(x, y);
  return hex(c, 6);
}

void decideOnColor(StringList list) {
  String black = "000000";
  String white = "FFFFFF";
  String lightblue = "00BAFF";

  // if list 4 values with FFFFFF

  // deteciton touching wall
  if (list.hasValue(black)) {
    // discovery if fully immersed in black
    if (!list.hasValue(lightblue) && !list.hasValue(white)){
      screen = "gameOver";
    } else {
      // black
      colorKreis = #FF0000;
      //println("black");
      if (radiusKreis > 10) {
        radiusKreis -= 1;
      }

      collisions += 1;
    }
    
  } else if (!list.hasValue(black)) {
    if (list.hasValue(white)) {
      // white
      colorKreis = #00FF00;
    }
  }

  // detection of ziel
  if (!list.hasValue(black) && !list.hasValue(white)){
    if (list.hasValue(lightblue)) {
      // colorKreis-blue: Ziel
      screen = "ziel";
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

// funktion mit parameter damit keine repetition nötig
void endingScreen(){
  textSize(100);
  fill(#FFFFFF);
  background(#00BAFF);
  text("You Win", 700, 500);
  textSize(80);
  text("Press SPACE to play again", 450, 600);
}

void gameOver(){
  textSize(100);
  fill(#FFFFFF);
  background(#FF0000);
  text("Game Over", 700, 500);
  textSize(80);
  text("Press SPACE to play again", 450, 600);
}

void startingScreen(){
  textSize(100);
  fill(#FFFFFF);
  background(#33cccc);
  text("Welcome to our labyrinth", 350, 400);
  textSize(50);
  text("Please enter your name and move over the button", 350, 500);
  textSize(30);
  text("Developed by Enea, Janis, Nando and Lilly", 600, 600);
  arrow = loadImage("arrow.png");
  arrow.resize(200, 200);
  image(arrow, 100, 30);
}

void scoreBoard() {
  textSize(40);
  fill(#FF0000);
  float currentTime = (float) millis() / 1000;
  float timeFloat = currentTime - startTime;
  String time = nf(timeFloat, 0, 3);
  String time2 = nf(timeFloat, 0, 0);
  score = calcHighscore(time2, collisions);
  text("Score: "+score+" Time: "+time+" Collisions: "+collisions, 600, 50);
}

int calcHighscore(String time, int collisions) {
  int timeInt = Integer.valueOf(time);
  int highscore = (int) (score - timeInt - collisions);
  return highscore;
}