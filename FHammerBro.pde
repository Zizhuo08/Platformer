class FHammerBro extends FGoomba {
  
  int frame = 0;
  int timer = 0;
  int interval = 90;

  FHammerBro(float x, float y) {
    super(x,y);
    setRotatable(false);
    setName("hammerbro");
    attachImage(hammerBro[0]);
  }

  void act() {
    move();
    collide();
    throwHammer();
    animate();
  }

  void throwHammer() {
    timer++;
    if (timer >= interval) {
      timer = 0;
      FBox h = new FBox(gridSize, gridSize);
      h.setPosition(getX(), getY() - gridSize);
      h.attachImage(hammer);
      h.setSensor(true);
      h.setRotatable(true);
      h.setName("hammer");
      h.setVelocity(direction * 200, -400);
      h.setAngularVelocity(direction * 10);
      world.add(h);
    }
  }

  void animate() {
    if (frame >= hammerBro.length) frame = 0;
    if (frameCount % 5 == 0){
      if (direction == R) attachImage(hammerBro[frame]);
      if (direction == L) attachImage(reverseImage(hammerBro[frame]));
      frame++;
    }
  }
}
