// startposition scheibe
int startX = 50;
int startY = 80;
int endeX = 500;
int endeY = 300;

void setup() {
  size(640, 480);;
};

void draw () {
  background(0,0,0);
  labyrinth();
  scheibe(startX, startY);
  ende(endeX, endeY);
}
