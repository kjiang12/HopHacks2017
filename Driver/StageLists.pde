import controlP5.*;
import sprites.Sprite;

public class StageLists{
  private ArrayList<Bullet> bullets= new ArrayList<Bullet>();
  private ArrayList<Obstacle> obstacles= new ArrayList<Obstacle>();
  private ArrayList<Tank> tanks= new ArrayList<Tank>();
  PApplet app;
  
  public StageLists(PApplet app){
     this.app = app;
     generateObstacles(25);
     this.addItem(new Tank(100, 50, 50, 60, 50, new Sprite(app,"../TankBase3.png",0), new Sprite(app,"../TankHead4.png",0),60));
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
  
  public void drawObjects(){
    for(Bullet bullet: bullets){
      bullet.getSprite().draw();
    }
    for(Obstacle obstacle: obstacles){
      obstacle.getSprite().draw();
    }
    for(Tank tank: tanks){
      tank.turnLeft();
      tank.turnTurretRight();
      println(tank.getTankAngle());
      tank.update();
      tank.draw();
    }
    for(Tank tank: tanks){
    if(tank.fired()){
        float [] pos = tank.getPos();
        Bullet b=new bullet(pos[0], pos[1]);
        bullets.add(b);
        tank.setFired(false);
    }
    }
    collisionCheck();
  }
  
  void collisionCheck(){
   for (Obstacle obstacle: obstacles){
     if(obstacle.getSprite().cc_collision(tanks.get(0).getBaseSprite())){
       System.out.print("Collision!");
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