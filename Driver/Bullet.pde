public class Bullet{
  Sprite sprite;
  double angle;
  private int distTrav;
  private int origXLoc=0;
  private int origYLoc=0;
  public Bullet(int x, int y, Sprite sprite, double angle){
    this.sprite = sprite;
    this.distTrav=0;
    this.origXLoc= (int) (x + 28 * cos((float) angle));
    this.origYLoc= (int) (y + 28 * sin((float) angle));
    this.sprite.setXY(x + 28 * cos((float)angle), y + 28 * sin((float)angle));
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
  public int update(){
    sprite.setRot(angle);
    sprite.setDirection(angle);
    sprite.setSpeed(5);
    sprite.update(0.4);
    distTrav= (int) Math.abs(Math.sqrt((getX()-origXLoc)*(getX()-origXLoc) + (getY()-origYLoc)*(getY()-origYLoc)));
    return distTrav;
  }
}