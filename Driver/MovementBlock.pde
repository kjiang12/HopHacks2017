public abstract class MovementBlock extends CommandBlock{
  Slider slide;
  
  public MovementBlock(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);
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
    this.selected();
    if(this.next != null){
      this.next.execute();
    }
  }
}

public class MoveForward extends MovementBlock{
  public MoveForward(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Move Forward").setFont(cf);
  }

  void execute() {
    tank.forward();
    this.selected();
    if(this.next != null){
      this.next.execute();
    }
  }

}

public class TurnLeft extends MovementBlock{
  public TurnLeft(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Turn Left").setFont(cf);
  }

  void execute() {
    tank.turnLeft();
    this.selected();
    if(this.next != null){
      this.next.execute();
    }
  }

}

public class TurnRight extends MovementBlock{
  public TurnRight(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Turn Right").setFont(cf);
  }

  void execute() {
    tank.turnRight();
    this.selected();
    if(this.next != null){
      this.next.execute();
    }
  }

}

public class TurnTurretLeft extends MovementBlock{
  public TurnTurretLeft(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Turn Turret Left").setFont(cf);
  }

  void execute() {
    tank.turnTurretLeft();
    this.selected();
    if(this.next != null){
      this.next.execute();
    }
  }

}

public class TurnTurretRight extends MovementBlock{
  public TurnTurretRight(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Turn Turret Right").setFont(cf);
  }

  void execute() {
    tank.turnTurretRight();
    this.selected();
    if(this.next != null){
      this.next.execute();
    }
  }
}
  
public class StopTurning extends MovementBlock{
  public StopTurning(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Stop Turning").setFont(cf);
  }

  void execute() {
    tank.stopTurn();
    this.selected();
    if(this.next != null){
      this.next.execute();
    }
  }
}

public class StopTurningTurret extends MovementBlock{
  public StopTurningTurret(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Stop Turning Turret").setFont(cf);
  }

  void execute() {
    tank.stopTurretTurn();
    this.selected();
    if(this.next != null){
      this.next.execute();
    }
  }
}


public class Brake extends MovementBlock{
  public Brake(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Brake").setFont(cf);
  }

  void execute() {
    tank.brake();
    this.selected();
    if(this.next != null){
      this.next.execute();
    }
  }
}

public class Wait extends MovementBlock{
  int time, curr;
  
  Textfield timeField;
  public Wait(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Wait").setFont(cf);
    
    cp5.addTextlabel("label1 " + this.id)
                    .setText(" Time ")
                    .setPosition(50, 15)
                    .setFont(new ControlFont(createFont("Times", 20)))
                    .setGroup(this.g);
                    
    timeField = cp5.addTextfield("input2 " + this.id)
     .setPosition(120,10)
     .setSize(60,40)
     .setFont(cf)
     .setGroup(this.g)
     .setCaptionLabel("")
     .setColor(color(255,0,0));
     
  }

  void execute() {
    try {
      time = (int) Float.parseFloat(timeField.getText());
    } catch (Exception e){
      time = 0;
    }
    if(curr >= time){
      if(!current.contains(this)){
        curr = 0;
        this.selecting();
        current.push(this);
      }
      curr++;
    } else {
      current.pop();
      this.selected();
      if(this.next != null){
        this.next.execute();
      }
    }
  }
}