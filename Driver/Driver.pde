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
  PImage code;
  
 void setup (){
   // size(1260, 720);
    fullScreen();
    noStroke();
    rectMode(CORNER);
    cf = new ControlFont(createFont("Times",16));
    code = loadImage("../Code.png");
    code.resize(100,100);
    reset();
  }
  
  void reset(){
    start = false;
    
    cp5 = new ControlP5(this);

    stageLists = new StageLists(this);

    control = new CommandController(new StartBlock(cp5, cf, stageLists.getTankList().get(0)));
    
    Toggle tog = cp5.addToggle("Show\nCode")
     .setFont(new ControlFont(createFont("Times", 20)))
     .setPosition(10,10)
     .setSize(100,50)
     .setImage(loadImage("../Code.png"))
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

    
    cp5.addToggle("Start")
     .setFont(cf)
     .setPosition(1100,10)
     .setSize(100,50)
     .setImages(loadImage("../StartButton.png"),loadImage("../PauseButton.png"))
     .onChange(new CallbackListener(){
       public void controlEvent(CallbackEvent event) {
         if(event.getController().getValue() == 0){
           start = false;
         } else {
           start = true;
           control.execute();
           displayCode = false;
           control.setVisible(displayCode);
         }
      }
     });
     
     cp5.addToggle("Restart")
     .setFont(cf)
     .setPosition(10,660)
     .setSize(100,50)
     .setImage(loadImage("../RestartButton.png"))
     .onChange(new CallbackListener(){
       public void controlEvent(CallbackEvent event) {
        reset();
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
    control.getDDM().mousePress(mouseX, mouseY);
    if(cp5.getWindow().getMouseOverList().size() > 0){
      try{
        if(selected){
          if(selections != null){
            control.connect(selections, control.getCommand((ControlGroup) cp5.getWindow().getMouseOverList().get(0).bringToFront()));
            selections = null;
          } else {
            selections = control.getCommand((ControlGroup) cp5.getWindow().getMouseOverList().get(0).bringToFront());
          }
        } else {
          selectedObject = control.getCommand((ControlGroup) cp5.getWindow().getMouseOverList().get(0).bringToFront());
          if (delete) {
             delete = false;
             control.delete(selectedObject);
           }
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

boolean delete = false;
void keyPressed() {
  if (key == CODED && keyCode == CONTROL) {
    selected = true;
  } else if (keyCode == DELETE) {
    delete = true;
  }
}

void keyReleased() {
  selected = false;
  delete = false;
  selections = null;
}  