import java.util.LinkedList;
import java.util.ListIterator;
import controlP5.*;

ControlP5 cp5;
ControlFont cf;

void setup (){
  size(1200, 700);
  noStroke();
  rectMode(CENTER);
  cp5 = new ControlP5(this);
  cf = new ControlFont(createFont("Times",12));
  LinkedList<CommandBlock> commandList = new LinkedList<CommandBlock>();
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

}