public class Bot extends Tank{
  private int timer;
  private int randomTime;
  private Tank target;
  private ArrayList<Tank> tanks;
  private final int DETECTION_RANGE = 150;
  
  public Bot(int health, double x, double y, float tankAngle, float turrAngle, Sprite base_sprite, Sprite head_sprite,int reloadTime, ArrayList<Tank> tanks){
    super(health, x, y, tankAngle, turrAngle, base_sprite, head_sprite, reloadTime, tanks);
    timer = 0;
    randomTime = ((int) (Math.random() * 200));
    this.tanks = tanks;
    target = null;
  }
  
  public void update(){
    super.update();
    if (target == null) {
      this.movement();
      this.tracking();
    }
    else {
      this.tracking();
    }
    
  }
  
  public void movement(){
    super.fireBullet();
    super.forward();
    if (timer < randomTime) {
      super.turnLeft();
      super.turnTurretRight();
      
    }
    else if (randomTime <= timer && timer < 200) {
       super.turnRight();
      super.turnTurretLeft();
      
    }
    else {
     timer = 0; 
     randomTime = ((int) (Math.random() * 200));
    }
    
    if (super.getPos()[0] > width - 20){
        double [] location = {width - 50, super.getPos()[1]};
         super.moveTo(location);
     }
     else if (super.getPos()[0] < 20){
       double [] location = {50,  super.getPos()[1]};
         super.moveTo(location);
     }    
     else if (super.getPos()[1] > height - 20){
       double [] location = {super.getPos()[0], height - 50};
         super.moveTo(location);
     }
     else if (super.getPos()[1] < 20){
       double [] location = { super.getPos()[0], 50};
         super.moveTo(location);
     }
    timer++;
  }
  
  public void tracking(){
    super.forward();
    if (target == null) {
      findTarget();
    }
    else {
      super.stopTurn();
      super.aimTo(target.getPos());
       super.fireBullet();
       checkTarget();
    }
    
    
    super.fireBullet();
  }
  
  public void findTarget(){
    for (Tank tank: tanks) {
      if (tank != this && tank.getPos()[0] > (super.getPos()[0] - DETECTION_RANGE) && tank.getPos()[0] < (super.getPos()[0] + DETECTION_RANGE) && tank.getPos()[1] > (super.getPos()[1] - DETECTION_RANGE) && tank.getPos()[1] < (super.getPos()[1] + DETECTION_RANGE)){
        target = tank;
      }
    }
  }
  
  public void checkTarget(){
     for (Tank tank: tanks) {
       if (tank == target) {
          if (tank.getPos()[0] > (super.getPos()[0] - DETECTION_RANGE) && tank.getPos()[0] < (super.getPos()[0] + DETECTION_RANGE) && tank.getPos()[1] > (super.getPos()[1] - DETECTION_RANGE) && tank.getPos()[1] < (super.getPos()[1] + DETECTION_RANGE)){
            return;
          }
       }
       
     }
     target = null;
  }
  
}