static int count = 0;

public abstract class CommandBlock{
  protected ControlP5 cp5;
  protected ControlGroup g;
  
  public CommandBlock(ControlP5 cp5){
    this.cp5 = cp5;
    this.g = cp5.addGroup(count + "")
             .setPosition(100,100)
             .setBackgroundHeight(100)
             .setSize(300,100)
             .setBarHeight(20)
             .setBackgroundColor(color(255,80))
             .disableCollapse();
    count++;
  }
  
  abstract void execute();

  void move(float x, float y){
    float[] pos = g.getPosition();
    g.setPosition(pos[0] + x, pos[1] + y);
  }
}