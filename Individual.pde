public class Individual {
  String string;
  Float score;
  int generation;
  
  public Individual(String string) {
    this.string = string;
    this.score = 0.0;
    this.generation = 0;
  }
  
  // Crossover/Mate with another Individual
  Individual crossover(Individual partner) {
    char[] child = new char[string.length()];
    for (int i=0; i<string.length(); i++) {
      // 50/50 chance we get gene from either parent
      if (random(1.0) > 0.5) {
        child[i] = string.charAt(i);
      } else {
        child[i] = partner.getString().charAt(i);
      }
    }
    return new Individual(new String(child));
  }
  
  // Calculate and return score for this individual against given goal phrase.
  float score(String phrase) {
    int points = 0;
    for (int i=0; i<phrase.length(); i++) {
      if (phrase.charAt(i) == string.charAt(i)) points++;
    }
    score = (float)points / (float)phrase.length();
    return score;
  }
  
  float getScore() {
    return score;
  }
  
  // Mutate characters/genes in this individual at rate given
  void mutate(float rate) {
    char[] temp = new char[string.length()];
    for (int i=0; i<string.length(); i++) {
      if (random(1.0) < rate) {
        temp[i] = characters.charAt((int)random(characters.length()));
      } else {
        temp[i] = string.charAt(i);
      }
    }
    string = new String(temp);
  }
  
  String getString() {
    return string;
  }
  
  void setGeneration(int gen) {
    this.generation = gen;
  }
  
  @Override
  public boolean equals(Object obj) {
    if (!(obj instanceof Individual)) {
      return false;
    }
    if (obj == this) {
      return true;
    }
    Individual ind = (Individual)obj;
    if (this.getString().equals(ind.getString())) {
      return true;
    }
    return false;
  }
  
}