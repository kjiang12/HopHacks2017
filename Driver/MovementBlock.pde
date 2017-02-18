public abstract class MovementBlock extends CommandBlock{
  float currPow = 0;
  
  public MovementBlock(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);
    this.currPow = 0;
    
    cp5.addSlider("Power")
     .setPosition(20,20)
     .setSize(180,30)
     .setGroup(this.g)
     .setRange(0,460)
     .setFont(new ControlFont(createFont("Times",12)));     
  }
  
  void execute(){
  }   
}

public class MoveBackward extends MovementBlock{
  public MoveBackward(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Move Backwards")
                            .setFont(cf);
     
  }

  void execute() {
    super.execute();
    tank.backward();
  }
}

public class MoveForward extends MovementBlock{
  public MoveForward(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Move Forward").setFont(cf);
  }

  void execute() {
    super.execute();
    tank.forward();
  }

}