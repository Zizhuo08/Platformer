void keyPressed(){
  if (keyCode == UP) upkey = true;
  if (keyCode == LEFT) leftkey = true;
  if (keyCode == RIGHT) rightkey = true;
  if (keyCode == DOWN) downkey = true;

  if (key == 'w' || key == 'W') wkey = true;
  if (key == 'a' || key == 'A') akey = true;
  if (key == 'd' || key == 'D') dkey = true;
  if (key == 's' || key == 'S') skey = true;
  if (key == 'q' || key == 'Q') qkey = true;
  if (key == 'e' || key == 'E') ekey = true;
  if (key == ' ' || key == ' ') spacekey = true;
}

void keyReleased(){
  if (keyCode == UP) upkey = false;
  if (keyCode == LEFT) leftkey = false;
  if (keyCode == RIGHT) rightkey = false;
  if (keyCode == DOWN) downkey = false;
  
  if (key == 'w' || key == 'W') wkey = false;
  if (key == 'a' || key == 'A') akey = false;
  if (key == 'd' || key == 'D') dkey = false;
  if (key == 's' || key == 'S') skey = false;
  if (key == 'q' || key == 'Q') qkey = false;
  if (key == 'e' || key == 'E') ekey = false;
  if (key == ' ' || key == ' ') spacekey = false;
}

void mouseReleased(){
  if (mode == INTRO) introClicks();
  else if (mode == GAME) gameClicks();
  else if (mode == PAUSE) pauseClicks();
  else if (mode == GAMEOVER) gameOverClicks();
}
