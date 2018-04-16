import java.util.Collections;

public class HighScores {
  ArrayList<Individual> highScores;
  int num = 20;
  float min = 0.0;
  
  public HighScores() {
    highScores = new ArrayList<Individual>() {
      public boolean add(Individual i) {
        super.add(i);
        Collections.sort(highScores, new IndividualComparator());
        return true;
      }
    };
  }
  
  void add(Individual i) {
    if (i.getScore() >= min) {
      if (!highScores.contains(i)) {
        highScores.add(i);
      }
      min = highScores.get(0).getScore();
    }
    if (highScores.size() > num) {
      highScores.remove(highScores.size()-1);
    }
  }
  
  float getMin() {
    return min;
  }
  
  ArrayList<Individual> getHighScores() {
    return highScores;
  }
  
  Individual get(int index) {
    if (index > num-1) {
      return null;
    }
    return highScores.get(index);
  }
  
  void setNumOfHighScores(int n) {
    this.num = n;
  }
}