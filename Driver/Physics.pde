static class Physics {
  private static final float MASS = 30000;
  private static final double MAX_VEL= 5.33;
  private static final float MIN_VEL= 3.0;
  private static final float ACC = 1.87;
  private static final float FPS = 60;
  private static final double BRAKE = 1.55;
  private static final float TANK_TURN = 37 * PI / 180.0;
  private static final float TANK_TURN_ACC = 30 * PI / 180.0;
  private static final float TURRET_TURN = 38 * PI / 180.0;
  private static final float TURRET_TURN_ACC = 30 * PI / 180.0;
  private static final float LENGTH = 6;
  private static final float WIDTH = 3;
  private static final float I = 112500;
  private static final int SCALE = 10; //SCALE pixels = 1 m
  
  static float stopTurretTurn(float angularVelocity) {
    if (angularVelocity < 0) {
      angularVelocity = turnTurretRight(angularVelocity); 
    } else if (angularVelocity > 0) {
      angularVelocity = turnTurretLeft(angularVelocity);
    }
    
    if (angularVelocity > -0.1 && angularVelocity < 0.1) {
      angularVelocity = 0; 
    }
    
    return angularVelocity;
  }
  
  static float turnTurretLeft(float angularVelocity) {
    return max(angularVelocity - TURRET_TURN_ACC, -TURRET_TURN) / FPS;
  }
  
  static float turnTurretRight(float angularVelocity) {
    return min(angularVelocity + TURRET_TURN_ACC, TURRET_TURN) / FPS;
  }
  
  static float stopTurn(float angularVelocity) {
    if (angularVelocity < 0) {
      angularVelocity = turnRight(angularVelocity); 
    } else if (angularVelocity > 0) {
      angularVelocity = turnLeft(angularVelocity);
    }
    
    if (angularVelocity > -0.1 && angularVelocity < 0.1) {
      angularVelocity = 0; 
    }
    
    return angularVelocity;
  }
  
  static float turnLeft(float angularVelocity) {
    return max(angularVelocity - TANK_TURN_ACC, -TANK_TURN) / FPS;
  }
  
  static float turnRight(float angularVelocity) {
    return min(angularVelocity + TANK_TURN_ACC, TANK_TURN) / FPS;
  }
  
  static void brake(Sprite base_sprite, Sprite head_sprite) {
    Vector2D vel = new Vector2D(base_sprite.getVelX(), base_sprite.getVelY());
    
    if (base_sprite.getSpeed() > 0.1) {
      Vector2D reverseVel = vel.getReverse();
      reverseVel.normalize();
      reverseVel.mult(BRAKE);
      base_sprite.setAccXY(reverseVel.x, reverseVel.y);
    } else {
      base_sprite.setSpeed(0); 
    }
    
    base_sprite.update(.1);
    head_sprite.setPos(new Vector2D(base_sprite.getX(), base_sprite.getY()));
  }

  static void forward(Sprite base_sprite, Sprite head_sprite) {
    base_sprite.setAcceleration(ACC);
    
    if (base_sprite.getSpeed() > MAX_VEL) {
      base_sprite.setSpeed(MAX_VEL);
    }
    
    base_sprite.update(.1);
    head_sprite.setPos(new Vector2D(base_sprite.getX(), base_sprite.getY()));
  }
  
  private static float getComponent(float val, float angle, boolean x) {
    return x ? val * cos(degToRad(angle)) : val * sin(degToRad(angle));
  }
  
  private static float degToRad(float angle) {
     return (angle - 40) * PI / 180.0; 
  }
}