import controlP5.*;
import sprites.Sprite;

public class StageLists{
  private ArrayList<Bullet> bullets= new ArrayList<Bullet>();
  private ArrayList<Obstacle> obstacles= new ArrayList<Obstacle>();
  private ArrayList<Tank> tanks= new ArrayList<Tank>();
  private float xTrav=0;
  private float yTrav=0;
  private ArrayList<Explosion> explosions= new ArrayList<Explosion>();
  PApplet app;
  
  public StageLists(PApplet app){
     this.app = app;
     generateObstacles(2);
     generateBots(50);

     this.addItem(new Tank(100, 500, 500, PI / 3, 50, new Sprite(app,"../TankBase1.png",0), new Sprite(app,"../TankHead5.png",0),20));

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
  
  public void drawObjects(boolean doUpdate){
    for(int i = 0; i < bullets.size(); i++){
      boolean remove=false;
      if (bullets.get(i).getX() > width || bullets.get(i).getX() < 0 || bullets.get(i).getY() > height || bullets.get(i).getY() < 0 ){
       bullets.remove(i);
      }
      else{
        if (doUpdate) {
          if(bullets.get(i).update()>175){
              remove = true;
          }          
        }
        if(remove){
            bullets.remove(i);
            remove=false;
        }
        else{
        bullets.get(i).getSprite().draw();
        }
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
        if (doUpdate) {
          explosions.get(i).getSprite().setScale(explosions.get(i).getTick() / 25);
       //   explosions.get(i).getSprite().setY(explosions.get(i).getSprite().getY() - (explosions.get(i).getTick() * 10));
        }
        explosions.get(i).getSprite().draw();
        if (doUpdate) {
          explosions.get(i).setTick(explosions.get(i).getTick() + 1);
        }
      }
    }
    for(Tank tank: tanks){
    //  tank.turnLeft();
    //  tank.turnTurretRight();
    //  tank.forward();
    //  tank.fireBullet();
    //  println(tank.getTankAngle());
      if (doUpdate) {
        tank.update();
      }
      tank.draw();
    }

    if (doUpdate){
      checkBullet();
      collisionCheck();
    }
  }
  
  void collisionCheck(){
   // println(bullets.size());
   for (int i = obstacles.size() - 1; i > 0; i--){
     for (int j = 0; j < tanks.size(); j++){
       if(obstacles.get(i).getSprite().bb_collision(tanks.get(j).getBaseSprite())){
         tanks.get(j).stop();
       }
       if (tanks.get(j).getPos()[0] > width || tanks.get(j).getPos()[0] < 0 || tanks.get(j).getPos()[1] > height || tanks.get(j).getPos()[1] < 0){
         tanks.get(j).stop();
       }
       
     }
   }
   
  ArrayList<Integer> removedObstacles = new ArrayList<Integer>();
  
  int i = obstacles.size() - 1;
  while (i >= 0){
     for (int k = bullets.size() - 1; k >= 0; k--){
       if(obstacles.get(i).getSprite().bb_collision(bullets.get(k).getSprite())){
         bullets.remove(k);
         removedObstacles.add(i);
       }
     }
     i--;
   }
   
   for (i = removedObstacles.size() - 1; i >= 0; i--){
     this.addItem(new Explosion(obstacles.get(i).getX(), obstacles.get(i).getY(), new Sprite(app,"../Explosion.png",0)));
     obstacles.remove(i);
   }
   
   for(i = 0; i < tanks.size(); i++){
       for (int  j=0; j < tanks.size(); j++){
          if(i!=j && tanks.get(i).getBaseSprite().bb_collision(tanks.get(j).getBaseSprite()))
          {
              tanks.get(i).stop();
              tanks.get(i).lowerHealth(1);
              tanks.get(j).stop();
              tanks.get(j).lowerHealth(1);
          }
       }
   }
   
     for (int l = 0; l < tanks.size(); l++){
       for (int k = bullets.size() - 1; k >= 0; k--){
          if(bullets.get(k).getSprite().bb_collision(tanks.get(l).getBaseSprite())){
            bullets.remove(k);
            tanks.get(l).lowerHealth(((int) (Math.random() * 20)) + 10);

          }
        }
     }
      checkDeath();
  }
  
  public void checkDeath(){
     for(int i = tanks.size() - 1; i >= 0; i--){
         if (tanks.get(i).getHealth() <= 0) {
            this.addItem(new Explosion(tanks.get(i).getPos() [0], tanks.get(i).getPos() [1], new Sprite(app,"../Explosion.png",0)));
            tanks.remove(i);
            
         }
     }
  }
  
public void generateBots(int numberOfBots){
    boolean overlap = false;
    int i = 0;
    while (i < numberOfBots){
      Bot bot = new Bot(100, ((int) (Math.random() * (width - 50)) + 20),((int) (Math.random() * (height - 50)) + 20), (PI / 12) * ((int) (Math.random() * 12)), (PI / 12) * ((int) (Math.random() * 12)), new Sprite(app,"../TankBase" + (((int) (Math.random() * 2)) + 1) + ".png",0), new Sprite(app,"../TankHead" + (((int) (Math.random() * 4)) + 1) + ".png",0),50);
      for (Obstacle obstacle: obstacles){
       if(obstacle.getSprite().pp_collision(bot.getBaseSprite())){
         overlap = true;
         break;
       }
      }
      for (Tank tank: tanks){
       if(tank.getBaseSprite().pp_collision(bot.getBaseSprite())){
         overlap = true;
         break;
       }
      }
      if (!overlap) {
        this.addItem(bot);
        i++;
        }
      else {
         overlap = false; 
      }
    }
    
    
  }
  void checkBullet(){
    for(Tank tank: tanks){
      if(tank.fired()){
          double [] pos = tank.getPos();
          Bullet bullet = new Bullet(((int) pos[0]), ((int) pos[1]), new Sprite(app,"../Bullet.png",0), tank.getTurrAngle());
          this.addItem(bullet);
          tank.setFired(false);
          tank.setReloadDecrementer(tank.getReloadTime());
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
      for (Obstacle obstacle: obstacles){
       if(obstacle.getSprite().pp_collision(crate.getSprite())){
         overlap = true;
         break;
       }
      }
      for (Tank tank: tanks){
       if(tank.getBaseSprite().pp_collision(crate.getSprite())){
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
      for (Obstacle obstacle: obstacles){
       if(obstacle.getSprite().pp_collision(barrel.getSprite())){
         overlap = true;
         break;
       }
      }
      for (Tank tank: tanks){
       if(tank.getBaseSprite().pp_collision(barrel.getSprite())){
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