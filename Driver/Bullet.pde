public class Bullet{
  int x;
  int y;
  Sprite sprite;
  double angle;
  public Bullet(int x, int y, Sprite sprite, double angle){
    this.x = x;
    this.y = y;
    this.sprite = sprite;
    this.angle = angle;
  }
  public int getX(){
   return x; 
  }
  public int getY(){
   return y; 
  }
  public Sprite getSprite(){
   return sprite; 
  }
  public double getAngle(){
   return angle; 
  }
  public void setX(int x){
   this.x = x; 
  }
  public void setY(int y){
   this.y = y; 
  }
  public void setSprite(Sprite sprite){
   this.sprite = sprite; 
  }
  public void setAngle(double angle){
   this.angle = angle; 
  }
  public void update(){
    sprite.setRot(angle);
    x += cos((float) angle);
    y += sin((float) angle);
    sprite.setX(x);
    sprite.setY(y);
  }
}