public class StageLists{
  private ArrayList<Bullet> bullets= new ArrayList<Bullet>();
  private ArrayList<Obstacle> obstacles= new ArrayList<Obstacle>();
  private ArrayList<Tank> tanks= new ArrayList<Tank>();
  
  public StageLists(){
    
    
  }
  public ArrayList<Bullet> getBulletList(){
    return this.bullets;
  }
  
  public void addItem(Bullet bullet){
    this.bullets.add(bullet);
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
  }
}