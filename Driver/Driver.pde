import java.util.LinkedList;
import java.util.ListIterator;
import controlP5.*;

ControlP5 cp5;
ControlFont cf;
LinkedList<CommandBlock> commandList;

void setup (){
  size(1200, 700);
  noStroke();
  rectMode(CENTER);
  cp5 = new ControlP5(this);
  cf = new ControlFont(createFont("Times",12));
  commandList = new LinkedList<CommandBlock>();
  MoveBackward command = new MoveBackward(cp5, cf);
  commandList.add(command);
  parse(commandList);
}

void parse(LinkedList commandList){
    ListIterator<CommandBlock> listIterator = commandList.listIterator();
    while (listIterator.hasNext()) {
      CommandBlock command = listIterator.next();
      command.execute();
    }
  
}

void draw(){
  background(0);
  if(cp5.isMouseOver()){
    for(CommandBlock command : commandList){
      command.draw();
    }
  }
}