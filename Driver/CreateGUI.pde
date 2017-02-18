import controlP5.*;

class DropDownMenu {
  ControlP5 cp5;
  DropdownList d1;
  String choice;
  String[] options = {"If", "Sin", "Cos", "Tan", "Move Forward", "Brake", "Turn Left", "Turn Right", "Stop Turning", "Turn Turret Left", "Turn Turret Right", "Stop Turning Turret", "Fire", "For", "Get My Angular Velocity", "Get Enemy Angular Velocity", 
                      "Get My Angle", "Get Enemy Angle", "Get My Velocity", "Get Enemy Velocity", "Get My Position", "Get Enemy Position", "Get My Reloading Time", "Get Enemy Reloading Time", "Get My Turret Angular Velocity", "Get Enemy Turret Angular Velocity"};
  boolean onOff;
  
  public DropDownMenu(ControlP5 cp5) {
    this.cp5 = cp5; 
    onOff = false;
    d1 = cp5.addDropdownList("myList-d1")
          .setPosition(0, 100)
          .setFont(new ControlFont(createFont("Times",12)))
          .onClick(new CallbackListener(){
           public void controlEvent(CallbackEvent event) {
             if (!onOff) {
               onOff = true;
             } else if (onOff) {
               addControl(event.getController().getLabel());
               onOff = false; 
             }
           }
     });
          ;   
    customize(d1);

  }
  
  void customize(DropdownList ddl) {
    ddl.setBackgroundColor(color(190));
    ddl.setItemHeight(60);
    ddl.setBarHeight(40);
    ddl.setHeight(400);
    ddl.setWidth(200);
    ddl.addItems(options);
    ddl.setColorBackground(color(60));
    ddl.setColorActive(color(255, 128));
    ddl.setOpen(false);
    ddl.setVisible(false);
  }
  
  void setVisible(boolean isVisible) {
    d1.setVisible(isVisible);
  }
  
  void addControl(String label) {
    println(label);
    if (label.equals("If")) {  
      control.add(new IfStatement(cp5, cf, stageLists.getTankList().get(0)));    
    } else if (label.equals("Sin")) {
      control.add(new Sin(cp5, cf, stageLists.getTankList().get(0))); 
    } else if (label.equals("Cos")) {
      control.add(new Cos(cp5, cf, stageLists.getTankList().get(0))); 
    } else if (label.equals("Tan")) {
      control.add(new Tan(cp5, cf, stageLists.getTankList().get(0))); 
    } else if (label.equals("Move Forward")) {
      control.add(new MoveForward(cp5, cf, stageLists.getTankList().get(0))); 
    } else if (label.equals("Brake")) {
      control.add(new Brake(cp5, cf, stageLists.getTankList().get(0))); 
    } else if (label.equals("Turn Left")) {
      control.add(new TurnLeft(cp5, cf, stageLists.getTankList().get(0))); 
    } else if (label.equals("Turn Right")) {
      control.add(new TurnRight(cp5, cf, stageLists.getTankList().get(0))); 
    } else if (label.equals("Stop Turning")) {
      control.add(new StopTurning(cp5, cf, stageLists.getTankList().get(0))); 
    } else if (label.equals("Turn Turret Left")) {
      control.add(new TurnTurretLeft(cp5, cf, stageLists.getTankList().get(0))); 
    } else if (label.equals("Turn Turret Right")) {
      control.add(new TurnTurretRight(cp5, cf, stageLists.getTankList().get(0))); 
    } else if (label.equals("Stop Turning Turret")) {
      control.add(new StopTurningTurret(cp5, cf, stageLists.getTankList().get(0))); 
    } else if (label.equals("Fire")) {
      control.add(new Fire(cp5, cf, stageLists.getTankList().get(0)));
    } else if (label.equals("For")) {
      control.add(new ForLoop(cp5, cf, stageLists.getTankList().get(0)));
    } else if (label.equals("Get My Angular Velocity")) {
      control.add(new GetMyAngVel(cp5, cf, stageLists.getTankList().get(0))); 
    } else if (label.equals("Get Enemy Angular Velocity")) {
      control.add(new GetEnemyAngVel(cp5, cf, stageLists.getTankList().get(0))); 
    } else if (label.equals("Get My Angle")) {
      control.add(new GetMyAngle(cp5, cf, stageLists.getTankList().get(0))); 
    } else if (label.equals("Get Enemy Angle")) {
      control.add(new GetEnemyAngle(cp5, cf, stageLists.getTankList().get(0))); 
    } else if (label.equals("Get My Velocity")) {
      control.add(new GetMyVel(cp5, cf, stageLists.getTankList().get(0))); 
    } else if (label.equals("Get Enemy Velocity")) {
      control.add(new GetEnemyVel(cp5, cf, stageLists.getTankList().get(0))); 
    } else if (label.equals("Get My Position")) {
      control.add(new GetMyPos(cp5, cf, stageLists.getTankList().get(0))); 
    } else if (label.equals("Get Enemy Position")) {
      control.add(new GetEnemyPos(cp5, cf, stageLists.getTankList().get(0))); 
    } else if (label.equals("Get My Reloading Time")) {
      control.add(new GetMyReloadingTime(cp5, cf, stageLists.getTankList().get(0))); 
    } else if (label.equals("Get Enemy Reloading Time")) {
      control.add(new GetEnemyReloadingTime(cp5, cf, stageLists.getTankList().get(0))); 
    } else if (label.equals("Get My Turret Angular Velocity")) {
      control.add(new GetMyTurrAngVel(cp5, cf, stageLists.getTankList().get(0))); 
    } else if (label.equals("Get Enemy Turret Angular Velocity")) {
      control.add(new GetEnemyTurrAngVel(cp5, cf, stageLists.getTankList().get(0)));  
    }
    control.setVisible(true);
  }
}