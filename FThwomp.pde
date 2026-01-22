class FThwomp extends FGameObject {

  boolean activated = false;

  FThwomp(float x, float y) {
    super();
    setWidth(gridSize*2);
    setHeight(gridSize*2);
    setPosition(x + gridSize/2, y - gridSize/2);

    setStatic(true);
    setRotatable(false);
    setFriction(0);
    setName("thwomp");

    attachImage(thwomp0);
  }

  void act() {
    checkPlayerBelow();
  }

  void checkPlayerBelow() {
    if (activated) return;
    if (abs(player.getX() - getX()) < gridSize*2 && player.getY() > getY()) {
      activated = true;
      setStatic(false);
      attachImage(thwomp1);
    }
  }
}
