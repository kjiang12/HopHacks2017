public abstract class GetCommandBlock extends CommandBlock{
  
  ControlGroup tankAngGroup, reloadGroup, turrAngGroup;
  
  public GetCommandBlock(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);
    this.h = 150;
    
    /*this.g.setOpen(true);
    this.g.getCaptionLabel().set("Get Tank Angle").setFont(cf);
    this.g.setSize(this.w, this.h);
    this.tankAngGroup = cp5.addGroup("Get Tank Angle" + this.id)
             .setPosition(10,50)
             .setBackgroundHeight(100)
             .setSize(w,h)
             .setBarHeight(40)
             .setBackgroundColor(color(80,0,180))
             .setFont(new ControlFont(createFont("Times",12)))
             .setOpen(false)
             .disableCollapse()
             .setGroup(this.g)
             .setVisible(false);
             
   this.reloadGroup = cp5.addGroup("Get Reload Time " + this.id)
             .setPosition(10,100)
             .setBackgroundHeight(100)
             .setSize(w,h)
             .setBarHeight(40)
             .setBackgroundColor(color(80,0,180))
             .setFont(new ControlFont(createFont("Times",12)))
             .setOpen(false)
             .disableCollapse()
             .setGroup(this.g)
             .setVisible(false);
             //.setCaptionLabel("Then");
             
             
   this.turrAngGroup = cp5.addGroup("Get Turret Angle " + this.id)
             .setPosition(10,150)
             .setBackgroundHeight(100)
             .setSize(w,h)
             .setBarHeight(40)
             .setBackgroundColor(color(80,0,180))
             .setFont(new ControlFont(createFont("Times",12)))
             .setOpen(false)
             .disableCollapse()
             .setGroup(this.g)
             .setVisible(false);
             //.setCaptionLabel("Else");*/
  }
  void setGroup(String s){
    super.setGroup(s);
    super.g.setBackgroundColor(color(255, 0, 0));}
  abstract float getValue();
  abstract void execute();
    
}

/*** everything below needs to be written ***/

public class GetTankAngVel extends GetCommandBlock{
  public GetTankAngVel(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Get Tank Angular Velocity").setFont(cf);
  }
  float getValue(){
      return tank.getTankAngVel();
  }
  void execute() {
      tank.getTankAngVel();
  }

}

public class GetReloadingTime extends GetCommandBlock{
  public GetReloadingTime(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Get Reload Time").setFont(cf);
  }
  float getValue(){
    return tank.getReloadTime();
  }
  void execute() {
     tank.getReloadTime();
  }
}

public class GetTurrAngVel extends GetCommandBlock{
  public GetTurrAngVel(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Get Turret Angular Velocity").setFont(cf);
  }
  float getValue(){
    return tank.getTurrAngVel();
  }
  void execute() {
      tank.getTurrAngVel();
  }
  
  }



/*public class GetVel extends GetCommandBlock{
  boolean forward;
  public GetVel(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Get Velocity").setFont(cf);
    forward=true;
  }
  public void setFoward(boolean forward){
    this.forward=forward;
  }
  void execute() {
    tank.getVel(forward, tank.getXPos(), tank.getYPos());
  }

}*/