import java.util.LinkedList;
import java.util.ListIterator;
import controlP5.*;
//import sprites.Sprite;

ControlP5 cp5;
ControlFont cf;
LinkedList<CommandBlock> commandList;
CommandBlock draggedObject;
float initX;
float initY;

void setup (){
  size(1200, 700);
  noStroke();
  rectMode(CENTER);
  cp5 = new ControlP5(this);
  cf = new ControlFont(createFont("Times",12));
  commandList = new LinkedList<CommandBlock>();
  
  MoveBackward command = new MoveBackward(cp5, cf);
  commandList.add(command);
  parse();
}

void parse(){
    for (CommandBlock command: commandList) {
      command.execute();
    }
  
}

void draw(){
  background(0.0);
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
  if(draggedObject != null){
    draggedObject.move(mouseX - initX, mouseY - initY);
    initX = mouseX;
    initY = mouseY;
  }
}