class FKoopaTroopa extends FGoomba{
  
  FKoopaTroopa(float x, float y){
    super(x,y);
    speed = 40;
    direction = R;
    setName("koopaTroopa");
    setRotatable(false);
  }
  
  void act(){
    animate();
    collide();
    move();
    dropShell();
  }
  
  void animate(){
    if (frame >= koopaTroopa.length) frame = 0;
    if (frameCount % 5 == 0){
      if (direction == L) attachImage(koopaTroopa[frame]);
      if (direction == R) attachImage(reverseImage(koopaTroopa[frame]));
      frame++;
    }
  }
  
  void dropShell(){
    if (isTouching("player") || qkey){
      if (player.getY() < getY() - gridSize*2/3){
        FShell s = new FShell(getX(), getY());
        enemies.add(s);
        world.add(s);
      }
    }
  }
  
  
}
