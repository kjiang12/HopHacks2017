  import java.util.LinkedList;
  import java.util.ListIterator;
  import controlP5.*;

  ControlP5 cp5;
  ControlFont cf;
  CommandBlock selectedObject;
  float initX;
  float initY;
  StageLists stageLists;
  CommandController control;
  
  Boolean selected = false;
  CommandBlock selections;
  
 void setup (){
    size(1260, 720);
    noStroke();
    rectMode(CENTER);
    cp5 = new ControlP5(this);
    cf = new ControlFont(createFont("Times",16));
  
    stageLists = new StageLists();

    control = new CommandController();
    stageLists.addItem(new Tank(100, 50, 50, 60, 50, new Sprite(this,"../TankBase.png",0), new Sprite(this,"../TankHead5.png",0),60));
    control.add(new MoveBackward(cp5, cf, stageLists.getTankList().get(0)));
    control.add(new MoveForward(cp5, cf, stageLists.getTankList().get(0)));
    control.add(new MoveForward(cp5, cf, stageLists.getTankList().get(0)));
    control.execute(); //replaces parse();
  }

boolean brake = false;
 void draw(){
    background(255.0);
    control.draw();
    
    stageLists.drawObjects();
    

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



  