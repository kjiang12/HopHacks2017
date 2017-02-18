public class GetTankDirection extends CommandBlock{
  public GetTankDirection(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);
    this.g.getCaptionLabel().set("Get Tank Direction").setFont(cf);
  }

  void execute() {
      tank.getTankAngle();
  }

}