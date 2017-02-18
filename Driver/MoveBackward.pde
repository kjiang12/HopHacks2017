public class MoveBackward extends CommandBlock{
  private Tank t1;
  private float currPow;
  public MoveBackward(ControlP5 cp5, ControlFont cf, Tank t1, float currPow){
    super(cp5, t1);
    this.g.getCaptionLabel().set("Move Backwards")
                            .setFont(cf);
    this.currPow=currPow;
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
      t1.updateSpeed(false);
      t1.updatePos(t1.getXSpeed(), t1.getYSpeed());
  }
}