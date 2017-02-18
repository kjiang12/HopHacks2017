public class Bullet{
  Sprite sprite;
  double angle;
  public Bullet(int x, int y, Sprite sprite, double angle){
    this.sprite = sprite;
    this.sprite.setXY(x, y);
    this.angle = angle;
  }
  public int getX(){
   return (int)sprite.getX();
  }
  public int getY(){
   return (int)sprite.getY();
  }
  public Sprite getSprite(){
   return sprite; 
  }
  public double getAngle(){
   return angle; 
  }
  public void setSprite(Sprite sprite){
   this.sprite = sprite; 
  }
  public void setAngle(double angle){
   this.angle = angle; 
  }
  public void update(){
    sprite.setRot(angle);
    sprite.setDirection(angle);
    sprite.setSpeed(5);
    sprite.update(0.4);
  }
}