public class GetTankAngVel extends CommandBlock{
  public GetTankAngVel(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);
    this.g.getCaptionLabel().set("Get Tank Angular Velocity").setFont(cf);
  }

  void execute() {
      tank.getAngVel();
  }

}