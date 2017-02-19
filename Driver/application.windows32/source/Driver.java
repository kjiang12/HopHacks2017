import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.LinkedList; 
import java.util.ListIterator; 
import controlP5.*; 
import sprites.Sprite; 
import controlP5.*; 
import sprites.Sprite; 
import sprites.Sprite; 
import controlP5.*; 
import sprites.Sprite; 
import sprites.Sprite; 
import sprites.maths.Vector2D; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Driver extends PApplet {

  
  
  
  

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
  
 public void setup (){
    
   // fullScreen();
    noStroke();
    rectMode(CORNER);
    start = false;
    
    cp5 = new ControlP5(this);
    cf = new ControlFont(createFont("Times",16));

    stageLists = new StageLists(this);

    control = new CommandController(new StartBlock(cp5, cf, stageLists.getTankList().get(0)));
    
    PImage code = loadImage("../Code.png");
    code.resize(100,100);
    Toggle tog = cp5.addToggle("Show\nCode")
     .setFont(new ControlFont(createFont("Times", 20)))
     .setPosition(0,0)
     .setSize(100,100)
     .setCaptionLabel("Code")
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
     .setPosition(1100,0)
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
  }

boolean brake = false;
 public void draw(){
   background(255.0f);
   stageLists.drawObjects(start);
   noStroke();
   control.draw();

 }
  
  public void mousePressed(){
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

public void mouseReleased(){
  selectedObject = null;
}

public void mouseDragged(){
  if(selectedObject != null && mouseX > 0 && mouseX < width && mouseY > 0 && mouseY < height){
    selectedObject.move(mouseX - initX, mouseY - initY);
    initX = mouseX;
    initY = mouseY;
  }
}

public void keyPressed() {
  if (key == CODED && keyCode == CONTROL) {
    selected = true;
  } 
}

public void keyReleased() {
  selected = false;
  selections = null;
}  
public abstract class ActionCommandBlock extends CommandBlock{
  public ActionCommandBlock(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);
  }
  
  public abstract void execute();
}

/*** everything below needs to be written ***/

public class Fire extends ActionCommandBlock{
  public Fire(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Fire").setFont(cf);
  }

  public void execute() {
    tank.fireBullet();
    if(this.next != null){
      this.next.execute();
    }
  }

}
public class Bot extends Tank{
  int timer;
  int randomTime;
  public Bot(int health, double x, double y, float tankAngle, float turrAngle, Sprite base_sprite, Sprite head_sprite,int reloadTime){
    super(health, x, y, tankAngle, turrAngle, base_sprite, head_sprite, reloadTime);
    timer = 0;
    randomTime = ((int) (Math.random() * 200));
  }
  
  public void update(){
    super.update();
    this.movement();
    
  }
  
  public void movement(){
    super.fireBullet();
    super.forward();
    if (timer < randomTime) {
      super.turnLeft();
      super.turnTurretRight();
      
    }
    else if (randomTime <= timer && timer < 200) {
       super.turnRight();
      super.turnTurretLeft();
      
    }
    else {
     timer = 0; 
     randomTime = ((int) (Math.random() * 200));
    }
    timer++;
  }
  
  
}
public class Bullet{
  Sprite sprite;
  double angle;
  private int distTrav;
  private int origLoc=0;
  public Bullet(int x, int y, Sprite sprite, double angle){
    this.sprite = sprite;
    this.distTrav=0;
    this.origLoc= (int) Math.sqrt((x + 28 * cos((float) angle)) * (x + 28 * cos((float) angle)) + (y + 28 * sin((float) angle)) * (y + 28 * sin((float) angle)));
    this.sprite.setXY(x + 28 * cos((float)angle), y + 28 * sin((float)angle));
    this.angle = angle;
  }
  public int getX(){
   return (int)sprite.getX();
  }
  public int getY(){
   return (int)sprite.getY();
  }
  public Sprite getSprite(){
   return sprite; 
  }
  public double getAngle(){
   return angle; 
  }
  public void setSprite(Sprite sprite){
   this.sprite = sprite; 
  }
  public void setAngle(double angle){
   this.angle = angle; 
  }
  public int update(){
    sprite.setRot(angle);
    sprite.setDirection(angle);
    sprite.setSpeed(5);
    sprite.update(0.4f);
    distTrav= (int) Math.sqrt(getX()*getX() + getY()*getY()) - origLoc;
    return distTrav;
  }
}
static int count = 0;

public abstract class CommandBlock{
  protected ControlP5 cp5;
  protected ControlGroup g;
  protected Tank tank;
  protected int id, h = 75, w = 300;
  protected float scrollScale = 0, x = 100, y = 100;
  protected CommandBlock next, prev;
  protected Connector connection;
  
  public CommandBlock(ControlP5 cp5, Tank tank){
    this.cp5 = cp5;
    this.g = cp5.addGroup(count + "")
             .setPosition(100, height/2)
             .setBackgroundHeight(100)
             .setSize(w,h)
             .setBarHeight(40)
             .setBackgroundColor(color(80,0,180))
             .disableCollapse()
             .setVisible(false);
    this.id = count;
    count++;
    this.tank = tank;
  }
  
  public void setGroup(String s){
    this.id = Integer.parseInt(s);
    this.g.setStringValue(s);
  }
  
  public void setNext(CommandBlock command){
    this.next = command;
    command.prev = this;
  }
  
  public void setConnection(Connector connection){
    this.connection = connection;
  }
  
  public void deleteConnection(){
    this.connection = null;
  }
  
  public void setVisible(Boolean bol){
    this.g.setVisible(bol);
  }
  
  public void draw(){
    if(connection != null){
      connection.draw();
    }
  }
  public abstract void execute();

  public void move(float x, float y){
    float[] pos = g.getPosition();
    float newX = pos[0] + x;
    float newY = pos[1] + y;
    if(newX > 0 && newY - 20 > 0 && newX + w < width && newY + h < height){
      this.g.setPosition(newX, newY);
      this.x = newX + scrollScale * 20;
      this.y = newY;
      this.connectionUpdate();
    }
  }
  
  public void connectionUpdate(){
    if(connection != null){
      this.connection.changeStart(this);
    }
    if(prev != null){
      this.prev.connection.changeEnd(this);
    }
  }
  public void scrollMove(float val){
    if(this instanceof LogicBlock){
      this.connectionUpdate();
      return;
    }
    float newX = x - 20 * val;
    scrollScale = val;
    this.g.setPosition(newX, y);
    this.connectionUpdate();
  }
  
  public int getX(){
    return (int) this.g.getAbsolutePosition()[0];
  }
  
  public int getY(){
    return (int) this.g.getAbsolutePosition()[1];
  }
}

public class StartBlock extends CommandBlock{
  public StartBlock(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);
    this.g.getCaptionLabel().set("Start")
                            .setFont(cf);
    this.g.setColorBackground(color(0,170,0));
    this.g.setColorActive(color(0,170,0));
    this.g.setColorForeground(color(0,170,0));
    this.g.setOpen(false);
    this.g.setBarHeight(75);
  }
  
  public void execute(){
    print("start");
    if(this.next != null){
      print("nex");
      this.next.execute();
    }
  }
}
public abstract class ConditionBlock extends CommandBlock{
  public ConditionBlock(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);
  }
  
  public abstract Boolean calculate();
  
  public void execute(){
  }
  
  public LogicBlock add(LogicBlock logic){
    control.add(logic);
    logic.changeX(logic.getRX() + logic.w/2);
    logic.changeSize(logic.w / 2, logic.h);

    logic.w /= 2;
    return logic;
  }
}
public class Comparison1Var extends ConditionBlock{
  LogicBlock var1;
  public Comparison1Var(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.h = 120;
    this.g.getCaptionLabel().set("Comparision with 1 Variable").setFont(cf);
    this.g.setSize(this.w , this.h);
    this.var1 = this.add(new LogicBlock(cp5, cf, tank, "Var1", 0, this.g));
  }
    public Boolean calculate(){
    if(var1.next != null){
      //return ((GetCommandBlock) var1.next).getValue();
    }
    return false;
    }
}
  
public class Comparison2Var extends ConditionBlock{
  LogicBlock var1, var2;
  DropdownList operatorList;
  
  String[] comparisionOperators = {"=", "<", "<=", ">", ">=", "!="};
  
  public Comparison2Var(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.h = 120;
    this.g.getCaptionLabel().set("Comparision with 2 Variables").setFont(cf);
    this.g.setSize(this.w , this.h);
  
    this.var1 = this.add(new LogicBlock(cp5, cf, tank, "Var1", 0, this.g));
    this.var2 = this.add(new LogicBlock(cp5, cf, tank, "Var2", 1, this.g));
    
    operatorList = cp5.addDropdownList("Operators " + this.id)
                      .setPosition(50, 30)
                      .setSize(60, 1200)
                      .setBarHeight(50)
                      .setItemHeight(50)
                      .setGroup(this.g)
                      .addItems(comparisionOperators)
                      .setOpen(false)
                      .setLabelVisible(false)
                      .setCaptionLabel("")
                      .setFont(new ControlFont(createFont("Times", 30)));

  }
  
