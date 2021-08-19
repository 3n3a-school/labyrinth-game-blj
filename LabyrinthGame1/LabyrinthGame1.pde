
import http.requests.*;
import lord_of_galaxy.timing_utils.*;
import org.multiply.processing.TimedEventGenerator;

import java.net.*;
import java.util.*;

private TimedEventGenerator scoreEventGen;

import g4p_controls.*;

String baseurl = "https://scores.enea.tech";

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
boolean alreadyReqH = false;
boolean connectivity = false;

String levelName = randomLevel();

//String screen = "start"; // start, game, gameOver, imZiel
String screen = "start";

PImage img, arrow;
PFont bold, standard;
JSONArray highscoresDict;

GButton button1;
GTextArea textField1;

void setup() {
  size(1920, 1080);
  frameRate(30);
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
  isOnline();
};

void onTimerEvent() {
  if (isStarted) {
   calcScore();
  }
}

void createButtons() {
  button1 = new GButton(this, 900, 770, 100, 30, "enter");
  button1.addEventHandler(this, "handleButton");
  button1.setVisible(false);
  textField1 = new GTextArea(this, 850, 700, 200, 50);
  textField1.setPromptText("Please enter your name");
  textField1.setVisible(false);
}

void draw () {
  switch (screen) {
    case "start" :
      update();
      startingScreen();
      if (!alreadyReqH) {
        highscoresDict = getHighscores();
        //println("rexeldjfldjfkdj");
        alreadyReqH = true;
      }
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
  alreadyReqH = false;
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

void isOnline() {
  try
   {
     URL url = new URL("http://processing.org");
     URLConnection conn = url.openConnection();
     conn.setConnectTimeout(5000);
     conn.connect();
     connectivity = true;
     println("can connect / " + connectivity);
   }
   catch (Exception e)
   {
     connectivity = false;
     System.out.println("can't connect / " + connectivity);
   }
}

JSONArray getHighscores(){
  if (connectivity) {
    GetRequest get = new GetRequest(baseurl+"/rest/highscores");
    get.send(); // d program will wait untill the request is completed
    //println("response: " + get.getContent());
    JSONArray jsonarr = parseJSONArray(get.getContent());
    return jsonarr;
  } else {
    JSONArray array = loadJSONArray("data/save.json");
    return array;
  }
}

void postRequest(String name, int score){
  if (connectivity) {
    PostRequest post = new PostRequest(baseurl+"/rest/highscores");
    JSONObject json = new JSONObject();
    json.setInt("score", score);
    json.setString("name", name);
    String jsonstring = json.toString();

    post.addHeader("Content-Type", "application/json");
    post.addData(jsonstring);
    post.send();
    //println("response: " + post.getContent());
  } else {
    JSONArray array = loadJSONArray("data/save.json");
    JSONObject obj = new JSONObject();
    obj.setInt("score", score);
    obj.setString("name", name);
    array.setJSONObject(array.size(), obj);
    saveJSONArray(array, "data/save.json");
  }
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
