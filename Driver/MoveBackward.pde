public class MoveBackward extends CommandBlock{
  private float currPow;
  public MoveBackward(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);
    this.g.getCaptionLabel().set("Move Backwards")
                            .setFont(cf);
    this.currPow=0;
  }
  

 /* public void updatePos(){
      //t1.updateSpeed(false);
      t1.updatePos(t1.getXSpeed(), t1.getYSpeed());
      execute();
  }*/
  
  void execute() {   
  }
}