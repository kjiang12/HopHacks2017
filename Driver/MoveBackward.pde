public class MoveBackward extends CommandBlock{
  public MoveBackward(ControlP5 cp5, ControlFont cf){
    super(cp5);
    this.g.getCaptionLabel().set("Move Backwards")
                            .setFont(cf);
 //   this.t1=t1;
  //  this.currPow=currPow;
  }
  public void updatePos(){
   //   t1.updateSpeed(false);
   //   t1.updatePos(t1.getXSpeed(), t1.getYSpeed());
      execute();
  }
  
  void execute() {
        draw();    
  }
}