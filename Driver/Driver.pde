import java.util.LinkedList;
import java.util.ListIterator;
import controlP5.*;

ControlP5 cp5;
ControlFont cf;
LinkedList<CommandBlock> commandList;
CommandBlock draggedObject;
float initX;
float initY;
Tank tank;

void setup (){
  size(1200, 700);
  noStroke();
  rectMode(CENTER);
  cp5 = new ControlP5(this);
  cf = new ControlFont(createFont("Times",12));
  commandList = new LinkedList<CommandBlock>();
  
  MoveBackward command = new MoveBackward(cp5, cf, tank);
  commandList.add(command);
  parse();
  tank = new Tank(100,50,50,60,50,10,10,new Sprite(this,"../TankBase.png",0),new Sprite(this,"../TankHead.png",0));
}

void parse(){
    for (CommandBlock command: commandList) {
      command.execute();
    }
}

void draw(){
  background(0.0);
  /*tank.getBaseSprite().setX(tank.getXPos());
  tank.getBaseSprite().setY(tank.getYPos());
  tank.getHeadSprite().setX(tank.getTurrX());
  tank.getHeadSprite().setY(tank.getTurrY());
  tank.getBaseSprite().draw();
  tank.getHeadSprite().draw();*/
  
}
void mousePressed(){
  if(cp5.getWindow().getMouseOverList().size() > 0){
    draggedObject = commandList.get(Integer.parseInt(cp5.getWindow().getMouseOverList().get(0).getName()));
    initX = mouseX;
    initY = mouseY;
  }
}

void mouseReleased(){
  draggedObject = null;
}

void mouseDragged(){
  if(draggedObject != null && mouseX > 0 && mouseX < width && mouseY > 0 && mouseY < height){
    draggedObject.move(mouseX - initX, mouseY - initY);
    initX = mouseX;
    initY = mouseY;
  }
}