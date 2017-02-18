      import sprites.Sprite;
      
        public class Tank {
            private float health;
            private float power;
            private float xSpeed;
            private float ySpeed;
            private float xCor, yCor;
            private boolean detected;
            private float angVel; // add angVel for turret 
            private float turrX, turrY; // I dont think we need this
            private float tankAngle, turrAngle;
            private Sprite base_sprite;
            private Sprite head_sprite;
            
            public Tank(float health, float xCor, float yCor, float turrX, float turrY, float tankAngle, float turrAngle, Sprite base_sprite, Sprite head_sprite) {
              angVel=0;
              xSpeed=0;
              ySpeed=0;
              power=0;
              this.health = health;
              this.xCor = xCor;
              this.yCor = yCor;
              this.turrX = turrX;
              this.turrY = turrY;
              this.tankAngle = tankAngle;
              this.turrAngle = turrAngle;
              this.base_sprite = base_sprite;
              this.head_sprite = head_sprite;
            }
            // make this for turret angle too
            public float getAngVel() {
                //call update for angVel (either turnLeft, turnRight, or stopTurn based on user choice)
                return angVel;
            }
            public void setAngVel(float angVel) {
              // instead, call turnLeft/turnRight/stopTurn
              // and for turret: turnTurretLeft, turnTurretRight, stopTurretTurn
                this.angVel=angVel;
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
            public float getTurrX() {
                return turrX;
            }
            public float getTurrY() {
                return turrY;
            }
            public float getAngle() {
              // this should call getAngVel and modify current tankAngle first
                return tankAngle;
            }
            public float getPower() {
                return power;
            }
            public float getXSpeed() {
              // call moveForward/backward first
                return xSpeed;
            }
            public float getYSpeed() {
              // call moveForward/backward first
                return ySpeed;
            }
            public Sprite getBaseSprite() {
                return base_sprite;
            }
            public Sprite getHeadSprite() {
                return head_sprite;
            }
            public void setDir(float angle) {
                this.tankAngle = angle;
            }
            public void setTurrDir(float angle) {
              this.turrAngle = angle;
            }
            public void setXSpeed(float speed) {
                this.xSpeed=speed;
            }
            public void setYSpeed(float speed) {
                this.ySpeed = speed;
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
            public void setTurrPos(float turrX, float turrY) {
                this.turrX=turrX;
                this.turrY=turrY;
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
            
            
            
       /*       public void updateSpeed(boolean forward) {
            float [] oldSpeed=new float[2];
            float[0]=getXSpeed();
            float[1]=getYSpeed();
            if(forward) {
              float[] newSpeed=Physics.getNewSpeed(getPower(), oldSpeed, getAngle());
            }
            else {
              float[] newSpeed=Physics.getNewSpeed(getPower(), oldSpeed, getAngle());
            }
            setXSpeed(newSpeed[0]);
            setYSpeed(newSpeed[1]);
        }*/
        public void updatePos(float xSpeed, float ySpeed) {
            float x=getXPos()+ xSpeed * (((float) 1)/60);
            float y=getYPos() + ySpeed * (((float) 1)/60);
            setPos(x, y);
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
            