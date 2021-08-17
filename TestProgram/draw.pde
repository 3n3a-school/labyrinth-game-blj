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

void colorCollision() {

  //refactoring...
  int width = 10;
  int height = 10;
  color c = img.get(mouseX, mouseY);
  //TODO: PImage colorArea = img.get(mouseX -radiusKreis, mouseY -radiusKreis, 50, 50);
  //color c = colorArea.get();

  String colorCircle = hex(c, 6);
  switch(colorCircle) {
    case "FFFFFF":
      // weiss --> gut
      light = #00FF00;
      break;
    case "000000":
      // schwarz
      light = #FF0000;
      println("black");
      if (radiusKreis > 10) {
        radiusKreis -= 1;
      }
      break;
    case "00BAFF":
      // lightblue
      textSize(40);
      fill(#00BAFF);
      text("You Win", 100, 100);
      break;
    default :
      println(colorCircle);
      break;	
  }
}

void scheibe(float startX, float startY) {
  fill(light);
  strokeWeight(0);
  circle(startX, startY, radiusKreis);
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

