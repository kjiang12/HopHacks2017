import sprites.Sprite;

public class Tank {
  private float health;
  private float power;
  private float[] vel;
  private float[] pos;
  private boolean detected;
  private float tankAngVel;
  private float turrAngVel;
  private float tankAngle, turrAngle;
  private String moveState = "Brake"; // "Brake" "Forward" "Backward"
  private String turnState = "Stop Turn"; // "Stop Turn" "Turn Left" "Turn Right"
  private String turrState = "Stop Turret Turn"; // "Stop Turn Turret" "Turn Turret Left" "Turn Turret Right"
  private Sprite base_sprite;
  private Sprite head_sprite;
            
  public Tank(float health, float xCor, float yCor, float tankAngle, float turrAngle, Sprite base_sprite, Sprite head_sprite) {
    pos = new {xCor, yCor};
    vel = new float[2];
    power=0;
    this.health = health;
    this.tankAngle = tankAngle;
    this.turrAngle = turrAngle;
    tankAngVel = 0;
    turrAngVel;
    this.base_sprite = base_sprite;
    this.head_sprite = head_sprite;
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
    tankAngle = tankAngle + tankAngVel * (((float) 1)/60);
              
    // update turret angle
    turrAngle=turrAngle + turrAngVel * (((float) 1)/60);
            
<<<<<<< HEAD
    // update velocity
    if (moveState.equals("Forward") {
      vel = Physics.getNewForwardVel(getPower(), vel, tankAngle;
    } else if (moveState.equals("Backward")) {
      vel = Physics.getNewBackwardVel(getPower(), vel, tankAngle);
    } else if (moveState.equals("Brake")) {
      vel = Physics.brake(vel, tankAngle); 
    }
    
    // update position
    pos[0] += vel[0] / 60.0;
    pos[1] += vel[1] / 60.0;
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
      
  public float getPower() {
    return power;
  }
              
  public void setPower(float power) {
    this.power=power;
  }
            
  public Sprite getBaseSprite() {
    return base_sprite;
  }
            
  public Sprite getHeadSprite() {
    return head_sprite;
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
          
  public void detection(float xDist, float yDist) {
    int r= (int) Math.sqrt(xDist*xDist+yDist*yDist);
    if (r<= 10) {
      setDetection(true);
    }
  }
  
  //TURNING STUFF (Both tank and turret)
  //AIMING/ FIRING (Also zooming)
  private float getHealth() {
    return health;
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
            