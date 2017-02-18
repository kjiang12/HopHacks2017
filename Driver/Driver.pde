  import java.util.LinkedList;
  import java.util.ListIterator;
  import controlP5.*;
  import sprites.Sprite;

  ControlP5 cp5;
  ControlFont cf;
  CommandBlock selectedObject;
  float initX;
  float initY;
  StageLists stageLists;
  CommandController control;
  boolean start;
  boolean firstRun = true;
  Boolean selected = false;
  CommandBlock selections;
  DropDownMenu ddm;
  Boolean displayCode = false;
  
 void setup (){
    size(1260, 720);
    //fullScreen();
    noStroke();
    rectMode(CORNER);
    start = false;
    
    cp5 = new ControlP5(this);
    cf = new ControlFont(createFont("Times",16));

    stageLists = new StageLists(this);

    control = new CommandController(new StartBlock(cp5, cf, stageLists.getTankList().get(0)));
    
    control.add
    
    
    PImage code = loadImage("../Code.png");
    
    Toggle tog = cp5.addToggle("Show\nCode")
     .setFont(cf)
     .setPosition(20,20)
     .setSize(70,50)
     .setImage(code)
     .onChange(new CallbackListener(){
       public void controlEvent(CallbackEvent event) {
         if(event.getController().getValue() == 0){
           displayCode = false;
         } else {
           displayCode = true;
         }
         control.setVisible(displayCode);
      }
     }); 
     
     tog.getCaptionLabel().align(ControlP5.CENTER, ControlP5.TOP).setPaddingX(0);


    PImage startButton = loadImage("../StartButton.png");
    
    Toggle startTog = cp5.addToggle("Start")
     .setFont(cf)
     .setPosition(1000,20)
     .setSize(100,50)
     .setImage(startButton)
     .onChange(new CallbackListener(){
       public void controlEvent(CallbackEvent event) {
         if(event.getController().getValue() == 0 && !start){
           start = true;
         }
         control.setVisible(displayCode);
         ddm.setVisible(displayCode);
      }
     }); 

     PImage pauseButton = loadImage("../PauseButton.png");

     Toggle pauseTog = cp5.addToggle("Pause")
     .setFont(cf)
     .setPosition(1150,20)
     .setSize(100,50)
     .setImage(pauseButton)
     .onChange(new CallbackListener(){
       public void controlEvent(CallbackEvent event) {
         if(event.getController().getValue() == 0 && start){
           start = false;
         }
         control.setVisible(displayCode);
         ddm.setVisible(displayCode);
      }
     }); 
  
  
  }

boolean brake = false;
 void draw(){
   background(255.0);
   stageLists.drawObjects(start);
   noStroke();
   control.draw();

 }
  
  void mousePressed(){
  
    if(cp5.getWindow().getMouseOverList().size() > 0){
      try{
        if(selected){
          if(selections != null){
            control.connect(selections, control.getCommand((ControlGroup) cp5.getWindow().getMouseOverList().get(0).bringToFront()));
            print("Connection");
            selections = null;
          } else {
            print("First");
            selections = control.getCommand((ControlGroup) cp5.getWindow().getMouseOverList().get(0).bringToFront());
            print(selections != null);
            print("selections");
          }
        } else {
          selectedObject = control.getCommand((ControlGroup) cp5.getWindow().getMouseOverList().get(0).bringToFront());
          initX = mouseX;
          initY = mouseY;
          if(selectedObject instanceof LogicBlock){
            selectedObject = null;
          }
        }
      } catch(Exception e){
      }
    }
   }

void mouseReleased(){
  selectedObject = null;
}

void mouseDragged(){
  if(selectedObject != null && mouseX > 0 && mouseX < width && mouseY > 0 && mouseY < height){
    selectedObject.move(mouseX - initX, mouseY - initY);
    initX = mouseX;
    initY = mouseY;
  }
}

void keyPressed() {
  if (key == CODED && keyCode == CONTROL) {
    selected = true;
  } 
}

void keyReleased() {
  selected = false;
  selections = null;
}  