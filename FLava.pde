class FLava extends FGameObject{
  
  int frame;
  
  FLava(float x, float y){
    super();
    setSensor(true);
    setStatic(true);
    setPosition(x,y);
    frame = 0;
    setName("lava");
  }
  
  void act(){
    collisions();
    animate();
  }
  
  void collisions(){
    if (isTouching("player") && getY() < (player.getY() + gridSize/2)){
      player.die();
    }
  }
  
  void animate() {
    if (frame >= lava.length) frame = 0;
    if (frameCount % 5 == 0){
      attachImage(lava[frame]);
      frame++;
    }
  }
}
