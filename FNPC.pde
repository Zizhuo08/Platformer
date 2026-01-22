class FNPC extends FGameObject {
  
  int frame;
  boolean playerNear;
  
  int stage;
  
  FNPC(float x, float y){
    super();
    frame = 0;
    stage = 0;
    playerNear = false;
    canInteract = true;
    
    setPosition(x,y);
    setStatic(true);
    setRotatable(false);
    setSensor(true);
    setName("npc");
    attachImage(NPC);
  }
  
  void act(){  
    if (isTouching("player") && ekey && canInteract){
      interact();
      canInteract = false;
    }
    
    if (!ekey && !canInteract){
      canInteract = true;
    }
  }
  
  void interact(){
    if (player.points < 50){
      showText("Penguin: You need 50 points to finish! \n Press Q to quit");
    } else {
      showText("Well done. You are worthy.");
    }
  }
}
boolean canInteract;
