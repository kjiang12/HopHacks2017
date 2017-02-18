static class Physics {
  private static final float MASS = 30000;
  private static final float MAX_VEL= 13.33;
  private static final float MIN_VEL= -5.0;
  private static final float HP_TO_JPS = 746;
  private static final float FPS = 60;
  private static final float BRAKE = 1.55;
  private static final float TANK_TURN = 37;
  private static final float TANK_TURN_ACC = 2.5;
  private static final float TURRET_TURN = 38.59;
  private static final float TURRET_TURN_ACC = 5;
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
    return max(angularVelocity - TURRET_TURN_ACC / FPS, -TURRET_TURN);
  }
  
  static float turnTurretRight(float angularVelocity) {
    return min(angularVelocity + TURRET_TURN_ACC / FPS, TURRET_TURN);
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
    return max(angularVelocity - TANK_TURN_ACC / FPS, -TANK_TURN);
  }
  
  static float turnRight(float angularVelocity) {
    return min(angularVelocity + TANK_TURN_ACC / FPS, TANK_TURN);
  }
  
  static float[] brake(float[] currentVel, float currentAngle) {
      currentVel[0] -= BRAKE * cos(degToRad(currentAngle)) * SCALE;
      currentVel[1] -= BRAKE * cos(degToRad(currentAngle)) * SCALE;
      
      return currentVel;
  }
  
  static float[] getNewBackwardVel(float power, float[] currentVel, float currentAngle) {
    float currentEnergyX = getEnergy(currentVel[0]);
    float currentEnergyY = getEnergy(currentVel[1]);
    float newEnergyX = currentEnergyX + getComponent(hpToJps(-1 * power), currentAngle, true);
    float newEnergyY = currentEnergyY + getComponent(hpToJps(-1 * power), currentAngle, false);
    
    float[] returnArr = new float[2];
    returnArr[0] = max(getVel(newEnergyX), getComponent(MIN_VEL, currentAngle, true)) * SCALE;
    returnArr[1] = max(getVel(newEnergyY), getComponent(MIN_VEL, currentAngle, false)) * SCALE;
    
    return returnArr;
  }
  
  static float[] getNewForwardVel(float power, float[] currentVel, float currentAngle) {
    float currentEnergyX = getEnergy(currentVel[0]);
    float currentEnergyY = getEnergy(currentVel[1]);
    float newEnergyX = currentEnergyX + getComponent(hpToJps(power), currentAngle, true);
    float newEnergyY = currentEnergyY + getComponent(hpToJps(power), currentAngle, false);
    
    float[] returnArr = new float[2];
    returnArr[0] = min(getVel(newEnergyX), getComponent(MAX_VEL, currentAngle, true)) * SCALE;
    returnArr[1] = min(getVel(newEnergyY), getComponent(MAX_VEL, currentAngle, false)) * SCALE;
    
    return returnArr;
  }
  
  // Allows for negative energy: negative = backwards
  private static float getVel(float energy) {
    return (energy / abs(energy)) * sqrt(2*abs(energy)/MASS);
  }
  
  // Allows for negative energy: negative = backwards
  private static float getEnergy(float vel) {
    return (vel / abs(vel)) * 0.5*MASS*pow(vel, 2.0);
  }
  
  private static float hpToJps(float hp) {
    return (hp * HP_TO_JPS) / FPS; 
  }
  
  private static float getComponent(float val, float angle, boolean x) {
    return x ? val * cos(angle) : val * sin(angle);
  }
  
  private static float degToRad(float angle) {
     return angle * PI / 180.0; 
  }
}