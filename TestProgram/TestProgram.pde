
import http.requests.*;
import lord_of_galaxy.timing_utils.*;
import org.multiply.processing.TimedEventGenerator;

private TimedEventGenerator scoreEventGen;

import g4p_controls.*;

String baseurl = "http://localhost:8083";

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

String levelName = randomLevel();

//String screen = "start"; // start, game, gameOver, imZiel
String screen = "start";

PImage img, arrow;
PFont bold, standard;

GButton button1;
GTextArea textField1;

void setup() {
  size(1920, 1080);
  frameRate(300);
  ellipseMode(RADIUS);
  s = new Stopwatch(this);
  s.start();
  img = loadImage(levelName);

  bold = createFont("Roboto-Bold.ttf", 30);

  standard = createFont("Roboto-Regular.ttf", 30);
  textFont(standard);

  scoreEventGen = new TimedEventGenerator(this);
  scoreEventGen.setIntervalMs(1000);

  // setVisible false
  createButtons();
};

void onTimerEvent() {
  if (isStarted) {
   calcScore();
  }
}

void createButtons() {
  button1 = new GButton(this, 900, 470, 100, 30, "enter");
  button1.addEventHandler(this, "handleButton");
  button1.setVisible(false);
  textField1 = new GTextArea(this, 850, 400, 200, 50);
  textField1.setPromptText("Please enter your name");
  textField1.setVisible(false);
}

void draw () {
  switch (screen) {
    case "start" :
      update();
      startingScreen();
      JSONArray highscoresDict = getHighscores();
      showHighscore(highscoresDict);
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
      isStarted = false;
      s.pause();
      button1.setVisible(true);
      textField1.setVisible(true);
      endingScreen();
    break;
    default :
      text("Error Screen not Found.", 1000, 1000);
    break;	
  }
}

void keyPressed() {
  if (key == 32) {
    if (screen == "gameOver") {
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
  collisions = 0;
  s.reset();
  colorKreis = #000000;
  score = 1000;
  levelName = randomLevel();
  img = loadImage(levelName);
  createButtons();
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

JSONArray getHighscores(){
  GetRequest get = new GetRequest(baseurl+"/rest/highscores");
  get.send(); // d program will wait untill the request is completed
  //println("response: " + get.getContent());
  JSONArray jsonarr = parseJSONArray(get.getContent());
  return jsonarr;
}

void postRequest(String name, int score){
  PostRequest post = new PostRequest(baseurl+"/rest/highscores");
  JSONObject json = new JSONObject();
  json.setInt("score", score);
  json.setString("name", name);
  String jsonstring = json.toString();

  post.addHeader("Content-Type", "application/json");
  post.addData(jsonstring);
  post.send();
  //println("response: " + post.getContent());
}

public void handleButton(GButton button, GEvent event) {
   String message = textField1.getText();
   //println(message + "  " + score);

  button1.setVisible(false);
  textField1.setVisible(false);
  postRequest(message, score);
  
  reset();
  screen = "start";
}

void showHighscore(JSONArray daddyJson) {
  int startCoordsX = 790;
  int startCoordsY = 550;
  int offset = 0;
  textSize(30);
  fill(0);
  textFont(bold);
  text("Scores", startCoordsX + 10, startCoordsY - 40);
  text("Names", startCoordsX + 200, startCoordsY - 40);
  textFont(standard);
  for (int i=0; i < daddyJson.size(); i++) {
    JSONObject json = daddyJson.getJSONObject(i);

    String name =json.getString("name");
    int score =json.getInt("score");
    // score
    text(str(score), startCoordsX, startCoordsY + offset);
    // name
    text(name, startCoordsX + 200, startCoordsY + offset);

    offset += 40;
  }
}

String randomLevel() {
  String filename = "data/Labyrinth"+str(round(random(1, 10)))+".png";
  //println(filename);
  return filename;
}