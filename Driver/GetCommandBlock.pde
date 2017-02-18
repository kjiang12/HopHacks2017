public abstract class GetCommandBlock extends CommandBlock{
  public GetCommandBlock(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);
  }
  
  abstract void execute();
}

/*** everything below needs to be written ***/

public class GetTankAngVel extends GetCommandBlock{
  public GetTankAngVel(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Get Tank Angular Velocity").setFont(cf);
  }

  void execute() {
      tank.getTankAngVel();
  }

}


public class GetReloadingTime extends GetCommandBlock{
  public GetReloadingTime(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
  }

  void execute() {
  }

}

public class GetTurrAngVel extends GetCommandBlock{
  public GetTurrAngVel(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Get Turret Angular Velocity").setFont(cf);
  }

  void execute() {
      tank.getTurrAngVel();
  }

}

/*public class GetVel extends GetCommandBlock{
  boolean forward;
  public GetVel(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Get Velocity").setFont(cf);
    forward=true;
  }
  public void setFoward(boolean forward){
    this.forward=forward;
  }
  void execute() {
    tank.getVel(forward, tank.getXPos(), tank.getYPos());
  }

}*/