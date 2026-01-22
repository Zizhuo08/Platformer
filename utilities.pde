void button(color strokeColor, color fillColor, color highlightColor, int x, int y, int w, int h, String text){
  fill (fillColor);
  color c;
  if (touchingButton(x,y,w,h)){
    c = highlightColor;
  }else{
    c = strokeColor;
  }
  stroke(c);
  strokeWeight(5);
  rect(x,y,w,h);
  textSize(25);
  fill(c);
  text(text,x,y-h/16);
}

Boolean touchingButton(int x, int y, int w, int h){
  if (mouseX > x - w/2 && mouseX < x+w/2 && mouseY > y - h/2 && mouseY < y+h/2){
    return true;
  }else{
    return false;
  }
}

class Gif{
  PImage[] images;
  int count;
  int wait;
  
  String before;
  String after;
  int numFrames;
  int speed;
  int x;
  int y;
  int w;
  int h;
  
  Gif(String _before, String _after, int _numFrames, 
  int _speed, int _x, int _y, int _w, int _h){
    before = _before;
    after = _after;
    numFrames = _numFrames;
    speed = _speed;
    loadGif();
    x = _x;
    y = _y;
    w = _w;
    h = _h;
  }
  
  Gif(String _before, String _after, int _numFrames, 
  int _speed, int _x, int _y){
    before = _before;
    after = _after;
    numFrames = _numFrames;
    speed = _speed;
    loadGif();
    x = _x;
    y = _y;
    w = images[0].width;
    h = images[0].height;
  }
  
  void show(){
    drawGif();
  }
  
  void loadGif(){
    images = new PImage[numFrames];
    int i = 0;
    while (i < numFrames){
      images[i] = loadImage(before+i+after);
      i++;
    }
  }
  
  void drawGif(){
    image(images[count], x, y, w, h);
    wait ++;
    if (wait % speed == 0){
      count ++;
    }
    if (count == numFrames){
      count = 0;
    }
  }
}

PImage reverseImage( PImage image ) {
  PImage reverse;
  reverse = createImage(image.width, image.height, ARGB );

  for ( int i=0; i < image.width; i++ ) {
    for (int j=0; j < image.height; j++) {
      int xPixel, yPixel;
      xPixel = image.width - 1 - i;
      yPixel = j;
      reverse.pixels[yPixel*image.width+xPixel]=image.pixels[j*image.width+i] ;
    }
  }
  return reverse;
}
