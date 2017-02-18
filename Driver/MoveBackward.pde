public class MoveBackward extends CommandBlock{
  private float currPow;
  public MoveBackward(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);
    this.g.getCaptionLabel().set("Move Backward").setFont(cf);
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
      tank.getXSpeed(false);
      tank.getYSpeed(false);
  }

}