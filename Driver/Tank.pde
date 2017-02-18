import sprites.Sprite;

public class Tank {
  private float health;
  private float[] vel;
  private float[] pos;
  private boolean detected;
  private float tankAngVel;
  private float turrAngVel;
  private float tankAngle, turrAngle;
  boolean fired;
  private String moveState; // "Brake" "Forward" "Backward"
  private String turnState; // "Stop Turn" "Turn Left" "Turn Right"
  private String turrState; // "Stop Turn Turret" "Turn Turret Left" "Turn Turret Right"
  private int reloadTime;
  private Sprite base_sprite;
  private Sprite head_sprite;
            
  public Tank(float health, float xCor, float yCor, float tankAngle, float turrAngle, Sprite base_sprite, Sprite head_sprite, int reloadTime) {
    pos = new float[2];
    pos[0] = xCor;
    pos[1] = yCor;
    vel = new float[2];
    fired=false;
    this.health = health;
    this.tankAngle = tankAngle;
    this.turrAngle = turrAngle;
    tankAngVel = 0;
    moveState = "Brake";
    turnState = "Stop Turn";
    turrState = "Stop Turret Turn";

    this.base_sprite = base_sprite;
    this.head_sprite = head_sprite;
    this.reloadTime = reloadTime;
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
              
    // update turret angle
    turrAngle += turrAngVel;

    // update velocity
    if (moveState.equals("Forward")) {
      vel = Physics.getNewForwardVel(vel, tankAngle);
    } else if (moveState.equals("Backward")) {
      vel = Physics.getNewBackwardVel(vel, tankAngle);
    } else if (moveState.equals("Brake")) {
      vel = Physics.brake(vel, tankAngle); 
    }
    
    // update position
    pos[0] += vel[0];
    pos[1] += vel[1];
    
    // update reload time
    reloadTime--;
  }
  
  void draw(){
    base_sprite.setX(pos[0]);
    base_sprite.setY(pos[1]);
    base_sprite.setRot(tankAngle);
    head_sprite.setX(pos[0]);
    head_sprite.setY(pos[1]);
    head_sprite.setRot(turrAngle);
    base_sprite.draw();
    head_sprite.draw();
  }
  
  public float[] getPos() {
    return pos;
  }
              
  public float[] getVel(boolean forward, float xSpeed, float ySpeed) {
    return vel;
  }
                  
  public float getTankAngVel() {          
    return tankAngVel;
  }
  
  public float getTurrAngVel(){
    return turrAngVel;
  }
            
  public float getTankAngle() {
    return tankAngle;
  }
            
  public float getTurrAngle() {
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
  public void lowerHealth(float damage) {
    this.health=this.health-damage;
  }
            
  public void setDetection(boolean detected) {
    this.detected=detected;
  }
            
  public void setBaseSprite(Sprite base_sprite) {
    this.base_sprite=base_sprite;
  }
            
  public void setHeadSprite(Sprite head_sprite) {
    this.head_sprite=head_sprite;
  }
  
  public void setReloadTime(int reloadTime){
    this.reloadTime = reloadTime; 
  }
  
  public void detection(float xDist, float yDist) {
    int r= (int) Math.sqrt(xDist*xDist+yDist*yDist);
    if (r<= 10) {
      setDetection(true);
    }
  }
  
  //TURNING STUFF (Both tank and turret)
  //AIMING/ FIRING (Also zooming)
  public float getHealth() {
    return health;
  }
  public boolean fired(){
      return fired;
  }
  public void setFired(boolean fired){
      this.fired=fired;
  }
  public void fireBullet(){
    if (reloadTime == 0) {
        setFired(true);
    }
    s
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