// startposition scheibe
int startX = 50;
int startY = 80;
int endeX = 500;
int endeY = 300;

float mx;
float my;
float easing = 1; // bigger = faster (0.2)
int radius = 24;
int edge = 1;
int inner = edge + radius;

void setup() {
  size(640, 480);;
};

void draw () {
  noCursor();
  background(0,0,0);
  labyrinth(); 
  ende(endeX, endeY);
  edgeCircle(); 
}
