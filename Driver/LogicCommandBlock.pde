public abstract class LogicCommandBlock extends CommandBlock{
  
  public LogicCommandBlock(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);    
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