  public Boolean calculate(){
    if(var1.next != null && var2.next != null){
      int op = (int) operatorList.getValue();
      
      switch(op){
        case 0:
          try {
            return ((GetCommandBlock) var1.next).getFloatValue() == ((GetCommandBlock) var2.next).getFloatValue();
          } catch (UnsupportedOperationException e) {
            try {
              return ((GetCommandBlock) var1.next).getIntValue() == ((GetCommandBlock) var2.next).getIntValue();
            } catch (UnsupportedOperationException f) {
              try {
                return ((GetCommandBlock) var1.next).getDoubleValue() == ((GetCommandBlock) var2.next).getDoubleValue();
              } catch (UnsupportedOperationException g) {
                try {
                  return ((GetCommandBlock) var1.next).getDoubleArrValue()[0] == ((GetCommandBlock) var2.next).getDoubleArrValue()[0] &&  ((GetCommandBlock) var1.next).getDoubleArrValue()[1] == ((GetCommandBlock) var2.next).getDoubleArrValue()[1];
                } catch (UnsupportedOperationException h) {
                  return false; 
                }
              }
            }
          }
        case 1:
           try {
            return ((GetCommandBlock) var1.next).getFloatValue() < ((GetCommandBlock) var2.next).getFloatValue();
          } catch (UnsupportedOperationException e) {
            try {
              return ((GetCommandBlock) var1.next).getIntValue() < ((GetCommandBlock) var2.next).getIntValue();
            } catch (UnsupportedOperationException f) {
              try {
                return ((GetCommandBlock) var1.next).getDoubleValue() < ((GetCommandBlock) var2.next).getDoubleValue();
              } catch (UnsupportedOperationException g) {
                try {
                  return ((GetCommandBlock) var1.next).getDoubleArrValue()[0] < ((GetCommandBlock) var2.next).getDoubleArrValue()[0] &&  ((GetCommandBlock) var1.next).getDoubleArrValue()[1] < ((GetCommandBlock) var2.next).getDoubleArrValue()[1];
                } catch (UnsupportedOperationException h) {
                  return false; 
                }
              }
            }
          }
        case 2:
          try {
            return ((GetCommandBlock) var1.next).getFloatValue() <= ((GetCommandBlock) var2.next).getFloatValue();
          } catch (UnsupportedOperationException e) {
            try {
              return ((GetCommandBlock) var1.next).getIntValue() <= ((GetCommandBlock) var2.next).getIntValue();
            } catch (UnsupportedOperationException f) {
              try {
                return ((GetCommandBlock) var1.next).getDoubleValue() <= ((GetCommandBlock) var2.next).getDoubleValue();
              } catch (UnsupportedOperationException g) {
                try {
                  return ((GetCommandBlock) var1.next).getDoubleArrValue()[0] <= ((GetCommandBlock) var2.next).getDoubleArrValue()[0] &&  ((GetCommandBlock) var1.next).getDoubleArrValue()[1] <= ((GetCommandBlock) var2.next).getDoubleArrValue()[1];
                } catch (UnsupportedOperationException h) {
                  return false; 
                }
              }
            }
          }
        case 3:
           try {
            return ((GetCommandBlock) var1.next).getFloatValue() > ((GetCommandBlock) var2.next).getFloatValue();
          } catch (UnsupportedOperationException e) {
            try {
              return ((GetCommandBlock) var1.next).getIntValue() > ((GetCommandBlock) var2.next).getIntValue();
            } catch (UnsupportedOperationException f) {
              try {
                return ((GetCommandBlock) var1.next).getDoubleValue() > ((GetCommandBlock) var2.next).getDoubleValue();
              } catch (UnsupportedOperationException g) {
                try {
                  return ((GetCommandBlock) var1.next).getDoubleArrValue()[0] > ((GetCommandBlock) var2.next).getDoubleArrValue()[0] &&  ((GetCommandBlock) var1.next).getDoubleArrValue()[1] > ((GetCommandBlock) var2.next).getDoubleArrValue()[1];
                } catch (UnsupportedOperationException h) {
                  return false; 
                }
              }
            }
          }
        case 4:
          try {
            return ((GetCommandBlock) var1.next).getFloatValue() >= ((GetCommandBlock) var2.next).getFloatValue();
          } catch (UnsupportedOperationException e) {
            try {
              return ((GetCommandBlock) var1.next).getIntValue() >= ((GetCommandBlock) var2.next).getIntValue();
            } catch (UnsupportedOperationException f) {
              try {
                return ((GetCommandBlock) var1.next).getDoubleValue() >= ((GetCommandBlock) var2.next).getDoubleValue();
              } catch (UnsupportedOperationException g) {
                try {
                  return ((GetCommandBlock) var1.next).getDoubleArrValue()[0] >= ((GetCommandBlock) var2.next).getDoubleArrValue()[0] &&  ((GetCommandBlock) var1.next).getDoubleArrValue()[1] >= ((GetCommandBlock) var2.next).getDoubleArrValue()[1];
                } catch (UnsupportedOperationException h) {
                  return false; 
                }
              }
            }
          }
        case 5:
           try {
            return ((GetCommandBlock) var1.next).getFloatValue() != ((GetCommandBlock) var2.next).getFloatValue();
          } catch (UnsupportedOperationException e) {
            try {
              return ((GetCommandBlock) var1.next).getIntValue() != ((GetCommandBlock) var2.next).getIntValue();
            } catch (UnsupportedOperationException f) {
              try {
                return ((GetCommandBlock) var1.next).getDoubleValue() != ((GetCommandBlock) var2.next).getDoubleValue();
              } catch (UnsupportedOperationException g) {
                try {
                  return ((GetCommandBlock) var1.next).getDoubleArrValue()[0] != ((GetCommandBlock) var2.next).getDoubleArrValue()[0] ||  ((GetCommandBlock) var1.next).getDoubleArrValue()[1] != ((GetCommandBlock) var2.next).getDoubleArrValue()[1];
                } catch (UnsupportedOperationException h) {
                  return false; 
                }
              }
            }
          }
      }
    }
    return false;
  }
  
  public void setVisible(Boolean bol){
    super.setVisible(bol);
    this.var1.setVisible(bol);
    this.var2.setVisible(bol);
  }
  
  public void move(float x, float y){
    super.move(x, y);
    this.var1.connectionUpdate();
    this.var2.connectionUpdate();
  }
}

/*public class Comparison1Var extends ConditionBlock{
  LogicBlock var1;
  float value = 0;
  DropdownList operatorList;
  
  String[] comparisionOperators = {"=", "<", "<=", ">", ">=", "!="};
  
  public Comparison1Var(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.h = 100;
    this.g.getCaptionLabel().set("Comparision with 1 Variable").setFont(cf);
    this.g.setSize(this.w , this.h);
    
    this.var1 = this.add(new LogicBlock(cp5, cf, tank, "Var", 0, this.g));
    this.var1.changePosition(200, 65);
    
    operatorList = cp5.addDropdownList("Operators " + this.id)
                      .setPosition(120, 25)
                      .setSize(60, 1200)
                      .setBarHeight(40)
                      .setItemHeight(50)
                      .setGroup(this.g)
                      .addItems(comparisionOperators)
                      .setOpen(false)
                      .setLabelVisible(false)
                      .setCaptionLabel("")
                      .setFont(new ControlFont(createFont("Times", 30)));
     
     cp5.addTextfield("input")
     .setPosition(20,25)
     .setSize(70,40)
     .setFont(cf)
     .setGroup(this.g)
     .setColor(color(255,0,0))
     .onChange(new CallbackListener(){
       public void controlEvent(CallbackEvent event) {
         try{
           value = Float.parseFloat(event.getController().getStringValue());
         } catch(Exception e){
         }
      }
     });
     ;
                       
  }
  
  Boolean calculate(){
    if(var1.next != null){
      int op = (int) operatorList.getValue();
      
      try { 
        switch(op){
          case 0:
            return value == ((GetCommandBlock) var1.next).getFloatValue();
          case 1:
            return value < ((GetCommandBlock) var1.next).getFloatValue();
          case 2:
            return value <= ((GetCommandBlock) var1.next).getFloatValue();
          case 3:
            return value > ((GetCommandBlock) var1.next).getFloatValue();
          case 4:
            return value >= ((GetCommandBlock) var1.next).getFloatValue();
          case 5:
            return value != ((GetCommandBlock) var1.next).getFloatValue();
        }
      } catch (UnsupportedOperationException e) {
        
      }
    }
    return false;
  }
  
  void setVisible(Boolean bol){
    super.setVisible(bol);
    this.var1.setVisible(bol);
  }
  
  void move(float x, float y){
    super.move(x, y);
    this.var1.connectionUpdate();
  }
}*/
public class CommandController{
  LinkedList<CommandBlock> commandList;
  HashMap<Integer, CommandBlock> commandTable;
  int count;
  CommandBlock start;
  Range range;
  DropDownMenu ddm;
  
