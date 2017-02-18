static class Physics {
  private static final float MASS = 30000;
  private static final float MAX_VEL= 5.33;
  private static final float MIN_VEL= -3.0;
  private static final float ACC = 1.87;
  private static final float FPS = 60;
  private static final float BRAKE = 1.55;
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
  
  static float[] brake(float[] currentVel, float currentAngle) {
    if (currentVel[0] < -0.1 || currentVel[0] > 0.1) {
      currentVel[0] -= (currentVel[0] / abs(currentVel[0])) * getComponent(BRAKE, currentAngle, true) * SCALE / FPS;
    }
    if (currentVel[1] < -0.1 || currentVel[1] > 0.1) {
      currentVel[1] -= (currentVel[1] / abs(currentVel[1])) * getComponent(BRAKE, currentAngle, false) * SCALE / FPS;
    }
    
    if (currentVel[0] > -0.1 && currentVel[0] < 0.1) {
      currentVel[0] = 0; 
    }
      
    if (currentVel[1] > -0.1 && currentVel[1] < 0.1) {
      currentVel[1] = 0;
    }
      
    return currentVel;
  }
  
  static float[] getNewBackwardVel(float[] currentVel, float currentAngle) {
    float[] returnArr = new float[2];
    returnArr[0] = min(currentVel[0] - getComponent(ACC, currentAngle, true), getComponent(MIN_VEL, currentAngle, true)) * SCALE / FPS;
    returnArr[1] = min(currentVel[1] - getComponent(ACC, currentAngle, false), getComponent(MIN_VEL, currentAngle, false)) * SCALE / FPS;

    return returnArr;
  }
  
  static float[] getNewForwardVel(float[] currentVel, float currentAngle) {
    float[] returnArr = new float[2];
    returnArr[0] = max(currentVel[0] + getComponent(ACC, currentAngle, true), getComponent(MAX_VEL, currentAngle, true)) * SCALE / FPS;
    returnArr[1] = max(currentVel[1] + getComponent(ACC, currentAngle, false), getComponent(MAX_VEL, currentAngle, false)) * SCALE / FPS;
    println(returnArr[0] + " " + returnArr[1]);
    return returnArr;
  }
  
  private static float getComponent(float val, float angle, boolean x) {
    return x ? val * cos(angle) : val * sin(angle);
  }
}