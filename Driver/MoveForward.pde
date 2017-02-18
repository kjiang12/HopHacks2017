public class MoveForward extends CommandBlock{
  private float currPow;
  public MoveForward(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);
    this.g.getCaptionLabel().set("Move Forward").setFont(cf);
    currPow=0;
  }

  public void setPower(float currPow)
  {
      this.currPow=currPow;
  }
  public float getPower()
  {
      return currPow;
  }
  void execute() {
      tank.updatePos(true);
  }

}