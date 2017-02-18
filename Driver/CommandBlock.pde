static int count = 0;

public abstract class CommandBlock{
  protected ControlP5 cp5;
  protected ControlGroup g;
  protected Tank tank;
  protected int id;
  protected CommandBlock next, prev;
  protected Connector connection;
  
  public CommandBlock(ControlP5 cp5, Tank tank){
    this.cp5 = cp5;
    this.g = cp5.addGroup(count + "")
             .setPosition(100,100)
             .setBackgroundHeight(100)
             .setSize(300,75)
             .setBarHeight(40)
             .setBackgroundColor(color(80,0,180))
             .disableCollapse();
    count++;
    this.tank = tank;
  }
  
  void setGroup(String s){
    this.id = Integer.parseInt(s);
    this.g.setStringValue(s);
  }
  
  void setNext(CommandBlock command){
    this.next = command;
    command.prev = this;
  }
  
  void setConnection(Connector connection){
    this.connection = connection;
  }
  
  void draw(){
    if(connection != null){
      connection.draw();
    }
  }
  abstract void execute();

  void move(float x, float y){
    float[] pos = g.getPosition();
    float newX = pos[0] + x;
    float newY = pos[1] + y;
    if(newX > 0 && newY - 20 > 0 && newX + 300 < width && newY + 75 < height){
      this.g.setPosition(pos[0] + x, pos[1] + y);
      if(connection != null){
        this.connection.changeStart(this);
      }
      if(prev != null){
        this.prev.connection.changeEnd(this);
      }
    }
  }
  
  int getX(){
    return (int) this.g.getPosition()[0];
  }
  
  int getY(){
    return (int) this.g.getPosition()[1];
  }
}