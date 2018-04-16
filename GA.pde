
import java.util.Comparator;

public class GA {
  
 int populationSize = 200;
 float mutationRate = 0.01;
 String phrase; // the goal phrase
 Individual[] population; // a population of individuals
 int gen = 0;
 int poolMultiplier; // an exponential multiplier to size the mating pool array
 boolean solved = false;
 float solutionLimit = 0.9999; // percent correct to be considered "solved"
 float avgScore = 0.0; // avg score of whole population
 String best = ""; // best string so far
 float bestScore = 0.0; // best score so far
 int TOPSCORES_LIMIT = 10;
 HighScores hs;
 
 public GA (String phrase) {
   this.phrase = phrase;
   population = new Individual[populationSize];
   poolMultiplier = populationSize / 10; // seems to be a good way to size mating pool
   //topScores = new PriorityQueue<Individual>(TOPSCORES_LIMIT, new IndividualComparator());
   hs = new HighScores();
 }
 
 void createPopulation() {
   for (int i=0; i<populationSize; i++) {
     String tempRandomString = "";
     for (int j=0; j<phrase.length(); j++) {
       tempRandomString = tempRandomString + characters.charAt((int)random(characters.length()));
     }
     population[i] = new Individual(tempRandomString);
   }
   // check the first scores for solution before evolving here, also calc avg before starting
   calcScores();
 }

 void nextGen() { 
   // 1st - mutate, 2nd - crossover, 3rd - score, 4th calc avgScore, 5th - check for solution
   if (solved) return;
   
   // mutate
   for (int i=0; i<populationSize; i++) {
     population[i].mutate(mutationRate);
   }
   
   // crossover
   // fill the crossover/mating pool
   ArrayList<Individual> pool = new ArrayList<Individual>();
   for (int i=0; i<populationSize; i++) {
     for (int j=0; j<(int)((population[i].getScore() * poolMultiplier) + 1); j++) {   // Need to rework this because of possible/likely negative scores
       pool.add(population[i]);
     }
   }
   // now pick random indices from the pool and crossover to make new population
   for (int i=0; i<populationSize; i++) {
     population[i] = pool.get((int)random(pool.size())).crossover(pool.get((int)random(pool.size())));
   }
   
   // score, calc avg, check for solution
   calcScores();
   gen++;
 }
 
 void calcScores() {
   float sum = 0.0;
   for (int i=0; i<populationSize; i++) {
     float thisScore = population[i].score(phrase);  // score
     if (thisScore > solutionLimit) {   // check for solution
       solved = true;
     }
     if (thisScore > bestScore) {   // this will be replaced by the top score list
       bestScore = thisScore;
       best = population[i].getString();
     }
     if (thisScore >= hs.getMin()) {
       hs.add(population[i]);
     }
     sum = sum + thisScore;
   }
   avgScore = sum / (float)populationSize;
 }
 
 float getAvgScore() {
   return avgScore;
 }
 
 boolean solved() {
   return solved;
 }
 
 String getPhrase() {
   return phrase;
 }
 
 String getBest() {
   return best;
 }
 
 float getBestScore() {
   return bestScore;
 }
 
 ArrayList<Individual> getHighScores() {
   return hs.getHighScores();
 }
 
 Individual getTopScore(int index) {
   return hs.get(index);
 }
 
}