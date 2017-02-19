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
    timer++;
  }
  
  public void tracking(){
    super.forward();
    if (target == null) {
      findTarget();
    }
    else {
      super.setReloadTime(25);
      fill(0, 0, 0);
      text("!", (int)(this.getPos()[0]) - 20, (int)(this.getPos()[1]) - 50);
      
      double targetX = target.getPos()[0];
      double targetY = target.getPos()[1];
      super.stop();
      if (targetX < 0 && targetY < 0){
        super.getBaseSprite().setRot(225);
        super.getHeadSprite().setRot(225);
        if (super.getBaseSprite().getRot() == 225) {
          super.stop();
        }
      }
      else if (targetX > 0 && targetY < 0){
        super.getBaseSprite().setRot(315);
        super.getHeadSprite().setRot(315);
        if (super.getBaseSprite().getRot() == 315) {
          super.stop();
        }
      }
      else if (targetX > 0 && targetY > 0){
        super.getBaseSprite().setRot(45);
        super.getHeadSprite().setRot(45);
        if (super.getBaseSprite().getRot() == 45) {
          super.stop();
        }
      }
      else {
        super.getBaseSprite().setRot(135);
        super.getHeadSprite().setRot(135);   
        if (super.getBaseSprite().getRot() == 135) {
          super.stop();
        }
      }
      print(super.getBaseSprite().getRot());
    /*    if ((targetX < 0 && targetY < 0) || (targetX > 0 && targetY < 0)){
          super.getBaseSprite().setDirection((atan((float)(targetY/targetX))) + PI);
          super.getHeadSprite().setDirection((atan((float)(targetY/targetX))) + PI);
          if (super.getHeadSprite().getDirection() <= (atan((float)(targetY/targetX))) + PI) {
             super.stop(); 
             print("stop");
          }
        }
        else {
          super.getBaseSprite().setDirection((atan((float)(targetY/targetX))));
          super.getHeadSprite().setDirection((atan((float)(targetY/targetX)))); 
        }*/
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