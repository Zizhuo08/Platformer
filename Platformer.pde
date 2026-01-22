import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

//Zizhuo Liu
//Nov 26, 2025

import fisica.*;

Minim minim;
AudioPlayer success;
AudioPlayer failure;
AudioPlayer saved;

color transparent = color (0,0,0,0);
color bgBlue = #81A5FF;
color black = color(0,0,0); //stone
color white = 255;
color grey = color(153,153,153); //wall
color red = color(255, 0, 0);
color blue = color(0, 0, 255); // ice
color brown = #985F09; //tree
color green = color(0, 255, 0);
color trampolineBlue = #2f9ff5;
color spikeGrey = #d9d9d9;
color pink = #ff87e3; // bridge
color yellow = color(255,255,0); //goomba
color purple = #FF00FF; //thwomp
color hammerGreen = #7EFF00; //hammerbro
color ktBlue = #8266ff; //koopa troopa
color spGreen = #99ffa7; //savepoint
color gold = #FFED21; // coin
color invisiblePurple = #700070; //invisible wall
color npcRed = #ff0073; //npc

//Mode Framework
final int INTRO = 0;
final int GAME = 1;
final int PAUSE = 2;
final int GAMEOVER = 3;

int mode = INTRO;
boolean win = false;

FWorld world;
ArrayList<FGameObject> terrain; //fancy terrains
ArrayList<FGameObject> enemies;

//Resources
//Images for terrain
PImage map, ice, stone, treeTrunk, treeIntersect, treeW, treeE, treeLeaves, trampoline, spike, bridge, thwomp0, thwomp1, hammer, shell, savePoint, NPC;

//character animations
PImage[] idle;
PImage[] jump;
PImage[] run;
PImage[] action;

PImage[] lava;
PImage[] goomba;
PImage[] hammerBro;
PImage[] koopaTroopa;
PImage[] coin;

Gif bkg;

int gridSize = 32;
float zoom = 1; 

int dashTimer = 0;

//keyboard behaviors
boolean upkey, downkey, leftkey, rightkey, wkey, akey, skey, dkey, qkey, ekey, spacekey;


FPlayer player;

boolean isNormal;  


void setup(){
  size(600,600);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);
  Fisica.init(this);
  world = new FWorld(-20000,-20000,20000,20000);
  world.setGravity(0,900);
  world.setGrabbable(false);
  terrain = new ArrayList();
  enemies = new ArrayList();
  loadResources();
  
  isNormal = true;
}

void draw(){
  if (mode == INTRO) intro();
  else if(mode == GAME) game();
  else if (mode == PAUSE) pause();
  else if(mode == GAMEOVER) gameOver();
}

void loadWorld(PImage img) {
  for (int y = 0; y < img.height; y++){
    for (int x = 0; x < img.width; x++){
      color c = img.get(x, y);
      color s = img.get(x, y+1);
      color w = img.get(x-1, y);
      color e = img.get(x+1, y);
      FBox b = new FBox(gridSize, gridSize);
      b.setPosition(x*gridSize, y*gridSize);
      b.setStatic(true);
      b.setFriction(4);
      b.setRotatable(false);
      
      if (c == black){ //stone
        b.attachImage(stone);
        b.setName("stone");
        world.add(b);
      } else if (c == grey) {
        b.attachImage(stone);
        b.setName("wall");
        world.add(b);
      } else if (c == blue){ //ice
        b.attachImage(ice);
        b.setFriction(0.5);
        b.setName("ice");
        world.add(b);
      } else if (c == brown){ //tree trunk
        b.attachImage(treeTrunk);
        b.setSensor(true);
        b.setName("treeTrunk");
        world.add(b);
      } else if (c == green && s == brown){ //intersection
        b.attachImage(treeIntersect);
        b.setName("treetop");
        world.add(b);
      } else if (c == green && w != green){ //west
        b.attachImage(treeW);
        b.setName("treetop");
        world.add(b);
      } else if (c == green && e != green ){ //east
        b.attachImage(treeE);
        b.setFriction(4);
        b.setName("treetop");
        world.add(b);
      } else if (c == green && w == green && e == green){ //mid
        b.attachImage(treeLeaves);
        b.setFriction(4);
        b.setName("treetop");
        world.add(b);
      } else if (c == trampolineBlue){
        b.attachImage(trampoline);
        b.setName("trampoline");
        world.add(b);
      } else if (c == spikeGrey){
        b.attachImage(spike);
        b.setName("spike");
        world.add(b);
      } else if (c == pink){
        FBridge br = new FBridge(x*gridSize, y*gridSize);
        terrain.add(br);
        world.add(br);
      } else if (c == red){
        FLava la = new FLava(x*gridSize, y*gridSize);
        terrain.add(la);
        world.add(la);
      } else if (c == yellow){
        FGoomba gmb = new FGoomba(x*gridSize, y*gridSize);
        enemies.add(gmb);
        world.add(gmb);
      } else if (c == purple){
        FThwomp thwp = new FThwomp(x*gridSize,y*gridSize);
        enemies.add(thwp);
        world.add(thwp);
      } else if (c == hammerGreen){
        FHammerBro hb = new FHammerBro(x*gridSize,y*gridSize);
        enemies.add(hb);
        world.add(hb);
      } else if (c == ktBlue){
        FKoopaTroopa kt = new FKoopaTroopa(x*gridSize,y*gridSize);
        enemies.add(kt);
        world.add(kt);
      } else if (c == spGreen){
        FSavePoint sp = new FSavePoint(x*gridSize,y*gridSize);
        terrain.add(sp);
        world.add(sp);
      } else if (c == gold){
        FCoin coin = new FCoin(x*gridSize,y*gridSize);
        terrain.add(coin);
        world.add(coin);
      } else if (c == invisiblePurple){
        b.setFillColor(transparent);
        b.setNoStroke();
        b.setName("invisiblewall");
        b.setSensor(true);
        world.add(b);
      } else if (c == npcRed){
        FNPC n = new FNPC(x*gridSize,y*gridSize);
        terrain.add(n);
        world.add(n);
      } 
    }
  }
}

