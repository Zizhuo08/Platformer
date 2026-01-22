int timer = 180 * 60;

void game(){
  background(bgBlue);
  
  actWorld();
  drawWorld();
  showTexts();
  if (timer == 0){
    failure.rewind();
    failure.play();
    mode = GAMEOVER;
  }
}

String currentText = "";
boolean textActive = false;

void gameClicks(){
}

void actWorld(){
  if (!isNormal && timer > 0)timer --;
  player.act();

  for (int i = 0; i < terrain.size(); i++){
    terrain.get(i).act();
  }

  for (int i = 0; i < enemies.size(); i++){
    enemies.get(i).act();
  }
  
  if (textActive && textCanClose && qkey){
    if (currentText.equals("Well done. You are worthy.\n Press Q to quit") ){
      win = true;
      mode = GAMEOVER;
    }
    currentText = "";
    textActive = false;
    textCanClose = false;
  }
}
boolean textCanClose = false;

void showText(String t){
  currentText = t;
  textActive = true;
  textCanClose = true;
}


void drawWorld(){
  pushMatrix();
  translate(-player.getX() + width/2, -player.getY() + height/2);
  scale(zoom);
  world.step();
  world.draw();
  popMatrix();
}

void showTexts(){
  fill(black);
  textSize(20);
  if (!isNormal) text("Countdown: " + (timer/60)/60 + ":" + (timer/60)%60, 100, 480);
  text("Point: " + player.points, 65, 500);
  text("Lives: " + player.lives, 65, 520);

  if (dashTimer > 0)
    text("Dash available in " + dashTimer/60 + " secs", 140, 540);
  else
    text("Dash available!", 100, 540);
  text("Standing with NPC and press E to interact", 210, 560);

  if (textActive){
    fill(0, 180);
    rect(300,80, 500, 130);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(20);
    text(currentText, width/2, 80);
  }
}

