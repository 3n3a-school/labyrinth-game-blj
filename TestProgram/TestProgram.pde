
import http.requests.*;
import lord_of_galaxy.timing_utils.*;
import org.multiply.processing.TimedEventGenerator;

private TimedEventGenerator scoreEventGen;

import g4p_controls.*;

// startposition scheibe
int initX = 80;
int initY = 80;
int initKreis = 40;
int startX = initX;
int startY = initY;
int radiusKreis = initKreis;
int colorKreis = #000000;

Stopwatch s;
int collisions = 0;
int score = 1000;
boolean isStarted = false;

String levelName = "Labyrinth"+round(random(1, 4))+".png"

//String screen = "start"; // start, game, gameOver, imZiel
String screen = "start";

PImage img, arrow;

GButton button1;
GTextArea textField1;

void setup() {
  size(1920, 1080);
  frameRate(30);
  ellipseMode(RADIUS);
  img = loadImage(levelName);
  s = new Stopwatch(this);
  s.start();

  scoreEventGen = new TimedEventGenerator(this);
  scoreEventGen.setIntervalMs(1000);
  button1 = new GButton(this, 900, 470, 100, 30, "enter");
  button1.addEventHandler(this, "handleButton");
  textField1 = new GTextArea(this, 850, 400, 200, 50);
  textField1.setPromptText("Please enter your name");
};

void onTimerEvent() {
  calcScore();
}

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
      startTiming();
      set(0,0, img);
      generiereScheibe(startX, startY);
      colorCollision();
      scoreBoard();
    break;
    case "gameOver" :
      gameOver();
      reset();
    break;	
    case "ziel" :
      endingScreen();
      reset();
    break;	
    case "eingabefeld":
      textEingabe();
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

void startTiming() {
  if (isStarted == false) {
    s.start();
    isStarted = true;
  }
}

void reset() {
  startX = initX;
  startY = initY;
  radiusKreis = initKreis;
  //startTime = millis() / 1000;
  collisions = 0;
  s.reset();
  colorKreis = #000000;
  isStarted = false;
  score = 100;
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

public void handleButtonEvents(GButton button, GEvent event) {
  if(button == button1){
    println("You have clicked on the first button");
  }
  println("The sketch has been running for " + millis() + " milliseconds");
}

void getRequest(){
  GetRequest get = new GetRequest("https://scores.enea.tech/rest/highscores");
  get.send(); // d program will wait untill the request is completed
  println("response: " + get.getContent());
  JSONObject response = parseJSONObject(get.getContent());
  println("status: " + response.getString("status"));
  println("data: " + response.getJSONObject("data"));
}

public void handleTextEvents(GEditableTextControl textarea, GEvent event) {
  println(event);
}

public void handleButton(GButton button, GEvent event) {
   String message = textField1.getText();
   println(message);
   getRequest();
}
