// startposition scheibe
int startX = 50;
int startY = 80;

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
  size(1920, 1080);
  frameRate(30);
  ellipseMode(RADIUS);

  img = loadImage("bg.png");
};

void draw () {
  //noCursor();

  // set image as background
  set(0,0, img);
  // color deteciton only after starting
  scheibe(mouseX, mouseY);
  colorCollision();
}

void keyPressed() {
  if (key == 'A') {
    radiusKreis =24;
  }
}