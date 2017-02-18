import java.util.LinkedList;
import java.util.ListIterator;

void setup (){
  LinkedList<CommandBlock> commandList = new LinkedList<CommandBlock>();
  MoveBackward command = new MoveBackward();
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