public class MoveBackward extends CommandBlock{
  float currPow = 0;
  
  public MoveBackward(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);
    this.g.getCaptionLabel().set("Move Backwards")
                            .setFont(cf);
    this.currPow = 0;
    
    cp5.addSlider("currPow")
     .setPosition(40,10)
     .setSize(180,30)
     .setGroup(this.g)
     ;
     
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
      tank.getPos(false);
  }

}