import sprites.Sprite;

public class Explosion{
  Sprite sprite;
  int tick;
  public Explosion(double x, double y, Sprite sprite){
    this.sprite = sprite;
    this.sprite.setX(x);
    this.sprite.setY(y);
    tick = 25;
  }
  public double getX(){
   return sprite.getX(); 
  }
  public double getY(){
   return sprite.getY(); 
  }
  public Sprite getSprite(){
   return sprite; 
  }
  public int getTick(){
   return tick; 
  }
  public void setX(double x){
   sprite.setX(x); 
  }
  public void setY(double y){
   sprite.setY(y); 
  }
  public void setSprite(Sprite sprite){
   this.sprite = sprite; 
  }
  public void setTick(int tick){
   this.tick = tick;
  }
}