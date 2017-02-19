public class Bot extends Tank{
  int timer;
  int randomTime;
  Tank target;
  ArrayList<Tank> tanks;
  final int DETECTION_RANGE = 150;
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
      fill(0, 0, 0);
      text("!", (int)(this.getPos()[0]) - 20, (int)(this.getPos()[1]) - 50);
      
      super.stop();
      super.turnRight();
      super.turnTurretRight();
      if ((target.getPos()[0] < 0 && target.getPos()[1] < 0) || (target.getPos()[0] > 0 && target.getPos()[1] < 0)){
        super.getBaseSprite().setDirection((atan((float)(target.getPos()[1]/target.getPos()[0]))) + PI);
        super.getHeadSprite().setDirection((atan((float)(target.getPos()[1]/target.getPos()[0]))) + PI);
      }
      else {
        super.getBaseSprite().setDirection((atan((float)(target.getPos()[1]/target.getPos()[0]))));
        super.getHeadSprite().setDirection((atan((float)(target.getPos()[1]/target.getPos()[0])))); 
      }
      super.stop();
      checkTarget();
    }
    super.fireBullet();
  }
  
  public void findTarget(){
    for (Tank tank: tanks) {
      if (tank != this && tank.getPos()[0] > (super.getPos()[0] - DETECTION_RANGE) && tank.getPos()[0] < (super.getPos()[0] + DETECTION_RANGE) && tank.getPos()[1] > (super.getPos()[1] - DETECTION_RANGE) && tank.getPos()[1] < (super.getPos()[1] + DETECTION_RANGE)){
        target = tank;
        print("true");
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