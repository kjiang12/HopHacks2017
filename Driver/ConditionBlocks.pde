public abstract class ConditionBlock extends CommandBlock{
  public ConditionBlock(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);
  }
  
  abstract Boolean calculate();
  
  void execute(){
  }
  
  LogicBlock add(LogicBlock logic){
    control.add(logic);
    logic.changeX(logic.getRX() + logic.w/2);
    logic.changeSize(logic.w / 2, logic.h);
    logic.w /= 2;
    return logic;
  }
}
public enum Compare { EQUALS, LESSTHAN, LESSTHANOREQUAL, GREATERTHAN, GREATERTHANOREQUAL};
public class Comparison2Var extends ConditionBlock{
  LogicBlock var1, var2;
  Compare selected;
  
  public Comparison2Var(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.h = 120;
    this.g.getCaptionLabel().set("Comparision with 2 Variables").setFont(cf);
    this.g.setSize(this.w , this.h);

    this.var1 = this.add(new LogicBlock(cp5, cf, tank, "Var1", 0, this.g));
    this.var2 = this.add(new LogicBlock(cp5, cf, tank, "Var2", 1, this.g));
  }
  
  Boolean calculate(){
    return false;
  }
  
}