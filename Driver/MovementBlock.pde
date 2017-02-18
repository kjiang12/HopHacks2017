public abstract class MovementBlock extends CommandBlock{
  int currPow = 0;
  
  public MovementBlock(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);
    this.currPow = 0;
    
    cp5.addSlider("currPow")
     .setPosition(40,10)
     .setSize(180,30)
     .setGroup(this.g)
     ;
     
  }

  abstract void execute();

}

public class MoveBackward extends MovementBlock{
  public MoveBackward(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Move Backwards")
                            .setFont(cf);
     
  }

  void execute() {
      tank.getPos(false);
  }

}

public class MoveForward extends MovementBlock{
  public MoveForward(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Move Forward").setFont(cf);
  }

  void execute() {
      tank.getPos(true);
  }

}