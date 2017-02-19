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
public class Comparison1Var extends ConditionBlock{
  LogicBlock var1;
  public Comparison1Var(ControlP5 cp5, ControlFont cf, Tank tank){
    super(cp5, cf, tank);
    this.h = 120;
    this.g.getCaptionLabel().set("Comparision with 1 Variable").setFont(cf);
    this.g.setSize(this.w , this.h);
    this.var1 = this.add(new LogicBlock(cp5, cf, tank, "Var1", 0, this.g));
  }
    Boolean calculate(){
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
                      .setFont(new ControlFont(createFont("Times", 30)))
                      .onClick(new CallbackListener(){
           public void controlEvent(CallbackEvent event) {
             println(event.getController().getValue());
           }
     });;
                       
  }
  
  Boolean calculate(){
    if(var1.next != null && var2.next != null){
      int op = (int) operatorList.getValue();
      
      switch(op){
        case 0:
          return ((GetCommandBlock) var1.next).getValue() == ((GetCommandBlock) var2.next).getValue();
        case 1:
          return ((GetCommandBlock) var1.next).getValue() < ((GetCommandBlock) var2.next).getValue();
        case 2:
          return ((GetCommandBlock) var1.next).getValue() <= ((GetCommandBlock) var2.next).getValue();
        case 3:
          return ((GetCommandBlock) var1.next).getValue() > ((GetCommandBlock) var2.next).getValue();
        case 4:
          return ((GetCommandBlock) var1.next).getValue() >= ((GetCommandBlock) var2.next).getValue();
        case 5:
          return ((GetCommandBlock) var1.next).getValue() != ((GetCommandBlock) var2.next).getValue();
      }
    }
    return false;
  }
  
  void setVisible(Boolean bol){
    super.setVisible(bol);
    this.var1.setVisible(bol);
    this.var2.setVisible(bol);
  }
  
  void move(float x, float y){
    super.move(x, y);
    this.var1.connectionUpdate();
    this.var2.connectionUpdate();
  }
}