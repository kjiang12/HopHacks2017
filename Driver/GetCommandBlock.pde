public abstract class GetCommandBlock extends CommandBlock{
  public GetCommandBlock(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);
  }
  
  abstract float getValue();
  abstract void execute();
  
}

/*** everything below needs to be written ***/

public class GetTankAngVel extends GetCommandBlock{
  public GetTankAngVel(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Get Tank Angular Velocity").setFont(cf);
  }
  float getValue(){
      return tank.getTankAngVel();
  }
  void execute() {
      tank.getTankAngVel();
  }

}


public class GetReloadingTime extends GetCommandBlock{
  public GetReloadingTime(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Get Reload Time").setFont(cf);
  }
  float getValue(){
    return tank.getReloadTime();
  }
  void execute() {
     tank.getReloadTime();
  }

}

public class GetTurrAngVel extends GetCommandBlock{
  public GetTurrAngVel(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Get Turret Angular Velocity").setFont(cf);
  }
  float getValue(){
    return tank.getTurrAngVel();
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