  public CommandController(StartBlock start){
    this.commandList = new LinkedList<CommandBlock>();
    this.commandTable = new HashMap<Integer, CommandBlock>();
    count = 0;
    this.start = start;
    this.add(start);
    this.ddm = new DropDownMenu(cp5);
    this.range = cp5.addRange("rangeController")
             .setPosition(20,height - 50)
             .setSize(width - 40 ,40)
             .setHandleSize(10)
             .setRange(0,255)
             .setRangeValues(0,20)
             .setColorForeground(color(70,70,70))
             .setColorBackground(color(200,200,200))  
             .setVisible(false)
             .setLabelVisible(false)
             .onChange(new CallbackListener(){
               public void controlEvent(CallbackEvent event) {
                 scroll(event.getController().getArrayValue(0));
              }
             }); 
  }
  
  public DropDownMenu getDDM() {
    return ddm; 
  }
  
  public void add(CommandBlock command){
    command.setGroup(count + "");
    commandList.add(command);
    commandTable.put(count, command);
    count++;
  }
  
  public CommandBlock getCommand(ControlGroup group){
    return commandTable.get(Integer.parseInt(group.getStringValue()));
  }
  
  public void execute(){
    print("yes");
    start.execute();
  }
  
  public void draw(){
    if(displayCode){
      noStroke();
      fill(color(0,0,150),100);
      rect(0, 0, width, height);
      
      for(CommandBlock command: commandList) {
        command.draw();
      }
    } 
  }
  
  public void setVisible(Boolean bol){
    for(CommandBlock command: commandList) {
        command.setVisible(bol);
      }
      range.setVisible(bol);
      ddm.setVisible(bol);
  }
  
  public void connect(CommandBlock command1, CommandBlock command2){
    if(command1 == command2.next || command1 == command2 || command2 instanceof StartBlock || command1 instanceof LogicCommandBlock || command2 instanceof LogicBlock){
      return;
    }
    
    if(command1.next == command2){
      command1.next = null;
      command2.prev = null;
      command1.deleteConnection();
    } else {
      if(command2.prev != null){
        command2.prev.next = null;
        command2.prev.deleteConnection();
      }
      command1.setNext(command2);
      command1.setConnection(new Connector(command1.getX(), command1.getY(), command2.getX(), command2.getY()));
    }
  }
  
  public void scroll(float val){
    for(CommandBlock command: commandList){
        command.scrollMove(val);
    }
  }
}

public class Connector{
  int startX, startY, endX, endY;
  
  public Connector(int startX, int startY, int endX, int endY){
    this.startX = startX + 150;
    this.startY = startY - 10;
    this.endX = endX + 150;
    this.endY = endY - 10;
  } 
  
  public void changeStart(CommandBlock command){
    this.startX = command.getX() + 150;
    this.startY = command.getY() - 10;
  }
  
  public void changeEnd(CommandBlock command){
    this.endX = command.getX() + 150;
    this.endY = command.getY() - 10;
  }
  
  public void draw(){
    strokeWeight(5);
    stroke(126);
    line(startX, startY, (endX + startX)/2, (startY + endY)/2);
    stroke(80);
    line((endX + startX)/2, (startY + endY)/2, endX, endY);
    noStroke();
  }
}


class DropDownMenu {
  ControlP5 cp5;
  DropdownList d1, d2, d3, d4, d5;
  String choice;
  String[] math = {"Sin", "Cos", "Tan"};
  String[] movement = {"Move Forward", "Brake", "Turn Left", "Turn Right", "Stop Turning"};
  String[] combat = {"Turn Turret Left", "Turn Turret Right", "Stop Turning Turret", "Fire"};
  String[] get = {"Get My Angular Velocity", "Get Enemy Angular Velocity", "Get My Angle", "Get Enemy Angle", "Get My Velocity", "Get Enemy Velocity", "Get My Position", "Get Enemy Position", "Get My Reloading Time",
                  "Get Enemy Reloading Time", "Get My Turret Angular Velocity", "Get Enemy Turret Angular Velocity"};
 String[] ctrl = {"If", "For"}; 
  boolean onOff1, onOff2, onOff3, onOff4, onOff5;
  
  public DropDownMenu(ControlP5 cp5) {
    this.cp5 = cp5; 
    onOff1 = false;
    onOff2 = false;
    onOff3 = false;
    onOff4 = false;
    onOff5 = false;
    d1 = cp5.addDropdownList("Math")
          .setPosition(100, 0)
          .setFont(new ControlFont(createFont("Times",12)))
          .onClick(new CallbackListener(){
           public void controlEvent(CallbackEvent event) {
             if (!onOff1) {
               onOff1 = true;
               onOff2 = false;
               onOff3 = false;
               onOff4 = false;
               onOff5 = false;
               d2.setOpen(false);
               d3.setOpen(false);
               d4.setOpen(false);
               d5.setOpen(false);
             } else if (onOff1) {
               addControl(event.getController().getLabel());
               d1.setCaptionLabel("Math");
               onOff1 = false; 
             }
           }
     });
          ;   
          
     d2 = cp5.addDropdownList("Movement")
           .setPosition(300, 0)
           .setFont(new ControlFont(createFont("Times",12)))
           .onClick(new CallbackListener(){
            public void controlEvent(CallbackEvent event) {
              if (!onOff2) {
                onOff1 = false;
                onOff2 = true;
                onOff3 = false;
                onOff4 = false;
                onOff5 = false;
                d1.setOpen(false);
                d3.setOpen(false);
                d4.setOpen(false);
                d5.setOpen(false);
              } else if (onOff2) {
                addControl(event.getController().getLabel());
                d2.setCaptionLabel("Movement");
                onOff2 = false; 
              }
           }
     });
          ;   
          
    d3 = cp5.addDropdownList("Combat")
          .setPosition(500, 0)
          .setFont(new ControlFont(createFont("Times",12)))
          .onClick(new CallbackListener(){
           public void controlEvent(CallbackEvent event) {
             if (!onOff3) {
               onOff1 = false;
               onOff2 = false;
               onOff3 = true;
               onOff4 = false;
               onOff5 = false;
               d1.setOpen(false);
               d2.setOpen(false);
               d4.setOpen(false);
               d5.setOpen(false);
             } else if (onOff3) {
               addControl(event.getController().getLabel());
               d3.setCaptionLabel("Combat");
               onOff3 = false; 
             }
           }
     });
          ;   
          
    d4 = cp5.addDropdownList("Get")
          .setPosition(700, 0)
          .setFont(new ControlFont(createFont("Times",12)))
          .onClick(new CallbackListener(){
           public void controlEvent(CallbackEvent event) {
             if (!onOff4) {
               onOff1 = false;
               onOff2 = false;
               onOff3 = false;
               onOff4 = true;
               onOff5 = false;
               d1.setOpen(false);
               d2.setOpen(false);
               d3.setOpen(false);
               d5.setOpen(false);
             } else if (onOff4) {
               addControl(event.getController().getLabel());
               d4.setCaptionLabel("Get");
               onOff4 = false; 
             }
           }
     });
          ;   
          
    d5 = cp5.addDropdownList("Control")
          .setPosition(900, 0)
          .setFont(new ControlFont(createFont("Times",12)))
          .onClick(new CallbackListener(){
           public void controlEvent(CallbackEvent event) {
             if (!onOff5) {
               onOff1 = false;
               onOff2 = false;
               onOff3 = false;
               onOff4 = false;
               onOff5 = true;
               d1.setOpen(false);
               d2.setOpen(false);
               d3.setOpen(false);
               d4.setOpen(false);
             } else if (onOff5) {
               addControl(event.getController().getLabel());
               d5.setCaptionLabel("Control");
               onOff5 = false; 
             }
           }
     });
          ;   
          
    customize(d1, math);
    customize(d2, movement);
    customize(d3, combat);
    customize(d4, get);
    customize(d5, ctrl);
  }
  
