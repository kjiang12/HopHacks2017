public class Bot extends Tank{
  int timer;
  int randomTime;
  public Bot(float health, double x, double y, float tankAngle, float turrAngle, Sprite base_sprite, Sprite head_sprite,int reloadTime){
    super(health, x, y, tankAngle, turrAngle, base_sprite, head_sprite, reloadTime);
    timer = 0;
    randomTime = ((int) (Math.random() * 200));
  }
  
  public void update(){
    super.update();
    this.movement();
    
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
  
  
}