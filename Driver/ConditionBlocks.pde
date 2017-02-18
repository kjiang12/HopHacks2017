public abstract class ConditionBlock extends CommandBlock{
  public ConditionBlock(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, tank);
  }
  
  abstract Boolean calculate();
  
  void execute(){
  }
  
  LogicBlock add(LogicBlock logic){
    control.add(logic);
    return logic;
  }
}
public enum Compare { EQUALS, LESSTHAN, LESSTHANOREQUAL, GREATERTHAN, GREATERTHANOREQUAL};
public class Comparison2Var extends ConditionBlock{
  GetCommandBlock var1, var2;
  Compare selected;
  
  public Comparison2Var(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    
  }
  
  Boolean calculate(){
    return false;
  }
  
}