  public void customize(DropdownList ddl, String[] options) {
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
  
  public void setVisible(boolean isVisible) {
    d1.setVisible(isVisible);
    d2.setVisible(isVisible);
    d3.setVisible(isVisible);
    d4.setVisible(isVisible);
    d5.setVisible(isVisible);
  }
  
  public void mousePress(int x, int y) {
    onOff1 = (x > 100 && x < 300) && (y < 220); 
    onOff2 = (x > 300 && x < 500) && (y < 340); 
    onOff3 = (x > 500 && x < 700) && (y < 280); 
    onOff4 = (x > 700 && x < 900) && (y < 400); 
    onOff5 = (x > 900 && x < 1100) && (y < 160);
    
    if (!onOff1) {
      d1.setOpen(onOff1);
      d1.setCaptionLabel("Math");
    }
    
    if (!onOff2) {
      d2.setOpen(onOff2);
      d2.setCaptionLabel("Movement");
    }
    
    if (!onOff3) {
      d3.setOpen(onOff3);
      d3.setCaptionLabel("Combat");
    }
    
    if (!onOff4) {
      d4.setOpen(onOff4);
      d4.setCaptionLabel("Get");
    }
    
    if (!onOff5) {
      d5.setOpen(onOff5);
      d5.setCaptionLabel("Control");
    }
  }
  
  public void addControl(String label) {
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
      control.add(new GetMyAngVel(cp5, cf, stageLists.getTankList().get(0), stageLists.getTankList().get(1))); 
    } else if (label.equals("Get Enemy Angular Velocity")) {
      control.add(new GetEnemyAngVel(cp5, cf, stageLists.getTankList().get(0), stageLists.getTankList().get(1))); 
    } else if (label.equals("Get My Angle")) {
      control.add(new GetMyAngle(cp5, cf, stageLists.getTankList().get(0), stageLists.getTankList().get(1))); 
    } else if (label.equals("Get Enemy Angle")) {
      control.add(new GetEnemyAngle(cp5, cf, stageLists.getTankList().get(0), stageLists.getTankList().get(1))); 
    } else if (label.equals("Get My Velocity")) {
      control.add(new GetMyVel(cp5, cf, stageLists.getTankList().get(0), stageLists.getTankList().get(1))); 
    } else if (label.equals("Get Enemy Velocity")) {
      control.add(new GetEnemyVel(cp5, cf, stageLists.getTankList().get(0), stageLists.getTankList().get(1))); 
    } else if (label.equals("Get My Position")) {
      control.add(new GetMyPos(cp5, cf, stageLists.getTankList().get(0), stageLists.getTankList().get(1))); 
    } else if (label.equals("Get Enemy Position")) {
      control.add(new GetEnemyPos(cp5, cf, stageLists.getTankList().get(0), stageLists.getTankList().get(1))); 
    } else if (label.equals("Get My Reloading Time")) {
      control.add(new GetMyReloadingTime(cp5, cf, stageLists.getTankList().get(0), stageLists.getTankList().get(1))); 
    } else if (label.equals("Get Enemy Reloading Time")) {
      control.add(new GetEnemyReloadingTime(cp5, cf, stageLists.getTankList().get(0), stageLists.getTankList().get(1))); 
    } else if (label.equals("Get My Turret Angular Velocity")) {
      control.add(new GetMyTurrAngVel(cp5, cf, stageLists.getTankList().get(0), stageLists.getTankList().get(1))); 
    } else if (label.equals("Get Enemy Turret Angular Velocity")) {
      control.add(new GetEnemyTurrAngVel(cp5, cf, stageLists.getTankList().get(0), stageLists.getTankList().get(1)));  
    }
    control.setVisible(true);
  }
}


public class Explosion{
  Sprite sprite;
  int tick;
  public Explosion(double x, double y, Sprite sprite){
    this.sprite = sprite;
    this.sprite.setX(x);
    this.sprite.setY(y);
    tick = 25;
  }
  public double getX(){
   return sprite.getX(); 
  }
  public double getY(){
   return sprite.getY(); 
  }
  public Sprite getSprite(){
   return sprite; 
  }
  public int getTick(){
   return tick; 
  }
  public void setX(double x){
   sprite.setX(x); 
  }
  public void setY(double y){
   sprite.setY(y); 
  }
  public void setSprite(Sprite sprite){
   this.sprite = sprite; 
  }
  public void setTick(int tick){
   this.tick = tick;
  }
}
public abstract class GetCommandBlock extends CommandBlock{
  
  ControlGroup tankAngGroup, reloadGroup, turrAngGroup;
  Tank myTank, enemyTank;
  public GetCommandBlock(ControlP5 cp5, ControlFont cf, Tank myTank, Tank enemyTank){
    super(cp5, myTank);
    this.myTank = myTank;
    this.enemyTank = enemyTank;
    this.h = 150;
    
    /*this.g.setOpen(true);
    this.g.getCaptionLabel().set("Get Tank Angle").setFont(cf);
    this.g.setSize(this.w, this.h);
    this.tankAngGroup = cp5.addGroup("Get Tank Angle" + this.id)
             .setPosition(10,50)
             .setBackgroundHeight(100)
             .setSize(w,h)
             .setBarHeight(40)
             .setBackgroundColor(color(80,0,180))
             .setFont(new ControlFont(createFont("Times",12)))
             .setOpen(false)
             .disableCollapse()
             .setGroup(this.g)
             .setVisible(false);
             
   this.reloadGroup = cp5.addGroup("Get Reload Time " + this.id)
             .setPosition(10,100)
             .setBackgroundHeight(100)
             .setSize(w,h)
             .setBarHeight(40)
             .setBackgroundColor(color(80,0,180))
             .setFont(new ControlFont(createFont("Times",12)))
             .setOpen(false)
             .disableCollapse()
             .setGroup(this.g)
             .setVisible(false);
             //.setCaptionLabel("Then");
             
             
   this.turrAngGroup = cp5.addGroup("Get Turret Angle " + this.id)
             .setPosition(10,150)
             .setBackgroundHeight(100)
             .setSize(w,h)
             .setBarHeight(40)
             .setBackgroundColor(color(80,0,180))
             .setFont(new ControlFont(createFont("Times",12)))
             .setOpen(false)
             .disableCollapse()
             .setGroup(this.g)
             .setVisible(false);
             //.setCaptionLabel("Else");*/
  }
  public void setGroup(String s){
    super.setGroup(s);
    super.g.setBackgroundColor(color(255, 0, 0));}
  public abstract float getFloatValue();
  public abstract int getIntValue();
  public abstract double getDoubleValue();
  public abstract double[] getDoubleArrValue();
  public abstract void execute();
    
}

/*** everything below needs to be written ***/

public class GetMyPos extends GetCommandBlock{
  public GetMyPos(ControlP5 cp5, ControlFont cf, Tank myTank, Tank enemyTank){
    super(cp5, cf, myTank, enemyTank);
    this.g.getCaptionLabel().set("Get My Position").setFont(cf);
  }
  
  public float getFloatValue() {
     throw new UnsupportedOperationException();
  }
  
  public int getIntValue() {
     throw new UnsupportedOperationException();
  }
  
  public double getDoubleValue() {
     throw new UnsupportedOperationException();
  }
  
  public double[] getDoubleArrValue(){
      return myTank.getPos();
  }
  public void execute() {
    println("IMPLEMENT GETMYPOS");
  }
}

public class GetEnemyPos extends GetCommandBlock{
  public GetEnemyPos(ControlP5 cp5, ControlFont cf, Tank myTank, Tank enemyTank){
    super(cp5, cf, myTank, enemyTank);
    this.g.getCaptionLabel().set("Get Enemy Position").setFont(cf);
  }
  public float getFloatValue() {
     throw new UnsupportedOperationException();
  }
  
  public int getIntValue() {
     throw new UnsupportedOperationException();
  }
  
  public double getDoubleValue() {
     throw new UnsupportedOperationException(); 
  }
  
  public double[] getDoubleArrValue(){
      return enemyTank.getPos();
  }
  public void execute() {
    println("IMPLEMENT GETENEMYPOS");
  }
}

public class GetMyVel extends GetCommandBlock{
  public GetMyVel(ControlP5 cp5, ControlFont cf, Tank myTank, Tank enemyTank){
    super(cp5, cf, myTank, enemyTank);
    this.g.getCaptionLabel().set("Get My Velocity").setFont(cf);
  }
  public float getFloatValue() {
    throw new UnsupportedOperationException();
  }
  
  public int getIntValue() {
    throw new UnsupportedOperationException();
  }
  
  public double getDoubleValue() {
    throw new UnsupportedOperationException(); 
  }
  
  public double[] getDoubleArrValue(){
    return myTank.getVel();
  }
  public void execute() {
    println("IMPLEMENT GETMYVEL");
  }
}

public class GetEnemyVel extends GetCommandBlock{
  public GetEnemyVel(ControlP5 cp5, ControlFont cf, Tank myTank, Tank enemyTank){
    super(cp5, cf, myTank, enemyTank);
    this.g.getCaptionLabel().set("Get Enemy Velocity").setFont(cf);
  }
  
  public float getFloatValue() {
    throw new UnsupportedOperationException();
  }
  
