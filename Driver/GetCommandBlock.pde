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
      tank.getAngVel();
  }

}

/*
public class GetDirection extends GetCommandBlock{
  public GetDirection(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
  }

  void execute() {
  }

}

public class GetReloadingTime extends GetCommandBlock{
  public GetReloadingTime(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
  }

  void execute() {
  }

}

public class GetTankDirection extends GetCommandBlock{
  public GetTankDirection(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Get Tank Direction").setFont(cf);
  }

  void execute() {
      tank.getTankAngle();
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

public class GetTurrDirection extends GetCommandBlock{
  public GetTurrDirection(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Get Turret Direction").setFont(cf);
  }

  void execute() {
      tank.getTurrAngle();
  }

}

public class GetVel extends GetCommandBlock{
  public GetTankAngVel(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
  }

  void execute() {
  }

}
*/