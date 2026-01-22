class FGoomba extends FGameObject{
  
  int direction = L;
  int speed = 40;
  int frame = 0;
  
  FGoomba(float x, float y){
    super();
    setPosition(x,y);
    setName("goomba");
    setRotatable(false);
  }
  
  void act(){
    animate();
    collide();
    move();
  }
  
  void animate(){
    if (frame >= goomba.length) frame = 0;
    if (frameCount % 5 == 0){
      if (direction == R) attachImage(goomba[frame]);
      if (direction == L) attachImage(reverseImage(goomba[frame]));
      frame++;
    }
  }
  
  void collide(){
    if (isTouching("wall") || isTouching("invisiblewall")){
      direction *= -1;
      setPosition(getX()+direction, getY());
    }
    if (isTouching("player")){
      if (player.getY() < getY() - gridSize*2/3){
        player.points += 1;
        success.rewind();
        success.play();
        world.remove(this);
        enemies.remove(this);
        player.setVelocity(player.getVelocityX(), -300);
      } else {
        player.die();
      }
    }
    for (int i = 0; i < enemies.size(); i++){
      FGameObject e = enemies.get(i);
      if (e != this && isTouching(e)){
        direction *= -1;
        if (e instanceof FGoomba) {
          FGoomba temp = (FGoomba) e;
          temp.direction *= -1;
        }
        setPosition(getX() + direction, getY());
        break;
        
      }
    }
  }
  
  void move(){
    float vy = getVelocityY();
    setVelocity(speed*direction, vy);
  }
}
