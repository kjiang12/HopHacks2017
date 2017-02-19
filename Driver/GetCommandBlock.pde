public abstract class GetCommandBlock extends CommandBlock{
  
  ControlGroup tankAngGroup, reloadGroup, turrAngGroup;
  Tank myTank, enemyTank;
  public GetCommandBlock(ControlP5 cp5, ControlFont cf, Tank myTank, Tank enemyTank){
    super(cp5, myTank);
    this.myTank = myTank;
    this.enemyTank = enemyTank;
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
    super.g.setBackgroundColor(color(255, 0, 0));
  }
  abstract float getFloatValue();
  abstract int getIntValue();
  abstract double getDoubleValue();
  abstract double[] getDoubleArrValue();
  abstract void execute();
    
}

/*** everything below needs to be written ***/

public class GetMyPos extends GetCommandBlock{
  public GetMyPos(ControlP5 cp5, ControlFont cf, Tank myTank, Tank enemyTank){
    super(cp5, cf, myTank, enemyTank);
    this.g.getCaptionLabel().set("Get My Position").setFont(cf);
  }
  
  float getFloatValue() {
     throw new UnsupportedOperationException();
  }
  
  int getIntValue() {
     throw new UnsupportedOperationException();
  }
  
  double getDoubleValue() {
     throw new UnsupportedOperationException();
  }
  
  double[] getDoubleArrValue(){
      return myTank.getPos();
  }
  void execute() {
    println("IMPLEMENT GETMYPOS");
  }
}

public class GetEnemyPos extends GetCommandBlock{
  public GetEnemyPos(ControlP5 cp5, ControlFont cf, Tank myTank, Tank enemyTank){
    super(cp5, cf, myTank, enemyTank);
    this.g.getCaptionLabel().set("Get Enemy Position").setFont(cf);
  }
  float getFloatValue() {
     throw new UnsupportedOperationException();
  }
  
  int getIntValue() {
     throw new UnsupportedOperationException();
  }
  
  double getDoubleValue() {
     throw new UnsupportedOperationException(); 
  }
  
  double[] getDoubleArrValue(){
      return enemyTank.getPos();
  }
  void execute() {
    println("IMPLEMENT GETENEMYPOS");
  }
}

public class GetMyVel extends GetCommandBlock{
  public GetMyVel(ControlP5 cp5, ControlFont cf, Tank myTank, Tank enemyTank){
    super(cp5, cf, myTank, enemyTank);
    this.g.getCaptionLabel().set("Get My Velocity").setFont(cf);
  }
  float getFloatValue() {
    throw new UnsupportedOperationException();
  }
  
  int getIntValue() {
    throw new UnsupportedOperationException();
  }
  
  double getDoubleValue() {
    throw new UnsupportedOperationException(); 
  }
  
  double[] getDoubleArrValue(){
    return myTank.getVel();
  }
  void execute() {
    println("IMPLEMENT GETMYVEL");
  }
}

public class GetMySpeed extends GetCommandBlock{
  public GetMySpeed(ControlP5 cp5, ControlFont cf, Tank myTank, Tank enemyTank){
    super(cp5, cf, myTank, enemyTank);
    this.g.getCaptionLabel().set("Get My Speed").setFont(cf);
  }
  float getFloatValue() {
    println("x: " + myTank.getVel()[0]);
    println("x^2: " + pow((float) myTank.getVel()[0], 2.0));
    return sqrt(pow((float) myTank.getVel()[0], 2.0) + pow((float) myTank.getVel()[1], 2.0));
  }
  
  int getIntValue() {
    throw new UnsupportedOperationException();
  }
  
  double getDoubleValue() {
    throw new UnsupportedOperationException(); 
  }
  
  double[] getDoubleArrValue(){
     throw new UnsupportedOperationException(); 
  }
  void execute() {
    println(this.getFloatValue());
  }
}

public class GetEnemyVel extends GetCommandBlock{
  public GetEnemyVel(ControlP5 cp5, ControlFont cf, Tank myTank, Tank enemyTank){
    super(cp5, cf, myTank, enemyTank);
    this.g.getCaptionLabel().set("Get Enemy Velocity").setFont(cf);
  }
  
  float getFloatValue() {
    throw new UnsupportedOperationException();
  }
  
  int getIntValue() {
    throw new UnsupportedOperationException();
  }
  
  double getDoubleValue() {
    throw new UnsupportedOperationException(); 
  }
  
  double[] getDoubleArrValue(){
    return enemyTank.getVel();
  }
  void execute() {
    println("IMPLEMENT GETENEMYVEL");
  }
}

public class GetMyAngle extends GetCommandBlock{
  public GetMyAngle(ControlP5 cp5, ControlFont cf, Tank myTank, Tank enemyTank){
    super(cp5, cf, myTank, enemyTank);
    this.g.getCaptionLabel().set("Get My Angle").setFont(cf);
  }
  
  float getFloatValue() {
    throw new UnsupportedOperationException(); 
  }
  
  int getIntValue() {
    throw new UnsupportedOperationException(); 
  }
  
  double getDoubleValue(){
    return myTank.getTankAngle();
  }
  
  double[] getDoubleArrValue() {
    throw new UnsupportedOperationException();
  }
  
