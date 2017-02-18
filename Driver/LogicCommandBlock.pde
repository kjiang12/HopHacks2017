public abstract class LogicCommandBlock extends CommandBlock{
  
  ControlGroup conditionGroup, thenGroup, elseGroup;
  
  public LogicCommandBlock(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);    
    this.h = 150;
    this.g.setOpen(true);
    this.g.getCaptionLabel().set("If").setFont(cf);
    this.g.setSize(this.w, this.h);
    this.conditionGroup = cp5.addGroup("Condition " + this.id)
             .setPosition(10,50)
             .setBackgroundHeight(100)
             .setSize(w,h)
             .setBarHeight(40)
             .setBackgroundColor(color(80,0,180))
             .setFont(new ControlFont(createFont("Times",12)))
             .setOpen(false)
             .disableCollapse()
             .setGroup(this.g)
             .setVisible(false)
             .setCaptionLabel("Condition");
             
   this.thenGroup = cp5.addGroup("Then " + this.id)
             .setPosition(10,100)
             .setBackgroundHeight(100)
             .setSize(w,h)
             .setBarHeight(40)
             .setBackgroundColor(color(80,0,180))
             .setFont(new ControlFont(createFont("Times",12)))
             .setOpen(false)
             .disableCollapse()
             .setGroup(this.g)
             .setVisible(false)
             .setCaptionLabel("Then");
             
             
   this.elseGroup = cp5.addGroup("Else " + this.id)
             .setPosition(10,150)
             .setBackgroundHeight(100)
             .setSize(w,h)
             .setBarHeight(40)
             .setBackgroundColor(color(80,0,180))
             .setFont(new ControlFont(createFont("Times",12)))
             .setOpen(false)
             .disableCollapse()
             .setGroup(this.g)
             .setVisible(false)
             .setCaptionLabel("Else");
  
  }
  
  void setVisible(Boolean bol){
    super.setVisible(bol);
    this.conditionGroup.setVisible(bol);
    this.thenGroup.setVisible(bol);
    this.elseGroup.setVisible(bol);
  }
  abstract void execute();
}
 
public class ForLoop extends LogicCommandBlock{
  public ForLoop(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
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

public class ElseIfStatment extends LogicCommandBlock{
  public ElseIfStatment(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.g.getCaptionLabel().set("Elseif").setFont(cf);
  }

  void execute() {

  }
}

public class ElseStatment extends LogicCommandBlock{
  public ElseStatment(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
        this.g.getCaptionLabel().set("Else").setFont(cf);
  }

  void execute() {

  }
}