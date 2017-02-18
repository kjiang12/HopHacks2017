      import sprites.Sprite;
      
        public class Tank {
            private float health;
            private float power;
            private float xSpeed;
            private float ySpeed;
            private float xCor, yCor;
            private boolean detected;
            private float angVel;
            private float turrAngVel;
            private float tankAngle, turrAngle;
            String state="Stop Turn";
            String turrState="Stop Turret Turn";
            private Sprite base_sprite;
            private Sprite head_sprite;
            
            public Tank(float health, float xCor, float yCor, float tankAngle, float turrAngle, Sprite base_sprite, Sprite head_sprite) {
              angVel=0;
              xSpeed=0;
              ySpeed=0;
              power=0;
              this.health = health;
              this.xCor = xCor;
              this.yCor = yCor;
              this.tankAngle = tankAngle;
              this.turrAngle = turrAngle;
              this.base_sprite = base_sprite;
              this.head_sprite = head_sprite;
            }
            public void setState(String s){
                state=s;
            }
            public void setTurrState(String s){
              turrState=s;
            }
            public float getAngVel() {
                if(state.equals("Stop Turn")) {
                  this.angVel=Physics.stopTurn(angVel);
                }
                else if(state.equals("Turn Left")){
                  this.angVel=Physics.turnLeft(angVel);
                }
                else if(state.equals("Turn Right")){
                  this.angVel=Physics.turnRight(angVel);
                }
                return angVel;
            }
            public float getTurrAngVel(){
              if(state.equals("Stop Turret Turn")){
                  this.angVel=Physics.stopTurretTurn(turrAngVel);
                }
                else if(state.equals("Turn Turret Left")){
                  this.angVel=Physics.turnTurretLeft(turrAngVel);
                }
                else if(state.equals("Turn Turret Right")){
                  this.angVel=Physics.turnTurretRight(turrAngVel);
                }
              return turrAngVel;
            }
            public float getXPos() {
              // call update pos
              return xCor;
            }
            public float getYPos() {
              // call update pos
                  return yCor;
            }
            // change to turret angle, call update for angle
            public float getTankAngle() {
                tankAngle=tankAngle + getAngVel() * (((float) 1)/60);
                return (tankAngle);
            }
            public float getTurrAngle() {
                turrAngle=turrAngle + getTurrAngVel() * (((float) 1)/60);
                return (turrAngle);
            }
            public float getPower() {
                return power;
            }
            public float getXSpeed(boolean forward) {
                updateSpeed(forward, xSpeed, ySpeed);
                return xSpeed;
            }
            public float getYSpeed(boolean forward) {
                updateSpeed(forward, xSpeed, ySpeed);
                return ySpeed;
            }
            public Sprite getBaseSprite() {
                return base_sprite;
            }
            public Sprite getHeadSprite() {
                return head_sprite;
            }
            public void setPower(float power) {
                this.power=power;
            }
            public void lowerHealth(float damage) {
                this.health=this.health-damage;
            }
            public void setPos(float xCor, float yCor) {
              this.xCor=xCor;
              this.yCor=yCor;
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
            
            
            
            private void updateSpeed(boolean forward, float xSpeed, float ySpeed) {
            float[] oldSpeed=new float[2];
            oldSpeed[0]=xSpeed;
            oldSpeed[1]=ySpeed;
            float[] newSpeed=new float[2];
            if(forward) {
              newSpeed=Physics.getNewForwardVel(getPower(), oldSpeed, getTankAngle());
            }
            else {
              newSpeed=Physics.getNewBackwardVel(getPower(), oldSpeed, getTankAngle());
            }
            xSpeed = newSpeed[0];
            ySpeed = newSpeed[1];
        }
        private void updatePos(boolean forward) {
            float x=getXPos()+ getXSpeed(forward) * (((float) 1)/60);
            float y=getYPos() + getXSpeed(forward) * (((float) 1)/60);
            xCor=x;
            yCor=y;
        }
        public void detection(float xDist, float yDist) {
            int r= (int) Math.sqrt(xDist*xDist+yDist*yDist);
            if (r<= 10) {
                setDetection(true);
            }
        }
        public void brake() {
            power=0;
        }
      
          //TURNING STUFF (Both tank and turret)
          
          
          //AIMING/ FIRING (Also zooming)
          private float getHealth() {
              return health;
          }
         
              //speed control
          private void speedUp() {
            
          }
          //changing directions
            //need to provide the current direction that the tank is facing, ie the angle
          private void turnRight() {
            
          }
          private void turnLeft() {
            
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
            