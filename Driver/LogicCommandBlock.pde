public abstract class LogicCommandBlock extends CommandBlock{
  
  LogicBlock conditionGroup, thenGroup, elseGroup;
  
  public LogicCommandBlock(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);    
    this.h = 150;
    this.g.setOpen(true);
    this.g.getCaptionLabel().set("If").setFont(cf);
    this.g.setSize(this.w, this.h);
   
    this.conditionGroup = new LogicBlock(cp5, cf, tank, "Condition", 0);
    this.thenGroup = new LogicBlock(cp5, cf, tank, "Then", 1);
    this.elseGroup = new LogicBlock(cp5, cf, tank, "Else", 2);         
  
  }
  
  void setVisible(Boolean bol){
    super.setVisible(bol);
    this.conditionGroup.setVisible(bol);
    this.thenGroup.setVisible(bol);
    this.elseGroup.setVisible(bol);
  }
  abstract void execute();
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
       g.setCaptionLabel(s);
     }
     
     void execute(){
     }
   }
   
public class ForLoop extends LogicCommandBlock{
  public ForLoop(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.elseGroup.setLabel("Next");
  }

  void execute() {

  }
}

public class IfStatement extends LogicCommandBlock{
  public IfStatement(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("If").setFont(cf);
  }

  void execute() {

  }
}

public class WhileLoop extends LogicCommandBlock{
  public WhileLoop(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("While").setFont(cf);
  }

  void execute() {

  }
}