  public int getIntValue() {
    throw new UnsupportedOperationException();
  }
  
  public double getDoubleValue() {
    throw new UnsupportedOperationException(); 
  }
  
  public double[] getDoubleArrValue(){
    return enemyTank.getVel();
  }
  public void execute() {
    println("IMPLEMENT GETENEMYVEL");
  }
}

public class GetMyAngle extends GetCommandBlock{
  public GetMyAngle(ControlP5 cp5, ControlFont cf, Tank myTank, Tank enemyTank){
    super(cp5, cf, myTank, enemyTank);
    this.g.getCaptionLabel().set("Get My Angle").setFont(cf);
  }
  
  public float getFloatValue() {
    throw new UnsupportedOperationException(); 
  }
  
  public int getIntValue() {
    throw new UnsupportedOperationException(); 
  }
  
  public double getDoubleValue(){
    return myTank.getTankAngle();
  }
  
  public double[] getDoubleArrValue() {
    throw new UnsupportedOperationException();
  }
  
  public void execute() {
    println("IMPLEMENT GETMYANGLE");
  }
}

public class GetEnemyAngle extends GetCommandBlock{
  public GetEnemyAngle(ControlP5 cp5, ControlFont cf, Tank myTank, Tank enemyTank){
    super(cp5, cf, myTank, enemyTank);
    this.g.getCaptionLabel().set("Get Enemy Angle").setFont(cf);
  }
  
  public float getFloatValue() {
    throw new UnsupportedOperationException(); 
  }
  
  public int getIntValue() {
    throw new UnsupportedOperationException(); 
  }
  
  public double getDoubleValue(){
    return enemyTank.getTankAngle();
  }
  
  public double[] getDoubleArrValue() {
    throw new UnsupportedOperationException(); 
  }
  public void execute() {
    println("IMPLEMENT GETENEMYANGLE");
  }
}

public class GetMyAngVel extends GetCommandBlock{
  public GetMyAngVel(ControlP5 cp5, ControlFont cf, Tank myTank, Tank enemyTank){
    super(cp5, cf, myTank, enemyTank);
    this.g.getCaptionLabel().set("Get My Angular Velocity").setFont(cf);
  }
  
  public float getFloatValue(){
    return myTank.getTankAngVel();
  }
  
  public int getIntValue() {
    throw new UnsupportedOperationException(); 
  }
  
  public double getDoubleValue() {
    throw new UnsupportedOperationException(); 
  }
  
  public double[] getDoubleArrValue() {
    throw new UnsupportedOperationException(); 
  }
  
  public void execute() {
  
  }
}

public class GetEnemyAngVel extends GetCommandBlock{
  public GetEnemyAngVel(ControlP5 cp5, ControlFont cf, Tank  myTank, Tank enemyTank){
    super(cp5, cf, myTank, enemyTank);
    this.g.getCaptionLabel().set("Get Enemy Angular Velocity").setFont(cf);
  }
  public float getFloatValue(){
    return enemyTank.getTankAngVel();
  }
  
  public int getIntValue() {
    throw new UnsupportedOperationException(); 
  }
  
  public double getDoubleValue() {
    throw new UnsupportedOperationException(); 
  }
  
  public double[] getDoubleArrValue() {
    throw new UnsupportedOperationException(); 
  }
  
  public void execute() {

  }
}

public class GetMyReloadingTime extends GetCommandBlock{
  public GetMyReloadingTime(ControlP5 cp5, ControlFont cf, Tank myTank, Tank enemyTank){
    super(cp5, cf, myTank, enemyTank);
    this.g.getCaptionLabel().set("Get My Reload Time").setFont(cf);
  }
  
  public float getFloatValue() {
    throw new UnsupportedOperationException(); 
  }
  
  public int getIntValue(){
    return myTank.getReloadTime();
  }
  
  public double getDoubleValue() {
    throw new UnsupportedOperationException(); 
  }
  
  public double[] getDoubleArrValue() {
    throw new UnsupportedOperationException();
  }
  
  public void execute() {

  }
}

public class GetEnemyReloadingTime extends GetCommandBlock{
  public GetEnemyReloadingTime(ControlP5 cp5, ControlFont cf, Tank myTank, Tank enemyTank){
    super(cp5, cf, myTank, enemyTank);
    this.g.getCaptionLabel().set("Get Enemy Reload Time").setFont(cf);
  }
  
  public float getFloatValue() {
    throw new UnsupportedOperationException();
  }
  
  public int getIntValue(){
    return enemyTank.getReloadTime();
  }
  
  public double getDoubleValue() {
    throw new UnsupportedOperationException();
  }
  
  public double[] getDoubleArrValue() {
    throw new UnsupportedOperationException(); 
  }
  
  public void execute() {

  }
}

public class GetMyTurrAngVel extends GetCommandBlock{
  public GetMyTurrAngVel(ControlP5 cp5, ControlFont cf, Tank myTank, Tank enemyTank){
    super(cp5, cf, myTank, enemyTank);
    this.g.getCaptionLabel().set("Get My Turret Angular Velocity").setFont(cf);
  }
  
  public float getFloatValue(){
    return myTank.getTurrAngVel();
  }
  
  public int getIntValue() {
    throw new UnsupportedOperationException(); 
  }
  
  public double getDoubleValue() {
    throw new UnsupportedOperationException(); 
  }
  
  public double[] getDoubleArrValue() {
    throw new UnsupportedOperationException(); 
  }
  
  public void execute() {

  }
}

public class GetEnemyTurrAngVel extends GetCommandBlock{
  public GetEnemyTurrAngVel(ControlP5 cp5, ControlFont cf, Tank myTank, Tank enemyTank){
    super(cp5, cf, myTank, enemyTank);
    this.g.getCaptionLabel().set("Get Enemy Turret Angular Velocity").setFont(cf);
  }
  
  public float getFloatValue() {
    return enemyTank.getTurrAngVel();
  }
  
  public int getIntValue() {
    throw new UnsupportedOperationException(); 
  }
  
  public double getDoubleValue() {
    throw new UnsupportedOperationException(); 
  }
  
  public double[] getDoubleArrValue() {
    throw new UnsupportedOperationException(); 
  }
  
  public void execute() {

  }
}



/*public class GetVel extends GetCommandBlock{
  boolean forward;
  public GetVel(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Get Velocity").setFont(cf);
    forward=true;
  }
  public void setFoward(boolean forward){
    this.forward=forward;
  }
  void execute() {
    tank.getVel(forward, tank.getXPos(), tank.getYPos());
  }

}*/
public abstract class LogicCommandBlock extends CommandBlock{
  
  LogicBlock conditionGroup, thenGroup, elseGroup;
  
  public LogicCommandBlock(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);    
    this.h = 150;
    this.g.setOpen(true);
    this.g.getCaptionLabel().set("If").setFont(cf);
    this.g.setSize(this.w, this.h);
   
    this.conditionGroup = this.add(new LogicBlock(cp5, cf, tank, "Condition", 0, this.g));
    this.thenGroup = this.add(new LogicBlock(cp5, cf, tank, "Then", 1, this.g));
    this.elseGroup = this.add(new LogicBlock(cp5, cf, tank, "Else", 2, this.g));         
  
  }
  
  public LogicBlock add(LogicBlock logic){
    control.add(logic);
    return logic;
  }
  
  public void setVisible(Boolean bol){
    super.setVisible(bol);
    if(this.conditionGroup != null){
      this.conditionGroup.setVisible(bol);
    }
    this.thenGroup.setVisible(bol);
    this.elseGroup.setVisible(bol);
  }
  
  public void move(float x, float y){
    super.move(x, y);
    if(this.conditionGroup != null){
      this.conditionGroup.connectionUpdate();
    }
    this.thenGroup.connectionUpdate();
    this.elseGroup.connectionUpdate();
  }
  
  public abstract void execute();
}

class LogicBlock extends CommandBlock{
     public LogicBlock(ControlP5 cp5, ControlFont cf, Tank tank, String label, int pos, ControlGroup group){
       super(cp5, tank);
       this.g.setPosition(10, 50*(pos + 1));
       this.g.setBackgroundHeight(100);
       this.g.setSize(w,h);
       this.g.setBarHeight(40);
       this.g.setBackgroundColor(color(80,0,180));
       this.g.setFont(new ControlFont(createFont("Times",12)));
       this.g.setOpen(false);
       this.g.disableCollapse();
       this.g.setGroup(group);
       this.g.setVisible(false);
       this.g.setCaptionLabel(label);
     }
     
     public void setLabel(String s){
       this.g.setCaptionLabel(s);
     }
     
     public int getX(){
       return (int) this.g.getAbsolutePosition()[0];
     }
  
     public int getY(){
       return (int) this.g.getAbsolutePosition()[1] - 10;
     }
     
