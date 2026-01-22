void pause(){
  fill(black, 2);
  noStroke();
  rect(width/2, height/2, width, height);
  fill(white);
  textSize(100);
  text("PAUSED", width/2, height/2 - 50);
  textSize(50);
  text("Press ESC to continue", width/2, height/2 + 50);
}

void pauseClicks(){
  
}
