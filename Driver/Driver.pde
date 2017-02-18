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
  
  Boolean selected = false;
  CommandBlock selections;
  
  Boolean displayCode = false;
  
 void setup (){
    //size(1260, 720);
    fullScreen();
    noStroke();
    rectMode(CORNER);
    start = false;
    
    cp5 = new ControlP5(this);
    cf = new ControlFont(createFont("Times",16));

    stageLists = new StageLists(this);

    control = new CommandController(new StartBlock(cp5, cf, stageLists.getTankList().get(0)));
    control.add(new MoveBackward(cp5, cf, stageLists.getTankList().get(0)));
    control.add(new MoveForward(cp5, cf, stageLists.getTankList().get(0)));
    control.add(new MoveForward(cp5, cf, stageLists.getTankList().get(0)));
    control.add(new ForLoop(cp5, cf, stageLists.getTankList().get(0)));
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

     new MyButton(cp5, "Start").setPosition(1210, 0).setSize(50, 50);
     
     
  }
class MyButton extends Controller<MyButton>{
  int current = 0xffff0000;

  float a = 128;
  
  float na;
  
  int y;
  
  // use the convenience constructor of super class Controller
  // MyButton will automatically registered and move to the 
  // default controlP5 tab.
  
  MyButton(ControlP5 cp5, String theName) {
    super(cp5, theName);
    
    // replace the default view with a custom view.
    setView(new ControllerView() {
      public void display(PGraphics p, Object b) {
        // draw button background
        na += (a-na) * 0.1; 
        p.fill(current,na);
        p.rect(0, 0, getWidth(), getHeight());
        
        // draw horizontal line which can be moved on the x-axis 
        // using the scroll wheel. 
        //p.fill(0,255,0);
        //p.rect(0,y,width,10);
        
        // draw the custom label 
        p.fill(128);
        translate(0,getHeight()+14);
        p.text(getName(),5,-34);
        p.text(getName(),5,-34);
        
      }
    }
    );
}
// override various input methods for mouse input control
  void onEnter() {
    cursor(HAND);
    println("enter");
    a = 255;
  }
  
  void onScroll(int n) {
    println("scrolling");
    y -= n;
    y = constrain(y,0,getHeight()-10);
  }
  
  void onPress() {
    println("press");
    current = 0xffffff00;
  }
  
  void onClick() {
    Pointer p1 = getPointer();
    println("clicked at "+p1.x()+", "+p1.y());
    current = 0xffffff00;
    setValue(y);
    start = true;
    control.execute();
  }

  void onRelease() {
    println("release");
    current = 0xffffffff;
  }
  
  void onMove() {
    println("moving "+this+" "+_myControlWindow.getMouseOverList());
  }

  void onDrag() {
    current = 0xff0000ff;
    Pointer p1 = getPointer();
    float dif = dist(p1.px(),p1.py(),p1.x(),p1.y());
    println("dragging at "+p1.x()+", "+p1.y()+" "+dif);
  }
  
  void onReleaseOutside() {
    onLeave();
  }

  void onLeave() {
    println("leave");
    cursor(ARROW);
    a = 128;
  }
}
boolean brake = false;
 void draw(){
    background(255.0);

    if (start) {
      stageLists.drawObjects();
    }
    control.draw();

  }
  
  void mousePressed(){
  
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



  