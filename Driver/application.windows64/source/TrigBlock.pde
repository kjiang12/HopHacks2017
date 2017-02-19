public class Sin extends CommandBlock {
  public Sin(ControlP5 cp5, ControlFont cf, Tank tank) {
    super(cp5, tank);
    this.g.getCaptionLabel().set("Sin").setFont(cf); 
  }

  void execute() {
    println("MUST IMPLEMENT SIN");
  }
}

public class Cos extends CommandBlock {
  public Cos(ControlP5 cp5, ControlFont cf, Tank tank) {
    super(cp5, tank);
    this.g.getCaptionLabel().set("Cos").setFont(cf);
     
  }

  void execute() {
    println("MUST IMPLEMENT COS");
  }
}

public class Tan extends CommandBlock {
  public Tan(ControlP5 cp5, ControlFont cf, Tank tank) {
    super(cp5, tank);
    this.g.getCaptionLabel().set("Tan").setFont(cf);
     
  }

  void execute() {
    println("MUST IMPLEMENT TAN");
  }
}