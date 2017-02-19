public abstract class ActionCommandBlock extends CommandBlock{
  public ActionCommandBlock(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);
  }
  
  abstract void execute();
}

/*** everything below needs to be written ***/

public class Fire extends ActionCommandBlock{
  public Fire(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Fire").setFont(cf);
  }

  void execute() {
    println("aaaaa fire");
    tank.fireBullet();
    if(this.next != null){
      this.next.execute();
    }
  }

}