// startposition scheibe
int startX = 50;
int startY = 80;
boolean imZiel = false;
boolean overScheibe = false;
boolean isStarted = false;

float mx;
float my;
float easing = 1; // bigger = faster (0.2)
int radius = 24;
int edge = 1;
int inner = edge + radius;

int radiusKreis = 25;

int colorKreis = #000000;

PImage img;

void setup() {
  //fullScreen();
  size(1920, 1080);
  frameRate(30);
  ellipseMode(RADIUS);

  img = loadImage("bg.png");
};

void draw () {
  //noCursor()
  if (!isStarted) {
    update();
  } else {
    startX = mouseX;
    startY = mouseY;
  }

  // set image as background
  if(!imZiel){
    set(0,0, img);
    // color deteciton only after starting
    generiereScheibe(startX, startY);
    colorCollision();
  } else {
    endingScreen();
  }
}

void keyPressed() {
    if (key == 32) {
      println("Enter gedrückt");
     if (imZiel == true) {
     imZiel = false;
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
