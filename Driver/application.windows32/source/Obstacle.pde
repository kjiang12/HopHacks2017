import sprites.Sprite;

public abstract class Obstacle{
  Sprite sprite;
  public Obstacle(int x, int y, Sprite sprite){
    this.sprite = sprite;
    this.sprite.setX(x);
    this.sprite.setY(y);
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
  public void setX(double x){
   sprite.setX(x); 
  }
  public void setY(double y){
   sprite.setY(y); 
  }
  public void setX(Sprite sprite){
   this.sprite = sprite; 
  }
}

public class Barrel extends Obstacle{
  public Barrel(int x, int y, Sprite sprite){
    super(x, y, sprite);
  }
}

public class Crate extends Obstacle{
  public Crate(int x, int y, Sprite sprite){
    super(x, y, sprite);
  }
}