public class MoveBackward extends CommandBlock{
  public MoveBackward(ControlP5 cp5, ControlFont cf){
    super(cp5);
    this.g.getCaptionLabel().set("Move Backwards")
                            .setFont(cf);
  }
  
  void execute() {
        System.out.print("Fire!");     
  }
}