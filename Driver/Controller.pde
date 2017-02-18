public class CommandController{
  LinkedList<CommandBlock> commandList;
  HashMap<Integer, CommandBlock> commandTable;
  int count;
  CommandBlock start;
  Range range;
  
  public CommandController(StartBlock start){
    this.commandList = new LinkedList<CommandBlock>();
    this.commandTable = new HashMap<Integer, CommandBlock>();
    count = 0;
    this.start = start;
    this.add(start);
    
    range = cp5.addRange("rangeController")
             .setPosition(50,600)
             .setSize(1200,40)
             .setHandleSize(10)
             .setRange(0,255)
             .setRangeValues(0,20)
             .setColorForeground(color(20,120,0))
             .setColorBackground(color(255,40,0))  
             .setVisible(false)
             .setLabelVisible(false)
             .onChange(new CallbackListener(){
               public void controlEvent(CallbackEvent event) {
                 scroll(event.getController().getArrayValue(0));
              }
             }); 
  }
  
  void add(CommandBlock command){
    command.setGroup(count + "");
    commandList.add(command);
    commandTable.put(count, command);
    count++;
  }
  
  CommandBlock getCommand(ControlGroup group){
    return commandTable.get(Integer.parseInt(group.getStringValue()));
  }
  
  void execute(){
    start.execute();
  }
  
  void draw(){
    if(displayCode){
      fill(color(200,200,200),70);
      rect(0, 0, width, height);
      
      for(CommandBlock command: commandList) {
        command.draw();
      }
    } 
  }
  
  void setVisible(Boolean bol){
    for(CommandBlock command: commandList) {
        command.setVisible(bol);
      }
      range.setVisible(bol);
  }
  
  void connect(CommandBlock command1, CommandBlock command2){
    if(command1 == command2.next || command1 == command2 || command2 instanceof StartBlock){
      return;
    }
    command1.setNext(command2);
    command1.setConnection(new Connector(command1.getX(), command1.getY(), command2.getX(), command2.getY()));
  }
  
  void scroll(float val){
    for(CommandBlock command: commandList){
        command.scrollMove(val);
    }
  }
}

public class Connector{
  int startX, startY, endX, endY;
  
  public Connector(int startX, int startY, int endX, int endY){
    this.startX = startX + 150;
    this.startY = startY - 10;
    this.endX = endX + 150;
    this.endY = endY - 10;
  } 
  
  void changeStart(CommandBlock command){
    this.startX = command.getX() + 150;
    this.startY = command.getY() - 10;
  }
  
  void changeEnd(CommandBlock command){
    this.endX = command.getX() + 150;
    this.endY = command.getY() - 10;
  }
  
  void draw(){
    strokeWeight(5);
    stroke(126);
    line(startX, startY, (endX + startX)/2, (startY + endY)/2);
    stroke(80);
    line((endX + startX)/2, (startY + endY)/2, endX, endY);
    stroke(255);
  }
}