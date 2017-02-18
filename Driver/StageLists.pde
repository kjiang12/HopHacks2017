import controlP5.*;
import sprites.Sprite;

public class StageLists{
  private ArrayList<Bullet> bullets= new ArrayList<Bullet>();
  private ArrayList<Obstacle> obstacles= new ArrayList<Obstacle>();
  private ArrayList<Tank> tanks= new ArrayList<Tank>();
  private ArrayList<Explosion> explosions= new ArrayList<Explosion>();
  PApplet app;
  
  public StageLists(PApplet app){
     this.app = app;
     generateObstacles(50);
     this.addItem(new Tank(100, 500, 500, PI / 3, 50, new Sprite(app,"../TankBase.png",0), new Sprite(app,"../TankHead5.png",0),60));
  }
  public ArrayList<Bullet> getBulletList(){
    return bullets;
  }
  
  public void addItem(Bullet bullet){
    bullets.add(bullet);
  }
  
  public ArrayList<Obstacle> getObstacleList(){
    return this.obstacles;
  }
  
  public void addItem(Obstacle obstacle){
    this.obstacles.add(obstacle);
  }
  
  public ArrayList<Tank> getTankList(){
    return this.tanks;
  }
  
  public void addItem(Tank tank){
    this.tanks.add(tank);
  }
  
  public ArrayList<Explosion> getExplosionList(){
    return this.explosions;
  }
  
  public void addItem(Explosion explosion){
    this.explosions.add(explosion);
  }
  
  public void drawObjects(){
    for(int i = 0; i < bullets.size(); i++){
      if (bullets.get(i).getX() > width || bullets.get(i).getX() < 0 || bullets.get(i).getY() > height || bullets.get(i).getY() < 0){
       bullets.remove(i);
      }
      else{
        bullets.get(i).update();
        bullets.get(i).getSprite().draw();
      }
    }
    for(Obstacle obstacle: obstacles){
      obstacle.getSprite().draw();
    }
    for(int i = 0; i < explosions.size(); i++){
      if(explosions.get(i).getTick() == 150){
        explosions.remove(i);
      }
      else{
        explosions.get(i).getSprite().setScale(explosions.get(i).getTick() / 25);
        explosions.get(i).getSprite().draw();
        explosions.get(i).setTick(explosions.get(i).getTick() + 1);
      }
    }
    for(Tank tank: tanks){
      tank.turnLeft();
      tank.turnTurretRight();
    //  println(tank.getTankAngle());
      tank.update();
      tank.draw();
    }

    checkBullet();
    collisionCheck();
  }
  
  void collisionCheck(){
   for (int i = 0; i < obstacles.size(); i++){
     for (int j = 0; j < bullets.size(); j++){
       if(obstacles.get(i).getSprite().cc_collision(tanks.get(j).getBaseSprite())){
         tanks.get(j).stop();
       }
     }
     for (int k = 0; k < bullets.size(); k++){
       if(obstacles.get(i).getSprite().cc_collision(bullets.get(k).getSprite())){
         bullets.remove(k);
         this.addItem(new Explosion(obstacles.get(i).getX(), obstacles.get(i).getY(), new Sprite(app,"../Explosion.png",0)));
         obstacles.remove(i);
       }
     }
   }
  
  }
  
  void checkBullet(){
    for(Tank tank: tanks){
      if(tank.fired()){
          double [] pos = tank.getPos();
          //NEED TO CREATE SPRITE
          Bullet bullet = new Bullet(((int) pos[0]), ((int) pos[1]), new Sprite(app,"../Bullet.png",0), tank.getTurrAngle());
          println(bullet.getAngle());
          this.addItem(bullet);
          tank.setFired(false);
          tank.setReloadTime(60);
      }
    }    
  }
  void generateObstacles(int numberOfObstacles){
   boolean overlap = false;
    int i = 0;
    while (i < numberOfObstacles / 2){
      Crate crate = new Crate(((int) (Math.random() * (width - 50)) + 20),((int) (Math.random() * (height - 50)) + 20), new Sprite(app,"../Crate.png",0));
      crate.getSprite().setX(crate.getX());
      crate.getSprite().setY(crate.getY());
      crate.getSprite().setCollisionRadius((crate.getSprite().getHeight()/2) + 2);
      for (Obstacle obstacle: obstacles){
       if(obstacle.getSprite().cc_collision(crate.getSprite())){
         overlap = true;
         break;
       }
      }
      if (!overlap) {
        this.addItem(crate);
        i++;
      }
      else {
         overlap = false; 
      }
    }
    overlap = false;
    i = 0;
    while (i < numberOfObstacles / 2){
      Barrel barrel = new Barrel(((int) (Math.random() * (width - 50)) + 20),((int) (Math.random() * (height - 50)) + 20), new Sprite(app,"../Barrel.png",0));
      barrel.getSprite().setX(barrel.getX());
      barrel.getSprite().setY(barrel.getY());
      barrel.getSprite().setCollisionRadius((barrel.getSprite().getHeight()/2) + 2);
      for (Obstacle obstacle: obstacles){
       if(obstacle.getSprite().cc_collision(barrel.getSprite())){
         overlap = true;
         break;
       }
      }
      if (!overlap) {
        this.addItem(barrel);
        i++;
      }
      else {
         overlap = false; 
      }
    }
  }

}