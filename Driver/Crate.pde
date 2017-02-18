import sprites.Sprite;

public class Crate extends Obstacles{
  int x;
  int y;
  Sprite sprite;
  public Crate(int x, int y, Sprite sprite){
    super(x, y, sprite);
  }
}