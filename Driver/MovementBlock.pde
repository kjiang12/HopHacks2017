public abstract class MovementBlock extends CommandBlock{
  float currPow = 0;
  Slider slide;
  
  public MovementBlock(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);
    this.currPow = 0;
     
  }
  
  
  void setGroup(String s){
    super.setGroup(s); /*
    slide = cp5.addSlider("Slide " + this.id)
     .setPosition(20,20)
     .setSize(180,30)
     .setGroup(this.g)
     .setRange(0,460)
     .setFont(new ControlFont(createFont("Times",12)))
     .setCaptionLabel("Power")
     .onChange(new CallbackListener(){
       public void controlEvent(CallbackEvent event) {
         currPow = event.getController().getValue();
      }
     }); */
  }
  abstract void execute();
}

public class MoveBackward extends MovementBlock{
  public MoveBackward(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Move Backwards").setFont(cf);
     
  }

  void execute() {
    tank.backward();
  }
}

public class MoveForward extends MovementBlock{
  public MoveForward(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Move Forward").setFont(cf);
  }

  void execute() {
    tank.forward();
  }

}

public class TurnLeft extends MovementBlock{
  public TurnLeft(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Turn Left").setFont(cf);
  }

  void execute() {
    tank.turnLeft();
  }

}

public class TurnRight extends MovementBlock{
  public TurnRight(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Turn Right").setFont(cf);
  }

  void execute() {
    tank.turnRight();
  }

}

public class TurnTurretLeft extends MovementBlock{
  public TurnTurretLeft(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Turn Turret Left").setFont(cf);
  }

  void execute() {
    tank.turnTurretLeft();
  }

}

public class TurnTurretRight extends MovementBlock{
  public TurnTurretRight(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Turn Turret Right").setFont(cf);
  }

  void execute() {
    tank.turnTurretRight();
  }

}