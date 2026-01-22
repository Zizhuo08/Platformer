void intro(){ 
  background(black);
  bkg.show();
  
  
  
  fill(red);
  textSize(80);
  text("PLATFORMER", width/2, 200);
  
  //start game button
  fill(black);
  button(white, black, blue, width/2, height/2 + 50, 200, 75, "NORMAL");
  button(white, black, red, width/2, height/2 + 150, 200, 75, "SPEEDRUN");
  
}

void introClicks(){
  if (touchingButton(width/2, height/2 + 50, 200, 75)){
    initialize();
    isNormal = true;
    mode = GAME;
  }else if (touchingButton(width/2, height/2 + 150, 200, 75)){
    initialize();
    isNormal = false;
    mode = GAME;
    timer = 180*60;
  }
}

void initialize(){
  terrain.clear();
  enemies.clear();
  clearWorld();
  
  loadWorld(map);
  loadPlayer();
  
  textActive = false;
}

void clearWorld() {
  ArrayList<FBody> bodies = world.getBodies();

  for (int i = bodies.size() - 1; i >= 0; i--) {
    world.remove(bodies.get(i));
  }
}
