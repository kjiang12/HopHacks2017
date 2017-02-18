public class GetTurrAngVel extends CommandBlock{
  public GetTurrAngVel(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);
    this.g.getCaptionLabel().set("Get Turret Angular Velocity").setFont(cf);
  }

  void execute() {
      tank.getTurrAngVel();
  }

}