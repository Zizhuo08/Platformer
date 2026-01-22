void gameOver(){
  background(black);
  bkg.show();
  fill(red);
  textSize(80);
  if (win == true) text("YOU WIN!", width/2, 200);
  else text("YOU LOSE!", width/2, 200);
  button(white, black, blue, width/2, height/2 + 100, 200, 75, "BACK TO MAIN");
}

void gameOverClicks(){
  if (touchingButton(width/2, height/2 + 100, 200, 75)){
    mode = INTRO;
  }
}
