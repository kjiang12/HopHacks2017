import sprites.Sprite;
import sprites.maths.Vector2D;

public class Tank {
  private int health;
  private int maxHealth;
  private boolean detected;
  private float tankAngVel;
  private float turrAngVel;
  private float tankAngle, turrAngle;
  private String moveState; // "Brake" "Forward" "Backward"
  private String turnState; // "Stop Turn" "Turn Left" "Turn Right"
  private String turrState; // "Stop Turn Turret" "Turn Turret Left" "Turn Turret Right"
  private int reloadTime;
  private int reloadDecrementer;
  private Sprite base_sprite;
  private Sprite head_sprite;
  private boolean fired;

  public Tank(int health, double x, double y, float tankAngle, float turrAngle, Sprite base_sprite, Sprite head_sprite,int reloadTime) {
    this.health = health;
    this.maxHealth = health;
    this.tankAngle = tankAngle;
    this.turrAngle = turrAngle;
    tankAngVel = 0;
    moveState = "Brake";
    turnState = "Stop Turn";
    turrState = "Stop Turret Turn";
    this.base_sprite = base_sprite;
    this.head_sprite = head_sprite;
    this.base_sprite.setPos(new Vector2D(x, y));
    this.head_sprite.setPos(new Vector2D(x, y));
    this.reloadTime = reloadTime;
    reloadDecrementer = reloadTime;
    fired = true;
  }
  
  public void update() {
    // update tank angular velocity
    if (turnState.equals("Stop Turn")) {
      tankAngVel = Physics.stopTurn(tankAngVel);
    } else if (turnState.equals("Turn Left")){
      tankAngVel = Physics.turnLeft(tankAngVel);
    } else if (turnState.equals("Turn Right")){
      tankAngVel = Physics.turnRight(tankAngVel);
    }
    
    // update turret angular velocity
    if (turrState.equals("Stop Turret Turn")){
      turrAngVel = Physics.stopTurretTurn(turrAngVel);
    } else if (turrState.equals("Turn Turret Left")){
      turrAngVel = Physics.turnTurretLeft(turrAngVel);
    } else if (turrState.equals("Turn Turret Right")){
      turrAngVel = Physics.turnTurretRight(turrAngVel);
    }
              
    // update tank angle
    tankAngle += tankAngVel;
    tankAngle %= 2*PI;
              
    // update turret angle
    turrAngle += turrAngVel;
    turrAngle %= 2*PI;

    // update velocity
    if (moveState.equals("Forward")) {
      Physics.forward(base_sprite, head_sprite);
    } else if (moveState.equals("Brake")) {
      Physics.brake(base_sprite, head_sprite); 
    }
    
    // update reload time
    reloadDecrementer--;
  }
  
  void draw(){
    base_sprite.setRot(tankAngle);
    base_sprite.setDirection(tankAngle);
    head_sprite.setRot(turrAngle);
    base_sprite.draw();
    head_sprite.draw();
    
    
    rectMode(CORNER);

    if(Math.abs(base_sprite.getX() - mouseX) <=15 && Math.abs(base_sprite.getY() - mouseY) <=15){
      ellipseMode(CENTER);
      noFill();
      stroke(153);
      ellipse((int) getPos()[0], (int) getPos()[1], 350, 350);
      noStroke();
    }
    
    fill(255,0,0);  
    rect((int)(this.getPos()[0]) - 20, (int)(this.getPos()[1]) - 20, 50, 5);
    fill(0,255,0);
    rect((int)(this.getPos()[0]) - 20, (int)(this.getPos()[1]) - 20, (int)(50 * ((double) health / maxHealth)), 5);
    
    fill(0, 0, 0);
    text(health + "/" + maxHealth, (int)(this.getPos()[0]) - 20, (int)(this.getPos()[1]) - 30);
     
    


  }
  
  public double[] getPos() {
    double[] returnArr = new double[2];
    returnArr[0] = base_sprite.getX();
    returnArr[1] = base_sprite.getY();
    
    return returnArr;
  }
              
  public double[] getVel() {
    double[] returnArr = new double[2];
    returnArr[0] = base_sprite.getVelX();
    returnArr[1] = base_sprite.getVelY();
    
    return returnArr;
  }
  
  public void stop(){
   base_sprite.setVelXY(0,0); 
   head_sprite.setVelXY(0,0);  
   tankAngVel = 0;
  }
                  
  public float getTankAngVel() {          
    return tankAngVel;
  }
  
  public float getTurrAngVel(){
    return turrAngVel;
  }
            
  public double getTankAngle() {
    return tankAngle;
  }
            
  public double getTurrAngle() {
    return turrAngle;
  }
  
  public void forward() {
    moveState = "Forward"; 
  }
  
  public void backward() {
    moveState = "Backward"; 
  }
  
  public void brake() {
    moveState = "Brake"; 
  }
  
  public void turnLeft() {
    turnState = "Turn Left"; 
  }
  
  public void turnRight() {
    turnState = "Turn Right"; 
  }
  
  public void stopTurn() {
    turnState = "Stop Turn"; 
  }
  
  public void turnTurretLeft() {
    turrState = "Turn Turret Left";
  }
  
  public void turnTurretRight() {
    turrState = "Turn Turret Right"; 
  }
  
  public void stopTurretTurn() {
    turrState = "Stop Turn Turret"; 
  }
          
  public Sprite getBaseSprite() {
    return base_sprite;
  }
            
  public Sprite getHeadSprite() {
    return head_sprite;
  }
            
  public int getReloadTime(){
    return reloadTime; 
  }
  
  public int getReloadDecrementer(){
    return reloadDecrementer; 
  }
            
  public void setDetection(boolean detected) {
    this.detected = detected;
  }
            
  public void setBaseSprite(Sprite base_sprite) {
    this.base_sprite = base_sprite;
  }
            
  public void setHeadSprite(Sprite head_sprite) {
    this.head_sprite = head_sprite;
  }

  
  public void setReloadTime(int reloadTime){
    this.reloadTime = reloadTime; 
  }

  public void setReloadDecrementer(int reloadDecrementer){
    this.reloadDecrementer = reloadDecrementer; 
  }

  public int getMaxRange() {
    return 175;
    }
  
  //TURNING STUFF (Both tank and turret)
  //AIMING/ FIRING (Also zooming)
  public int getHealth() {
    return health;
  }
  
  public void setHealth(int health){
    this.health = health;
  }
  
  public int getMaxHealth() {
    return maxHealth;
  }
  
  public void setMaxHealth(int maxHealth){
    this.maxHealth = maxHealth;
  }
  
  public void lowerHealth(int damage) {
    this.health = health - damage;
  }
  
  public boolean fired(){
    return fired;
  }
  
  public void setFired(boolean fired){
    this.fired = fired;
  }
  
  public void fireBullet(){
    if (reloadDecrementer <= 0) {
      setFired(true);
    }  
  }
}
      
      
          
        //aiming methods
          //turning turret
          
          //zooming in on other tank
          
          //
        //firing methods
          //fire
          //reloading
          
        //enemy tank detection
            //circle spotting radius
                //if the other tank is detected, then the turrent and firing methods come into play
        
        
//TAUNTING METHODS    