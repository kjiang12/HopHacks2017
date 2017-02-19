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
  
  Boolean calculate(){
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

public class Comparison1Var extends ConditionBlock{
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
}