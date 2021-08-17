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

void scheibe(float startX, float startY) {
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