  void execute() {
    println("IMPLEMENT GETMYANGLE");
  }
}

public class GetEnemyAngle extends GetCommandBlock{
  public GetEnemyAngle(ControlP5 cp5, ControlFont cf, Tank myTank, Tank enemyTank){
    super(cp5, cf, myTank, enemyTank);
    this.g.getCaptionLabel().set("Get Enemy Angle").setFont(cf);
  }
  
  float getFloatValue() {
    throw new UnsupportedOperationException(); 
  }
  
  int getIntValue() {
    throw new UnsupportedOperationException(); 
  }
  
  double getDoubleValue(){
    return enemyTank.getTankAngle();
  }
  
  double[] getDoubleArrValue() {
    throw new UnsupportedOperationException(); 
  }
  void execute() {
    println("IMPLEMENT GETENEMYANGLE");
  }
}

public class GetMyAngVel extends GetCommandBlock{
  public GetMyAngVel(ControlP5 cp5, ControlFont cf, Tank myTank, Tank enemyTank){
    super(cp5, cf, myTank, enemyTank);
    this.g.getCaptionLabel().set("Get My Angular Velocity").setFont(cf);
  }
  
  float getFloatValue(){
    return myTank.getTankAngVel();
  }
  
  int getIntValue() {
    throw new UnsupportedOperationException(); 
  }
  
  double getDoubleValue() {
    throw new UnsupportedOperationException(); 
  }
  
  double[] getDoubleArrValue() {
    throw new UnsupportedOperationException(); 
  }
  
  void execute() {
  
  }
}

public class GetEnemyAngVel extends GetCommandBlock{
  public GetEnemyAngVel(ControlP5 cp5, ControlFont cf, Tank  myTank, Tank enemyTank){
    super(cp5, cf, myTank, enemyTank);
    this.g.getCaptionLabel().set("Get Enemy Angular Velocity").setFont(cf);
  }
  float getFloatValue(){
    return enemyTank.getTankAngVel();
  }
  
  int getIntValue() {
    throw new UnsupportedOperationException(); 
  }
  
  double getDoubleValue() {
    throw new UnsupportedOperationException(); 
  }
  
  double[] getDoubleArrValue() {
    throw new UnsupportedOperationException(); 
  }
  
  void execute() {

  }
}

public class GetMyReloadingTime extends GetCommandBlock{
  public GetMyReloadingTime(ControlP5 cp5, ControlFont cf, Tank myTank, Tank enemyTank){
    super(cp5, cf, myTank, enemyTank);
    this.g.getCaptionLabel().set("Get My Reload Time").setFont(cf);
  }
  
  float getFloatValue() {
    throw new UnsupportedOperationException(); 
  }
  
  int getIntValue(){
    return myTank.getReloadTime();
  }
  
  double getDoubleValue() {
    throw new UnsupportedOperationException(); 
  }
  
  double[] getDoubleArrValue() {
    throw new UnsupportedOperationException();
  }
  
  void execute() {

  }
}

public class GetEnemyReloadingTime extends GetCommandBlock{
  public GetEnemyReloadingTime(ControlP5 cp5, ControlFont cf, Tank myTank, Tank enemyTank){
    super(cp5, cf, myTank, enemyTank);
    this.g.getCaptionLabel().set("Get Enemy Reload Time").setFont(cf);
  }
  
  float getFloatValue() {
    throw new UnsupportedOperationException();
  }
  
  int getIntValue(){
    return enemyTank.getReloadTime();
  }
  
  double getDoubleValue() {
    throw new UnsupportedOperationException();
  }
  
  double[] getDoubleArrValue() {
    throw new UnsupportedOperationException(); 
  }
  
  void execute() {

  }
}

public class GetMyTurrAngVel extends GetCommandBlock{
  public GetMyTurrAngVel(ControlP5 cp5, ControlFont cf, Tank myTank, Tank enemyTank){
    super(cp5, cf, myTank, enemyTank);
    this.g.getCaptionLabel().set("Get My Turret Angular Velocity").setFont(cf);
  }
  
  float getFloatValue(){
    return myTank.getTurrAngVel();
  }
  
  int getIntValue() {
    throw new UnsupportedOperationException(); 
  }
  
  double getDoubleValue() {
    throw new UnsupportedOperationException(); 
  }
  
  double[] getDoubleArrValue() {
    throw new UnsupportedOperationException(); 
  }
  
  void execute() {

  }
}

public class GetEnemyTurrAngVel extends GetCommandBlock{
  public GetEnemyTurrAngVel(ControlP5 cp5, ControlFont cf, Tank myTank, Tank enemyTank){
    super(cp5, cf, myTank, enemyTank);
    this.g.getCaptionLabel().set("Get Enemy Turret Angular Velocity").setFont(cf);
  }
  
  float getFloatValue() {
    return enemyTank.getTurrAngVel();
  }
  
  int getIntValue() {
    throw new UnsupportedOperationException(); 
  }
  
  double getDoubleValue() {
    throw new UnsupportedOperationException(); 
  }
  
  double[] getDoubleArrValue() {
    throw new UnsupportedOperationException(); 
  }
  
  void execute() {

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