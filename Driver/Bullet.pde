public class Bullet{
  int x;
  int y;
  Sprite sprite;
  public Bullet(int x, int y, Sprite sprite){
    this.x = x;
    this.y = y;
    this.sprite = sprite;
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
  public void setX(int x){
   this.x = x; 
  }
  public void setY(int y){
   this.y = y; 
  }
  public void setX(Sprite sprite){
   this.sprite = sprite; 
  }
  public void update(){
    
    
  }
}