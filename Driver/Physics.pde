static class Physics {
  private static final float MASS = 30000;
  private static final float MAX_SPEED = 13.33;
  private static final float HP_TO_JPS = 746;
  private static final float FPS = 60;
  
  static float[] getNewSpeed(float power, float[] currentSpeed, float currentAngle) {
    float currentEnergyX = getEnergy(currentSpeed[0]);
    float currentEnergyY = getEnergy(currentSpeed[1]);
    float newEnergyX = currentEnergyX + getComponent(hpToJps(power), currentAngle, true);
    float newEnergyY = currentEnergyY + getComponent(hpToJps(power), currentAngle, false);
    
    float[] returnArr = new float[2];
    returnArr[0] = min(getSpeed(newEnergyX), getComponent(MAX_SPEED, currentAngle, true));
    returnArr[1] = min(getSpeed(newEnergyY), getComponent(MAX_SPEED, currentAngle, false));
    
    return returnArr;
  }
  
  private static float getSpeed(float energy) {
    return sqrt(2*energy/MASS);
  }
  
  private static float getEnergy(float speed) {
    return 0.5*MASS*pow(speed, 2.0);
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