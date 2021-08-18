// startposition scheibe
int initX = 50;
int initY = 80;
int initKreis = 40;
int startX = initX;
int startY = initY;
int radiusKreis = initKreis;
int colorKreis = #000000;

float startTime, runTime;

String screen = "start"; // start, game, gameOver, imZiel

PImage img, arrow;

void setup() {
  size(1920, 1080);
  frameRate(30);
  ellipseMode(RADIUS);
  img = loadImage("Labyrinth.png");
  startTime = millis() / 1000;
};

void draw () {
  switch (screen) {
    case "start" :
      update();
      startingScreen();
      generiereScheibe(startX, startY);
    break;
    case "game" :
      // Koordinaten des Scheibe zu Koordinaten der Maus
      startX = mouseX;
      startY = mouseY;
      set(0,0, img);
      generiereScheibe(startX, startY);
      colorCollision();
      timer(500, 50);
    break;
    case "gameOver" :
      gameOver();
      startX = initX;
      startY = initY;
      radiusKreis = initKreis;
      startTime = millis() / 1000;
    break;	
    case "ziel" :
      endingScreen();
      startX = initX;
      startY = initY;
      radiusKreis = initKreis;
      startTime = millis() / 1000;
    break;	
    default :
      text("Error Screen not Found.", 1000, 1000);
    break;	
  }
}

void keyPressed() {
  if (key == 32) {
    if (screen == "ziel") {
      screen = "start";
    } else if (screen == "gameOver") {
      screen = "start";
    }
  }
}

void update() {
  if ( overCircle(startX, startY, radiusKreis) ) {
    screen = "game";
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
