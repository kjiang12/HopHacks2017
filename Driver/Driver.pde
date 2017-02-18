import java.util.LinkedList;
import java.util.ListIterator;
import controlP5.*;

ControlP5 cp5;
void setup (){
  cp5 = new ControlP5(this);
  LinkedList<CommandBlock> commandList = new LinkedList<CommandBlock>();
  MoveBackward command = new MoveBackward(cp5);
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