     public void changeSize(int x, int y){
       this.g.setSize(x, y);
     }
     
     public void changePosition(int x, int y){
       this.g.setPosition(x, y);
     }
    
    public void changeX(int x){
      this.g.setPosition(x, this.g.getPosition()[1]);
    }
    
    public int getRX(){
      return (int) this.g.getPosition()[0];
    }
     public void execute(){
     }
   }
   
public class ForLoop extends LogicCommandBlock{
  int start, end, count = 0;
  
  public ForLoop(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.conditionGroup.g.remove();
    this.conditionGroup = null;
    
    this.g.getCaptionLabel().set("For").setFont(cf);
    this.thenGroup.setLabel("Do");
    this.elseGroup.setLabel("Next");
    
    cp5.addTextlabel("label " + this.id)
                    .setText("From ")
                    .setPosition(20,15)
                    .setFont(new ControlFont(createFont("Times", 20)))
                    .setGroup(this.g)
                    ;
                    
    cp5.addTextfield("input1 " + this.id)
     .setPosition(100,10)
     .setSize(60,40)
     .setFont(cf)
     .setGroup(this.g)
     .setColor(color(255,0,0))
     .setCaptionLabel("")
     .onChange(new CallbackListener(){
       public void controlEvent(CallbackEvent event) {
         start = (int) Float.parseFloat(event.getController().getStringValue());
      }
     });

     cp5.addTextlabel("label2 " + this.id)
                    .setText(" To ")
                    .setPosition(170, 15)
                    .setFont(new ControlFont(createFont("Times", 20)))
                    .setGroup(this.g)
                    ;
                    
    cp5.addTextfield("input2 " + this.id)
     .setPosition(220,10)
     .setSize(60,40)
     .setFont(cf)
     .setGroup(this.g)
     .setCaptionLabel("")
     .setColor(color(255,0,0))
     .onChange(new CallbackListener(){
       public void controlEvent(CallbackEvent event) {
         end = (int) Float.parseFloat(event.getController().getStringValue());
      }
     });

  }

  public void execute() {
    if(end != 0 && this.thenGroup.next != null){
      count = start;
      if(count < end * 60){
        thenGroup.next.execute();
        count++;
      } else {
        if(this.elseGroup.next != null){
          elseGroup.next.execute();
        }
    }
  }
}
}

public class IfStatement extends LogicCommandBlock{
  public IfStatement(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("If").setFont(cf);
  }

  public void execute() {
    if(conditionGroup.next != null && thenGroup.next != null){
      if(((ConditionBlock)conditionGroup.next).calculate()){
        thenGroup.next.execute();
      } else {
        if(elseGroup.next != null){
          elseGroup.next.execute();
        }
    }
  }
}
}
public abstract class MovementBlock extends CommandBlock{
  Slider slide;
  
  public MovementBlock(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);
  }
  
  
  public void setGroup(String s){
    super.setGroup(s); /*
    slide = cp5.addSlider("Slide " + this.id)
     .setPosition(20,20)
     .setSize(180,30)
     .setGroup(this.g)
     .setRange(0,460)
     .setFont(new ControlFont(createFont("Times",12)))
     .setCaptionLabel("Power")
     .onChange(new CallbackListener(){
       public void controlEvent(CallbackEvent event) {
         currPow = event.getController().getValue();
      }
     }); */
  }
  public abstract void execute();
}

public class MoveBackward extends MovementBlock{
  public MoveBackward(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Move Backwards").setFont(cf);
     
  }

  public void execute() {
    tank.backward();
    if(this.next != null){
      this.next.execute();
    }
  }
}

public class MoveForward extends MovementBlock{
  public MoveForward(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Move Forward").setFont(cf);
  }

  public void execute() {
    print("hello");
    tank.forward();
    print("yo");
    if(this.next != null){
      this.next.execute();
    }
  }

}

public class TurnLeft extends MovementBlock{
  public TurnLeft(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Turn Left").setFont(cf);
  }

  public void execute() {
    tank.turnLeft();
    if(this.next != null){
      this.next.execute();
    }
  }

}

public class TurnRight extends MovementBlock{
  public TurnRight(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Turn Right").setFont(cf);
  }

  public void execute() {
    tank.turnRight();
    if(this.next != null){
      this.next.execute();
    }
  }

}

public class TurnTurretLeft extends MovementBlock{
  public TurnTurretLeft(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Turn Turret Left").setFont(cf);
  }

  public void execute() {
    tank.turnTurretLeft();
    if(this.next != null){
      this.next.execute();
    }
  }

}

public class TurnTurretRight extends MovementBlock{
  public TurnTurretRight(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Turn Turret Right").setFont(cf);
  }

  public void execute() {
    tank.turnTurretRight();
    if(this.next != null){
      this.next.execute();
    }
  }
}
  
public class StopTurning extends MovementBlock{
  public StopTurning(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Stop Turning").setFont(cf);
  }

  public void execute() {
    println("IMPLEMENT STOPTURNING");
  }
}

public class StopTurningTurret extends MovementBlock{
  public StopTurningTurret(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Stop Turning Turret").setFont(cf);
  }

  public void execute() {
    println("IMPLEMENT STOPTURNINGTURRET");
  }
}


public class Brake extends MovementBlock{
  public Brake(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Brake").setFont(cf);
  }

  public void execute() {
    println("IMPLEMENT BRAKE");
  }
}


public abstract class Obstacle{
  Sprite sprite;
  public Obstacle(int x, int y, Sprite sprite){
    this.sprite = sprite;
    this.sprite.setX(x);
    this.sprite.setY(y);
  }
  public double getX(){
   return sprite.getX(); 
  }
  public double getY(){
   return sprite.getY(); 
  }
  public Sprite getSprite(){
   return sprite; 
  }
  public void setX(double x){
   sprite.setX(x); 
  }
  public void setY(double y){
   sprite.setY(y); 
  }
  public void setX(Sprite sprite){
   this.sprite = sprite; 
  }
}

public class Barrel extends Obstacle{
  public Barrel(int x, int y, Sprite sprite){
    super(x, y, sprite);
  }
}

public class Crate extends Obstacle{
  public Crate(int x, int y, Sprite sprite){
    super(x, y, sprite);
  }
}
static class Physics {
  private static final float MASS = 30000;
  private static final double MAX_VEL= 5.33f;
  private static final float MIN_VEL= 3.0f;
  private static final float ACC = 1.87f;
  private static final float FPS = 60;
  private static final double BRAKE = 1.55f;
  private static final float TANK_TURN = 37 * PI / 180.0f;
  private static final float TANK_TURN_ACC = 30 * PI / 180.0f;
  private static final float TURRET_TURN = 38 * PI / 180.0f;
  private static final float TURRET_TURN_ACC = 30 * PI / 180.0f;
  private static final float LENGTH = 6;
  private static final float WIDTH = 3;
  private static final float I = 112500;
  private static final int SCALE = 10; //SCALE pixels = 1 m
  
  public static float stopTurretTurn(float angularVelocity) {
    if (angularVelocity < 0) {
      angularVelocity = turnTurretRight(angularVelocity); 
    } else if (angularVelocity > 0) {
      angularVelocity = turnTurretLeft(angularVelocity);
    }
    
    if (angularVelocity > -0.1f && angularVelocity < 0.1f) {
      angularVelocity = 0; 
    }
    
    return angularVelocity;
  }
  
  public static float turnTurretLeft(float angularVelocity) {
    return max(angularVelocity - TURRET_TURN_ACC, -TURRET_TURN) / FPS;
  }
  
  public static float turnTurretRight(float angularVelocity) {
    return min(angularVelocity + TURRET_TURN_ACC, TURRET_TURN) / FPS;
  }
  
  public static float stopTurn(float angularVelocity) {
    if (angularVelocity < 0) {
      angularVelocity = turnRight(angularVelocity); 
    } else if (angularVelocity > 0) {
      angularVelocity = turnLeft(angularVelocity);
    }
    
    if (angularVelocity > -0.1f && angularVelocity < 0.1f) {
      angularVelocity = 0; 
    }
    
    return angularVelocity;
  }
  
  public static float turnLeft(float angularVelocity) {
    return max(angularVelocity - TANK_TURN_ACC, -TANK_TURN) / FPS;
  }
  
  public static float turnRight(float angularVelocity) {
    return min(angularVelocity + TANK_TURN_ACC, TANK_TURN) / FPS;
  }
  
  public static void brake(Sprite base_sprite, Sprite head_sprite) {
    Vector2D vel = new Vector2D(base_sprite.getVelX(), base_sprite.getVelY());
    
    if (base_sprite.getSpeed() > 0.1f) {
      Vector2D reverseVel = vel.getReverse();
      reverseVel.normalize();
      reverseVel.mult(BRAKE);
      base_sprite.setAccXY(reverseVel.x, reverseVel.y);
    } else {
      base_sprite.setSpeed(0); 
    }
    
    base_sprite.update(.1f);
    head_sprite.setPos(new Vector2D(base_sprite.getX(), base_sprite.getY()));
  }

