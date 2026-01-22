class FPlayer extends FGameObject {
  
  int frame;
  int direction;
  int lives;
  int points;
  boolean onGround;
  
  float spawnX, spawnY;
  
  int dashFrames = 0;
  final int dashTimerMax = 600;
  boolean hasDashed = false;
  boolean isDashing = false;
  
  FPlayer() {
    super();
    frame = 0;
    direction = R;
    lives = 20;
    points = 0;
    onGround = false;
    
    setPosition(400, 300);
    spawnX = getX();
    spawnY = getY();
    setRotatable(false);
    setName("player");
  }
  
  void act() {
    if (dashTimer > 0) dashTimer--;
    if (dashFrames > 0) dashFrames--;
    else isDashing = false;
    
    input();
    animate();
    collisions();
  }
  
  void input() {
    float vy = getVelocityY();
    
    if (onGround && abs(vy) < 0.1) action = idle;
    
    if (!isDashing) {
      if (akey) {
        setVelocity(-300, vy);
        action = run;
        direction = L;
      }
      if (dkey) {
        setVelocity(300, vy);
        action = run;
        direction = R;
      }
    }
    
    if (wkey && onGround) {
      onGround = false;
      hasDashed = false;
      addImpulse(0, -1230);
    }
    
    if (!onGround) action = jump;
    
    if (spacekey && !hasDashed && dashTimer == 0) dash();
  }
  
  void dash() {
    dashFrames = 6;
    dashTimer = dashTimerMax;
    hasDashed = true;
    isDashing = true;
    addImpulse(direction * 1500, 0);
  }
  
  void animate() {
    if (frame >= action.length) frame = 0;
    if (frameCount % 5 == 0) {
      if (direction == R) attachImage(action[frame]);
      if (direction == L) attachImage(reverseImage(action[frame]));
      frame++;
    }
  }

  void collisions() {
    boolean wasOnGround = onGround;
    onGround = false;
    
    

    
    if (isTouching("spike") || isTouching("hammer") || isTouching("thwomp")) die();
    
    if (touchingGround("stone") || touchingGround("brick") ||
    touchingGround("ice") || touchingGround("bridge") || touchingGround("trampoline") || touchingGround("treetop") || touchingGround("wall")) {
      onGround = true;
    }
    
    if (isTouching("trampoline") ){
      setVelocity(getVelocityX(), 0);
      addImpulse(0, -1800);
    }
    
    if (!wasOnGround && onGround) {
      hasDashed = false;
      dashFrames = 0;
    }
  }
  
  boolean touchingGround(String name){
    if (!isTouching(name)) return false;
    if (getVelocityY() < -1) return false;
    FBody ground = world.getBody(getX(), getY() + gridSize/2 + 1);
    return ground != null && name.equals(ground.getName());
  }
  
  void die() {
    dashTimer = 0;
    failure.rewind();
    failure.play();
    if (lives > 1) {
      setPosition(spawnX, spawnY);
      lives--;
    } else {
      mode = GAMEOVER;
    }
  }
}
