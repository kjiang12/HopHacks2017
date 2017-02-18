import java.util.LinkedList;
import java.util.ListIterator;
import controlP5.*;


ControlP5 cp5;
ControlFont cf;
LinkedList<CommandBlock> commandList;
Tank tank;

void setup (){
  size(1200, 700);
  noStroke();
  rectMode(CENTER);
  cp5 = new ControlP5(this);
  cf = new ControlFont(createFont("Times",12));
  commandList = new LinkedList<CommandBlock>();
  MoveBackward command = new MoveBackward(cp5, cf);
  commandList.add(command);
  parse();
  tank = new Tank(100,5,5,7,7,10,10,new Sprite(this,"../TankBase.png",0),new Sprite(this,"../TankHead.png",0));
}

void parse(){
    for (CommandBlock command: commandList) {
      command.execute();
    }
  
}

void draw(){
  background(0);
  if(cp5.isMouseOver()){
    for(CommandBlock command : commandList){
      command.draw();
    }
  }
}