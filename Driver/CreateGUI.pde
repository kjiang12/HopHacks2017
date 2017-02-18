import controlP5.*;

class DropDownMenu {
  ControlP5 cp5;
  DropdownList d1;
  String[] options = {"If", "Sin", "Cos", "Tan", "Move Forward", "Brake", "Turn Left", "Turn Right", "Stop Turning", "Turn Turret Left", "Turn Turret Right", "Stop Turning Turret", "Fire", "For", "While",
                      "Get My Angular Velocity", "Get Enemy Angular Velocity", "Get My Angle", "Get Enemy Angle", "Get My Velocity", "Get Enemy Velocity", "Get My Position", "Get Enemy Position", "Kenneth Sucks"};
  
  public DropDownMenu(ControlP5 cp5) {
    this.cp5 = cp5; 
    d1 = cp5.addDropdownList("myList-d1")
          .setPosition(0, 100)
          .setFont(new ControlFont(createFont("Times",12)))
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
  }
  
  void setVisible(boolean isVisible) {
    d1.setVisible(isVisible);
  }
}