static int count = 0;
public abstract class CommandBlock{
  
  ControlP5 cp5;
  Group g;
  
  public CommandBlock(ControlP5 cp5){
    this.cp5 = cp5;
    this.g = cp5.addGroup(count++ + "")
             .setPosition(100,100)
             .setBackgroundHeight(100)
             .setBackgroundColor(color(255,50));
  }
  
  abstract void execute();
}