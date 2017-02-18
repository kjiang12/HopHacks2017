  import java.util.LinkedList;
  import java.util.ListIterator;
  import controlP5.*;

  ControlP5 cp5;
  ControlFont cf;
  CommandBlock selectedObject;
  float initX;
  float initY;
  Tank tank;
  ArrayList<Obstacles> obstacles;
  CommandController control;
  
  Boolean selected = false;
  CommandBlock selections;
  
  Boolean displayCode = false;
  
 void setup (){
    size(1260, 720);
    noStroke();
    rectMode(CORNER);
    
    cp5 = new ControlP5(this);
    cf = new ControlFont(createFont("Times",16));
    obstacles = new ArrayList<Obstacles>();
    
    generateObstacles(25);
    control = new CommandController();
    tank = new Tank(100, 50, 50, 60, 50, new Sprite(this,"../TankBase.png",0), new Sprite(this,"../TankHead5.png",0));

    control.add(new MoveBackward(cp5, cf, tank));
    control.add(new MoveForward(cp5, cf, tank));
    control.add(new MoveForward(cp5, cf, tank));
    control.execute(); //replaces parse();
    
    Toggle tog = cp5.addToggle("Show\nCode")
     .setFont(cf)
     .setPosition(20,20)
     .setSize(70,50)
     .setColorBackground(color(0, 120, 0))
     .onChange(new CallbackListener(){
       public void controlEvent(CallbackEvent event) {
         if(event.getController().getValue() == 0){
           displayCode = false;
         } else {
           displayCode = true;
         }
         control.setVisible(displayCode);
      }
     }); 
     
     tog.getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP).setPaddingX(0);
     
  }

boolean brake = false;
 void draw(){
    background(255.0);
    if(displayCode){
      fill(color(0,0,200),50);
      rect(0, 0, 1260, 720);
    }
    tank.turnLeft();
    tank.turnTurretRight();
    println(tank.getTankAngle());
    tank.update();
    tank.draw();

    for(Obstacles obstacle: obstacles){
      obstacle.getSprite().draw();
    }
    control.draw();
    collisionCheck();
  }
  
  void mousePressed(){
    if (!brake) {
      tank.turnRight();
      brake = true;
    } else {
      tank.stopTurn();
      brake = false;
    }
    if(cp5.getWindow().getMouseOverList().size() > 0){
      try{
        if(selected){
          if(selections != null){
            control.connect(selections, control.getCommand((ControlGroup) cp5.getWindow().getMouseOverList().get(0).bringToFront()));
            selections = null;
          } else {
            selections = control.getCommand((ControlGroup) cp5.getWindow().getMouseOverList().get(0).bringToFront());
          }
        } else {
          selectedObject = control.getCommand((ControlGroup) cp5.getWindow().getMouseOverList().get(0).bringToFront());
          initX = mouseX;
          initY = mouseY;
        }
      } catch(Exception e){
      }
    }
   }

void mouseReleased(){
  selectedObject = null;
}

void mouseDragged(){
  if(selectedObject != null && mouseX > 0 && mouseX < width && mouseY > 0 && mouseY < height){
    selectedObject.move(mouseX - initX, mouseY - initY);
    initX = mouseX;
    initY = mouseY;
  }
}

void keyPressed() {
  if (key == CODED && keyCode == CONTROL) {
    selected = true;
  } 
}

void keyReleased(){
  selected = false;
  selections = null;
}

void generateObstacles(int numberOfObstacles){
  boolean overlap = false;
  int i = 0;
  while (i < numberOfObstacles / 2){
    Crate crate = new Crate(((int) (Math.random() * (width - 50)) + 20),((int) (Math.random() * (height - 50)) + 20), new Sprite(this,"../Crate.png",0));
    crate.getSprite().setX(crate.getX());
    crate.getSprite().setY(crate.getY());
    crate.getSprite().setCollisionRadius((crate.getSprite().getHeight()/2) + 2);
    for (Obstacles obstacle: obstacles){
     if(obstacle.getSprite().cc_collision(crate.getSprite())){
       overlap = true;
       break;
     }
    }
    if (!overlap) {
      obstacles.add(crate);
      i++;
    }
    else {
       overlap = false; 
    }
  }
  overlap = false;
  i = 0;
  while (i < numberOfObstacles / 2){
    Barrel barrel = new Barrel(((int) (Math.random() * (width - 50)) + 20),((int) (Math.random() * (height - 50)) + 20), new Sprite(this,"../Barrel.png",0));
    barrel.getSprite().setX(barrel.getX());
    barrel.getSprite().setY(barrel.getY());
    barrel.getSprite().setCollisionRadius((barrel.getSprite().getHeight()/2) + 2);
    for (Obstacles obstacle: obstacles){
     if(obstacle.getSprite().cc_collision(barrel.getSprite())){
       overlap = true;
       break;
     }
    }
    if (!overlap) {
      obstacles.add(barrel);
      i++;
    }
    else {
       overlap = false; 
    }
  }
}

void collisionCheck(){
   for (Obstacles obstacle: obstacles){
     if(obstacle.getSprite().cc_collision(tank.getBaseSprite())){
       System.out.print("Collision!");
     }
   }
  
  
  
}
  