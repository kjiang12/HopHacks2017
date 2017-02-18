public class CommandController{
  LinkedList<CommandBlock> commandList;
  HashMap<Integer, CommandBlock> commandTable;
  int count;
  
  public CommandController(){
    this.commandList = new LinkedList<CommandBlock>();
    this.commandTable = new HashMap<Integer, CommandBlock>();
    count = 0;
  }
  
  void add(CommandBlock command){
    command.setGroup(count + "");
    commandList.add(command);
    commandTable.put(count, command);
    count++;
  }
  
  CommandBlock getCommand(int id){
    return commandTable.get(id);
  }
  
  LinkedList<CommandBlock> getList(){
    return commandList;
  }
}