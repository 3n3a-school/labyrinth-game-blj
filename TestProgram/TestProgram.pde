// startposition scheibe
int initX = 50;
int initY = 80;
int startX = initX;
int startY = initY;
boolean imZiel = false;
boolean overScheibe = false;
boolean isStarted = false;
boolean gameOver = false;

float mx;
float my;
float easing = 1; // bigger = faster (0.2)
int radius = 39;
int edge = 1;
int inner = edge + radius;

int radiusKreis = 40;

int colorKreis = #000000;

PImage img;

void setup() {
  //fullScreen();
  size(1920, 1080);
  frameRate(30);
  ellipseMode(RADIUS);
  img = loadImage("Labyrinth.png");
};

void draw () {
  //noCursor()

  // before starting game
  if (!isStarted) {
    update();
  } else {
    startX = mouseX;
    startY = mouseY;
  }

  //as long as player not in Ziel
  if(!imZiel){
    set(0,0, img);
    generiereScheibe(startX, startY);
    colorCollision();
  } else {
    restartGame("ziel");
  } 
  if (gameOver && !imZiel) {
    restartGame("gameover");
  }
  
}

void restartGame(String selection) {
  switch (selection) {
    case "gameover":
      gameOver();
      isStarted = false;
      startX = initX;
      startY = initY;
    break;
    case "ziel":
      endingScreen();
      isStarted = false;
      startX = initX;
      startY = initY;
    break;
  }
}

void keyPressed() {
    if (key == 32) {
     if (imZiel == true) {
       imZiel = false;
       gameOver = false;
     } else if (gameOver) {
       imZiel = false;
       gameOver = false;
     }
    }
  
}

void update() {
  if ( overCircle(startX, startY, radiusKreis) ) {
    overScheibe = true;
    isStarted = true;
  } else {
    overScheibe = false;
  }
}

boolean overCircle(int x, int y, int radius) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < radius ) {
    return true;
  } else {
    return false;
  }
}
