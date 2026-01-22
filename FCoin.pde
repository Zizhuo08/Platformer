class FCoin extends FGameObject{
  
  int frame;
  
  FCoin(float x, float y){
    super();
    setSensor(true);
    setStatic(true);
    setPosition(x,y);
    frame = 0;
    setName("coin");
  }
  
  void act(){
    collisions();
    animate();
  }
  
  void collisions(){
    if (isTouching("player")){
      player.points += 1;
      
      success.play();
      success.rewind();
      //sound
      terrain.remove(this);
      world.remove(this);
    }
  }
  
  void animate() {
    if (frame >= lava.length) frame = 0;
    if (frameCount % 15 == 0){
      attachImage(coin[frame]);
      frame++;
    }
  }
}