  public static void forward(Sprite base_sprite, Sprite head_sprite) {
    base_sprite.setAcceleration(ACC);
    
    if (base_sprite.getSpeed() > MAX_VEL) {
      base_sprite.setSpeed(MAX_VEL);
    }
    
    base_sprite.update(.1f);
    head_sprite.setPos(new Vector2D(base_sprite.getX(), base_sprite.getY()));
  }
  
  private static float getComponent(float val, float angle, boolean x) {
    return x ? val * cos(angle) : val * sin(angle);
  }
  
 
}



public class StageLists{
  private ArrayList<Bullet> bullets= new ArrayList<Bullet>();
  private ArrayList<Obstacle> obstacles= new ArrayList<Obstacle>();
  private ArrayList<Tank> tanks= new ArrayList<Tank>();
  private float xTrav=0;
  private float yTrav=0;
  private ArrayList<Explosion> explosions= new ArrayList<Explosion>();
  PApplet app;
  
  public StageLists(PApplet app){
     this.app = app;
     generateObstacles(2);
     generateBots(50);

     this.addItem(new Tank(100, 500, 500, PI / 3, 50, new Sprite(app,"../TankBase1.png",0), new Sprite(app,"../TankHead5.png",0),20));

  }
  public ArrayList<Bullet> getBulletList(){
    return bullets;
  }
  
  public void addItem(Bullet bullet){
    bullets.add(bullet);
  }
  
  public ArrayList<Obstacle> getObstacleList(){
    return this.obstacles;
  }
  
  public void addItem(Obstacle obstacle){
    this.obstacles.add(obstacle);
  }
  
  public ArrayList<Tank> getTankList(){
    return this.tanks;
  }
  
  public void addItem(Tank tank){
    this.tanks.add(tank);
  }
  
  public ArrayList<Explosion> getExplosionList(){
    return this.explosions;
  }
  
  public void addItem(Explosion explosion){
    this.explosions.add(explosion);
  }
  
  public void drawObjects(boolean doUpdate){
    for(int i = 0; i < bullets.size(); i++){
      boolean remove=false;
      if (bullets.get(i).getX() > width || bullets.get(i).getX() < 0 || bullets.get(i).getY() > height || bullets.get(i).getY() < 0 ){
       bullets.remove(i);
      }
      else{
        if (doUpdate) {
          if(bullets.get(i).update()>175){
              remove = true;
          }          
        }
        if(remove){
            bullets.remove(i);
            remove=false;
        }
        else{
        bullets.get(i).getSprite().draw();
        }
      }
    }
    for(Obstacle obstacle: obstacles){
      obstacle.getSprite().draw();
    }
    for(int i = 0; i < explosions.size(); i++){
      if(explosions.get(i).getTick() == 150){
        explosions.remove(i);
      }
      else{
        if (doUpdate) {
          explosions.get(i).getSprite().setScale(explosions.get(i).getTick() / 25);
       //   explosions.get(i).getSprite().setY(explosions.get(i).getSprite().getY() - (explosions.get(i).getTick() * 10));
        }
        explosions.get(i).getSprite().draw();
        if (doUpdate) {
          explosions.get(i).setTick(explosions.get(i).getTick() + 1);
        }
      }
    }
    for(Tank tank: tanks){
    //  tank.turnLeft();
    //  tank.turnTurretRight();
    //  tank.forward();
    //  tank.fireBullet();
    //  println(tank.getTankAngle());
      if (doUpdate) {
        tank.update();
      }
      tank.draw();
    }

    if (doUpdate){
      checkBullet();
      collisionCheck();
    }
  }
  
  public void collisionCheck(){
   // println(bullets.size());
   for (int i = obstacles.size() - 1; i > 0; i--){
     for (int j = 0; j < tanks.size(); j++){
       if(obstacles.get(i).getSprite().bb_collision(tanks.get(j).getBaseSprite())){
         tanks.get(j).stop();
       }
       if (tanks.get(j).getPos()[0] > width || tanks.get(j).getPos()[0] < 0 || tanks.get(j).getPos()[1] > height || tanks.get(j).getPos()[1] < 0){
         tanks.get(j).stop();
       }
       
     }
   }
   
  ArrayList<Integer> removedObstacles = new ArrayList<Integer>();
  
  int i = obstacles.size() - 1;
  while (i >= 0){
     for (int k = bullets.size() - 1; k >= 0; k--){
       if(obstacles.get(i).getSprite().bb_collision(bullets.get(k).getSprite())){
         bullets.remove(k);
         removedObstacles.add(i);
       }
     }
     i--;
   }
   
   for (i = removedObstacles.size() - 1; i >= 0; i--){
     this.addItem(new Explosion(obstacles.get(i).getX(), obstacles.get(i).getY(), new Sprite(app,"../Explosion.png",0)));
     obstacles.remove(i);
   }
   
   for(i = 0; i < tanks.size(); i++){
       for (int  j=0; j < tanks.size(); j++){
          if(i!=j && tanks.get(i).getBaseSprite().bb_collision(tanks.get(j).getBaseSprite()))
          {
              tanks.get(i).stop();
              tanks.get(i).lowerHealth(1);
              tanks.get(j).stop();
              tanks.get(j).lowerHealth(1);
          }
       }
   }
   
     for (int l = 0; l < tanks.size(); l++){
       for (int k = bullets.size() - 1; k >= 0; k--){
          if(bullets.get(k).getSprite().bb_collision(tanks.get(l).getBaseSprite())){
            bullets.remove(k);
            tanks.get(l).lowerHealth(((int) (Math.random() * 20)) + 10);

          }
        }
     }
      checkDeath();
  }
  
  public void checkDeath(){
     for(int i = tanks.size() - 1; i >= 0; i--){
         if (tanks.get(i).getHealth() <= 0) {
            this.addItem(new Explosion(tanks.get(i).getPos() [0], tanks.get(i).getPos() [1], new Sprite(app,"../Explosion.png",0)));
            tanks.remove(i);
            
         }
     }
  }
  
public void generateBots(int numberOfBots){
    boolean overlap = false;
    int i = 0;
    while (i < numberOfBots){
      Bot bot = new Bot(100, ((int) (Math.random() * (width - 50)) + 20),((int) (Math.random() * (height - 50)) + 20), (PI / 12) * ((int) (Math.random() * 12)), (PI / 12) * ((int) (Math.random() * 12)), new Sprite(app,"../TankBase" + (((int) (Math.random() * 2)) + 1) + ".png",0), new Sprite(app,"../TankHead" + (((int) (Math.random() * 4)) + 1) + ".png",0),50);
      for (Obstacle obstacle: obstacles){
       if(obstacle.getSprite().pp_collision(bot.getBaseSprite())){
         overlap = true;
         break;
       }
      }
      for (Tank tank: tanks){
       if(tank.getBaseSprite().pp_collision(bot.getBaseSprite())){
         overlap = true;
         break;
       }
      }
      if (!overlap) {
        this.addItem(bot);
        i++;
        }
      else {
         overlap = false; 
      }
    }
    
    
  }
  public void checkBullet(){
    for(Tank tank: tanks){
      if(tank.fired()){
          double [] pos = tank.getPos();
          Bullet bullet = new Bullet(((int) pos[0]), ((int) pos[1]), new Sprite(app,"../Bullet.png",0), tank.getTurrAngle());
          this.addItem(bullet);
          tank.setFired(false);
          tank.setReloadDecrementer(tank.getReloadTime());
      }
    }    
  }
  public void generateObstacles(int numberOfObstacles){
   boolean overlap = false;
    int i = 0;
    while (i < numberOfObstacles / 2){
      Crate crate = new Crate(((int) (Math.random() * (width - 50)) + 20),((int) (Math.random() * (height - 50)) + 20), new Sprite(app,"../Crate.png",0));
      crate.getSprite().setX(crate.getX());
      crate.getSprite().setY(crate.getY());
      for (Obstacle obstacle: obstacles){
       if(obstacle.getSprite().pp_collision(crate.getSprite())){
         overlap = true;
         break;
       }
      }
      for (Tank tank: tanks){
       if(tank.getBaseSprite().pp_collision(crate.getSprite())){
         overlap = true;
         break;
       }
      }
      if (!overlap) {
        this.addItem(crate);
        i++;
      }
      else {
         overlap = false; 
      }
    }
    overlap = false;
    i = 0;
    while (i < numberOfObstacles / 2){
      Barrel barrel = new Barrel(((int) (Math.random() * (width - 50)) + 20),((int) (Math.random() * (height - 50)) + 20), new Sprite(app,"../Barrel.png",0));
      barrel.getSprite().setX(barrel.getX());
      barrel.getSprite().setY(barrel.getY());
      for (Obstacle obstacle: obstacles){
       if(obstacle.getSprite().pp_collision(barrel.getSprite())){
         overlap = true;
         break;
       }
      }
      for (Tank tank: tanks){
       if(tank.getBaseSprite().pp_collision(barrel.getSprite())){
         overlap = true;
         break;
       }
      }
      if (!overlap) {
        this.addItem(barrel);
        i++;
      }
      else {
         overlap = false; 
      }
    }
  }

}



