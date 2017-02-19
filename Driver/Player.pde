public class Player extends Tank{
  public Player(int health, double x, double y, float tankAngle, float turrAngle, Sprite base_sprite, Sprite head_sprite,int reloadTime){
    super(health, x, y, tankAngle, turrAngle, base_sprite, head_sprite, reloadTime);
  }
  
  void draw(){
    super.draw(); 
    fill(0, 0, 255);
    text(super.health + "/" + super.maxHealth, (int)(super.getPos()[0]) - 20, (int)(super.getPos()[1]) - 30);
  }
}