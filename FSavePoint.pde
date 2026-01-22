class FSavePoint extends FGameObject{
  
  boolean activated;
  
  FSavePoint(float x, float y){
    super();
    setFillColor(spGreen);
    activated = false;
    setPosition(x,y);
    setStatic(true);
    setSensor(true);
  }
  
  void act(){
    if (isTouching("player") && !activated){
      activated = true;
      saved.rewind();
      saved.play();
      player.spawnX = getX();
      player.spawnY = getY();
    }
    if (!isTouching("player")){
      activated = false;
    }
  }
}
