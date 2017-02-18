static int count = 0;

public abstract class CommandBlock{
  protected ControlP5 cp5;
  protected ControlGroup g;
  protected Tank tank;
  
  public CommandBlock(ControlP5 cp5, Tank tank){
    this.cp5 = cp5;
    this.g = cp5.addGroup(count + "")
             .setPosition(100,100)
             .setBackgroundHeight(100)
             .setSize(300,100)
             .setBarHeight(20)
             .setBackgroundColor(color(255,80))
             .disableCollapse();
    count++;
    this.tank = tank;
  }
  
  abstract void execute();

  void move(float x, float y){
    float[] pos = g.getPosition();
    float newX = pos[0] + x;
    float newY = pos[1] + y;
    print(newX);
    print(newY);
    if(newX > 0 && newY - 20 > 0 && newX + 300 < width && newY + 100 < height){
      g.setPosition(pos[0] + x, pos[1] + y);
    }
  }
}