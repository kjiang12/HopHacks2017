import java.util.LinkedList;

void setup (){
  LinkedList<CommandBlock> commandList = new LinkedList<CommandBlock>();
  MoveBackward command = new MoveBackward();
  commandList.add(command);
  parse(commandList);
}

void parse(LinkedList commandList){
     for (int i = 0; i < commandList.size(); i++) {
      commandList.get(i).execute();
    }
  
}