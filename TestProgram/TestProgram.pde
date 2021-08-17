// startposition scheibe
int startX = 50;
int startY = 80;

void setup() {
  size(640, 480);;
};

void draw () {
  background(0,0,0);
  labyrinth();
  scheibe(startX, startY);
}
