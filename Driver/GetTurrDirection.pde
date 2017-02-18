public class GetTurrDirection extends CommandBlock{
  public GetTurrDirection(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);
    this.g.getCaptionLabel().set("Get Turret Direction").setFont(cf);
  }

  void execute() {
      tank.getTurrAngle();
  }

}