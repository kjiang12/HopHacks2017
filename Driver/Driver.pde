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
  
  Boolean selected = false;
  CommandBlock selections;
  
  Boolean displayCode = false;
  
 void setup (){
    size(1260, 720);
    noStroke();
    rectMode(CORNER);
    
    cp5 = new ControlP5(this);
    cf = new ControlFont(createFont("Times",16));

    stageLists = new StageLists(this);

    control = new CommandController(new StartBlock(cp5, cf, stageLists.getTankList().get(0)));
    control.add(new MoveBackward(cp5, cf, stageLists.getTankList().get(0)));
    control.add(new MoveForward(cp5, cf, stageLists.getTankList().get(0)));
    control.add(new MoveForward(cp5, cf, stageLists.getTankList().get(0)));

    control.execute(); //replaces parse();
    
    Toggle tog = cp5.addToggle("Show\nCode")
     .setFont(cf)
     .setPosition(20,20)
     .setSize(70,50)
     .setColorBackground(color(0, 120, 0))
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
     
  }

boolean brake = false;
 void draw(){
    background(255.0);
    
    stageLists.drawObjects();
    control.draw();
    if(displayCode){
      fill(color(0,0,200),50);
      rect(0, 0, 1260, 720);
    }

  }
  
  void mousePressed(){
    if (!brake) {
      stageLists.getTankList().get(0).turnRight();
      brake = true;
    } else {
      stageLists.getTankList().get(0).stopTurn();
      brake = false;
    }
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
          initX = mouseX;
          initY = mouseY;
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

void keyReleased(){
  selected = false;
  selections = null;
}



  