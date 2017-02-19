static int count = 0;

public abstract class CommandBlock{
  protected ControlP5 cp5;
  protected ControlGroup g;
  protected Tank tank;
  protected int id, h = 75, w = 300;
  protected float scrollScale = 0, x = 100, y = 100;
  protected CommandBlock next, prev;
  protected Connector connection;
  
  public CommandBlock(ControlP5 cp5, Tank tank){
    this.cp5 = cp5;
    this.g = cp5.addGroup(count + "")
             .setPosition(100,100)
             .setBackgroundHeight(100)
             .setSize(w,h)
             .setBarHeight(40)
             .setBackgroundColor(color(80,0,180))
             .disableCollapse()
             .setVisible(false);
    this.id = count;
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
  
  void deleteConnection(){
    this.connection = null;
  }
  
  void setVisible(Boolean bol){
    this.g.setVisible(bol);
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
    if(newX > 0 && newY - 20 > 0 && newX + w < width && newY + h < height){
      this.g.setPosition(newX, newY);
      this.x = newX + scrollScale * 20;
      this.y = newY;
      this.connectionUpdate();
    }
  }
  
  void connectionUpdate(){
    if(connection != null){
      this.connection.changeStart(this);
    }
    if(prev != null){
      this.prev.connection.changeEnd(this);
    }
  }
  void scrollMove(float val){
    if(this instanceof LogicBlock){
      this.connectionUpdate();
      return;
    }
    float newX = x - 20 * val;
    scrollScale = val;
    this.g.setPosition(newX, y);
    this.connectionUpdate();
  }
  
  int getX(){
    return (int) this.g.getAbsolutePosition()[0];
  }
  
  int getY(){
    return (int) this.g.getAbsolutePosition()[1];
  }
}

public class StartBlock extends CommandBlock{
  public StartBlock(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);
    this.g.getCaptionLabel().set("Start")
                            .setFont(cf);
    this.g.setColorBackground(color(0,170,0));
    this.g.setColorActive(color(0,170,0));
    this.g.setColorForeground(color(0,170,0));
    this.g.setOpen(false);
    this.g.setBarHeight(75);
  }
  
  void execute(){
    print("start");
    if(this.next != null){
      print("nex");
      this.next.execute();
    }
  }
}