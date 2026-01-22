class FBridge extends FGameObject{
  
  FBridge(float x, float y){
    super();
    setPosition(x, y);
    setName("bridge");
    attachImage(bridge);
    setStatic(true);
    setFriction(4);
  }
  
  void act(){
    if (isTouching("player")){
      setStatic(false);
      setSensor(true);
    }
  }
}
