void labyrinth() {
  noFill();
  stroke(#FFFFFF);
  strokeWeight(40.0);
  strokeJoin(MITER);
  beginShape();
  vertex(50, 80);
  vertex(500, 80);
  vertex(500, 200);
  vertex(100, 400);
  vertex(500, 400);
  vertex(500, 300);
  endShape();
}

void scheibe(int startX, int startY) {
  fill(0);
  strokeWeight(0);
  circle(startX, startY, 25);
}

void ende(int endeX, int endeY) {
  fill(#1ac6ff);
  strokeWeight(0);
  circle(endeX, endeY, 50);
  textSize(20);
  fill(0);
  text("Ziel", 485, 305);
}