void loadPlayer(){
  player = new FPlayer();
  world.add(player);
}

void loadResources(){
  map = loadImage("map.png");
  stone = loadImage("stone.png");
  ice = loadImage("ice.png");
  ice.resize(gridSize,gridSize);
  treeTrunk = loadImage("treeTrunk.png");
  treeIntersect = loadImage("treeIntersect.png");
  treeW = loadImage("treeW.png");
  treeE = loadImage("treeE.png");
  treeLeaves = loadImage("treeLeaves.png");
  trampoline = loadImage("trampoline.png");
  spike = loadImage("spike.png");
  bkg = new Gif("frame_", "_delay-0.1s.gif",24,1,0,0,width,height);
  bridge = loadImage("bridge.png");
  thwomp0 = loadImage("thwomp0.png");
  thwomp1 = loadImage("thwomp1.png");
  hammer = loadImage("hammer.png");
  shell = loadImage("shell.png");
  NPC = loadImage("npc.png");
  NPC.resize(gridSize,gridSize);
  //savePoint = loadImage("savePoint.png");
  
  idle = new PImage[2];
  idle[0] = loadImage("idle0.png");
  idle[1] = loadImage("idle1.png");
  
  jump = new PImage[1];
  jump[0] = loadImage("jump0.png");
  
  run = new PImage[3];
  run[0] = loadImage("run0.png");
  run[1] = loadImage("run1.png");
  run[2] = loadImage("run2.png");
  
  action = idle;
  
  lava = new PImage[4];
  lava[0] = loadImage("lava0.png");
  lava[1] = loadImage("lava1.png");
  lava[2] = loadImage("lava2.png");
  lava[3] = loadImage("lava3.png");
  
  goomba = new PImage[2];
  goomba[0] = loadImage("goomba0.png");
  goomba[0].resize(gridSize,gridSize);
  goomba[1] = loadImage("goomba1.png");
  goomba[1].resize(gridSize,gridSize);
  
  hammerBro = new PImage[2];
  hammerBro[0] = loadImage("hammerbro0.png");
  hammerBro[1] = loadImage("hammerbro1.png");
  
  koopaTroopa = new PImage[2];
  koopaTroopa[0] = loadImage("koopaTroopa0.png");
  koopaTroopa[0].resize(gridSize,gridSize);
  koopaTroopa[1] = loadImage("koopaTroopa1.png");
  koopaTroopa[1].resize(gridSize,gridSize);
  
  
  coin = new PImage[6];
  for (int i = 0; i < 6; i++){
    coin[i] = loadImage("coin" + i + ".gif");
    coin[i].resize(gridSize,gridSize);
  }
  
  minim = new Minim(this);
  
  success = minim.loadFile("SUCCESS.wav");
  failure = minim.loadFile("FAILURE.wav");
  saved = minim.loadFile("saved.wav");
}
