class FShell extends FGoomba{
  
  FShell(float x, float y){
    super(x, y);
    speed = 300 * player.direction;
    setName("shell");
    setRotatable(false);
    attachImage(shell);
  }
  
  void act(){
    collide();
    move();
    killEnemies();
  }
  
  void collide(){
    if (isTouching("wall")){
      direction *= -1;
      setPosition(getX()+direction * 10, getY());
    }
    if (isTouching("player") || ekey){
      if (player.getY() < getY() - gridSize*2/3){
        setVelocity(getVelocityX(), 0);
        setPosition(getX(), getY() - 1);
      } else {
        player.die();
      }
    }
  }
  
  
  void killEnemies(){
    for (int i = 0; i < enemies.size(); i++){
      if (isTouching(enemies.get(i)) && enemies.get(i) != this){
        enemies.get(i).setSensor(true);
        world.remove(enemies.get(i));
        enemies.remove(enemies.get(i));
        success.rewind();
        success.play();
        player.points += 1;
        world.remove(this);
        enemies.remove(this);
      }
    }
  }
}