public class Tank {
  private int health;
  private int maxHealth;
  private boolean detected;
  private float tankAngVel;
  private float turrAngVel;
  private float tankAngle, turrAngle;
  private String moveState; // "Brake" "Forward" "Backward"
  private String turnState; // "Stop Turn" "Turn Left" "Turn Right"
  private String turrState; // "Stop Turn Turret" "Turn Turret Left" "Turn Turret Right"
  private int reloadTime;
  private int reloadDecrementer;
  private Sprite base_sprite;
  private Sprite head_sprite;
  private boolean fired;

  public Tank(int health, double x, double y, float tankAngle, float turrAngle, Sprite base_sprite, Sprite head_sprite,int reloadTime) {
    this.health = health;
    this.maxHealth = health;
    this.tankAngle = tankAngle;
    this.turrAngle = turrAngle;
    tankAngVel = 0;
    moveState = "Brake";
    turnState = "Stop Turn";
    turrState = "Stop Turret Turn";
    this.base_sprite = base_sprite;
    this.head_sprite = head_sprite;
    this.base_sprite.setPos(new Vector2D(x, y));
    this.head_sprite.setPos(new Vector2D(x, y));
    this.reloadTime = reloadTime;
    reloadDecrementer = reloadTime;
    fired = true;
  }
  
  public void update() {
    // update tank angular velocity
    if (turnState.equals("Stop Turn")) {
      tankAngVel = Physics.stopTurn(tankAngVel);
    } else if (turnState.equals("Turn Left")){
      tankAngVel = Physics.turnLeft(tankAngVel);
    } else if (turnState.equals("Turn Right")){
      tankAngVel = Physics.turnRight(tankAngVel);
    }
    
    // update turret angular velocity
    if (turrState.equals("Stop Turret Turn")){
      turrAngVel = Physics.stopTurretTurn(turrAngVel);
    } else if (turrState.equals("Turn Turret Left")){
      turrAngVel = Physics.turnTurretLeft(turrAngVel);
    } else if (turrState.equals("Turn Turret Right")){
      turrAngVel = Physics.turnTurretRight(turrAngVel);
    }
              
    // update tank angle
    tankAngle += tankAngVel;
    tankAngle %= 2*PI;
              
    // update turret angle
    turrAngle += turrAngVel;
    turrAngle %= 2*PI;

    // update velocity
    if (moveState.equals("Forward")) {
      Physics.forward(base_sprite, head_sprite);
    } else if (moveState.equals("Brake")) {
      Physics.brake(base_sprite, head_sprite); 
    }
    
    // update reload time
    reloadDecrementer--;
  }
  
  public void draw(){
    base_sprite.setRot(tankAngle);
    base_sprite.setDirection(tankAngle);
    head_sprite.setRot(turrAngle);
    base_sprite.draw();
    head_sprite.draw();
    
    
    rectMode(CORNER);
    fill(0,255,0);
  
    rect((int)(this.getPos()[0]) - 20, (int)(this.getPos()[1]) - 20, health / 2, 5);
    if(Math.abs(base_sprite.getX() - mouseX) <=15 && Math.abs(base_sprite.getY() - mouseY) <=15){
    ellipseMode(CENTER);
    noFill();
    stroke(153);
    ellipse((int) getPos()[0], (int) getPos()[1], 350, 350);
    noStroke();
    }
    rect((int)(this.getPos()[0]) - 20, (int)(this.getPos()[1]) - 20, maxHealth/2, 5);
    fill(255,0,0);
    rect((int)(this.getPos()[0]) - 20 + (health / 2), (int)(this.getPos()[1]) - 20, (maxHealth / 2) - (health / 2), 5);
    
    fill(0, 0, 0);
    text(health + "/" + maxHealth, (int)(this.getPos()[0]) - 20, (int)(this.getPos()[1]) - 30);
     
    


  }
  
  public double[] getPos() {
    double[] returnArr = new double[2];
    returnArr[0] = base_sprite.getX();
    returnArr[1] = base_sprite.getY();
    
    return returnArr;
  }
              
  public double[] getVel() {
    double[] returnArr = new double[2];
    returnArr[0] = base_sprite.getVelX();
    returnArr[1] = base_sprite.getVelY();
    
    return returnArr;
  }
  
  public void stop(){
   base_sprite.setVelXY(0,0); 
   head_sprite.setVelXY(0,0);  
   tankAngVel = 0;
  }
                  
  public float getTankAngVel() {          
    return tankAngVel;
  }
  
  public float getTurrAngVel(){
    return turrAngVel;
  }
            
  public double getTankAngle() {
    return tankAngle;
  }
            
  public double getTurrAngle() {
    return turrAngle;
  }
  
  public void forward() {
    moveState = "Forward"; 
  }
  
  public void backward() {
    moveState = "Backward"; 
  }
  
  public void brake() {
    moveState = "Brake"; 
  }
  
  public void turnLeft() {
    turnState = "Turn Left"; 
  }
  
  public void turnRight() {
    turnState = "Turn Right"; 
  }
  
  public void stopTurn() {
    turnState = "Stop Turn"; 
  }
  
  public void turnTurretLeft() {
    turrState = "Turn Turret Left";
  }
  
  public void turnTurretRight() {
    turrState = "Turn Turret Right"; 
  }
  
  public void stopTurretTurn() {
    turrState = "Stop Turn Turret"; 
  }
          
  public Sprite getBaseSprite() {
    return base_sprite;
  }
            
  public Sprite getHeadSprite() {
    return head_sprite;
  }
            
  public int getReloadTime(){
    return reloadTime; 
  }
  
  public int getReloadDecrementer(){
    return reloadDecrementer; 
  }
            
  public void setDetection(boolean detected) {
    this.detected = detected;
  }
            
  public void setBaseSprite(Sprite base_sprite) {
    this.base_sprite = base_sprite;
  }
            
  public void setHeadSprite(Sprite head_sprite) {
    this.head_sprite = head_sprite;
  }

  
  public void setReloadTime(int reloadTime){
    this.reloadTime = reloadTime; 
  }

  public void setReloadDecrementer(int reloadDecrementer){
    this.reloadDecrementer = reloadDecrementer; 
  }

  public int getMaxRange() {
    return 175;
    }
  
  //TURNING STUFF (Both tank and turret)
  //AIMING/ FIRING (Also zooming)
  public int getHealth() {
    return health;
  }
  
  public void setHealth(int health){
    this.health = health;
  }
  
  public int getMaxHealth() {
    return maxHealth;
  }
  
  public void setMaxHealth(int maxHealth){
    this.maxHealth = maxHealth;
  }
  
  public void lowerHealth(int damage) {
    this.health = health - damage;
  }
  
  public boolean fired(){
    return fired;
  }
  
  public void setFired(boolean fired){
    this.fired = fired;
  }
  
  public void fireBullet(){
    if (reloadDecrementer <= 0) {
      setFired(true);
    }  
  }
}
      
      
          
        //aiming methods
          //turning turret
          
          //zooming in on other tank
          
          //
        //firing methods
          //fire
          //reloading
          
        //enemy tank detection
            //circle spotting radius
                //if the other tank is detected, then the turrent and firing methods come into play
        
        
//TAUNTING METHODS    
public class Sin extends CommandBlock {
  public Sin(ControlP5 cp5, ControlFont cf, Tank tank) {
    super(cp5, tank);
    this.g.getCaptionLabel().set("Sin").setFont(cf); 
  }

  public void execute() {
    println("MUST IMPLEMENT SIN");
  }
}

public class Cos extends CommandBlock {
  public Cos(ControlP5 cp5, ControlFont cf, Tank tank) {
    super(cp5, tank);
    this.g.getCaptionLabel().set("Cos").setFont(cf);
     
  }

  public void execute() {
    println("MUST IMPLEMENT COS");
  }
}

public class Tan extends CommandBlock {
  public Tan(ControlP5 cp5, ControlFont cf, Tank tank) {
    super(cp5, tank);
    this.g.getCaptionLabel().set("Tan").setFont(cf);
     
  }

  public void execute() {
    println("MUST IMPLEMENT TAN");
  }
}
  public void settings() {  size(1260, 720); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Driver" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
