import org.gicentre.utils.stat.*;        // For graphs

// Sketch to use genetic algorithm to find solution to a phrase.
// Andy Sisinger 9-17-2017

// --------------------- Sketch-wide variables ----------------------

String goalPhrase = "genetic algorithms are cool";
PFont f;
BarChart avgScoreChart;
GA ga; 
static final String characters = "abcdefghijklmnopqrstuvwxyz "; // possible values for genes
ArrayList<Float> data; // easy data structure for loading into graph points
//ArrayList<String> labels;
int gen = 0; 
int maxGen = 1000;
boolean pause = false;

// ------------------------ Initialisation --------------------------

// Initialises the data and bar chart.
void setup()
{
  size(900,600);
  smooth();
  //frameRate(5); // uncomment this to slow down the animation
  
  f = createFont("Consolas", 14);
  textFont(f);
  
  // Create a Genetic Algorith Simulation
  ga = new GA(goalPhrase);
  ga.createPopulation();
  
  data = new ArrayList<Float>();
  //labels = new ArrayList<String>(); // removed x axis labels
  
  avgScoreChart = new BarChart(this);
                                      
  avgScoreChart.setBarColour(color(200,80,80,100));
  avgScoreChart.setBarGap(0); 
  avgScoreChart.setValueFormat("#.##");
  avgScoreChart.showValueAxis(true); 
  //avgScoreChart.showCategoryAxis(true); 
}

// ------------------ Processing draw --------------------

void draw()
{
  if ((gen > maxGen) || ga.solved() || pause) {
    noLoop();  // stop the simulation if we solved it, or we reached max generations
  }
  
  background(0);
  data.add(ga.getAvgScore()); // get the average score of the current population, add it to the chart data
  
  
  // this hack is used to because the graph program won't accept Float object, just float primitives
  float[] dataf = new float[data.size()];
  for (int i=0; i<data.size(); i++) {
    dataf[i] = data.get(i);
  }
  avgScoreChart.setData(dataf);

  // Draw the graph
  avgScoreChart.draw(20, 20, width-30, (height/2)-30);
  //avgScoreChart.draw(20, 20, width-30, height-30);
  
  // Write some statistics to the top left corner of chart
  fill(180);
  float textHeight = textAscent();
  text("Generation: " + gen, 50, 30);
  text("Average population fitness: " + ga.getAvgScore(), 50,30+textHeight);
  text("Max score: " + ga.getBestScore(), 50,30+2*textHeight);
  text("Goal: " + ga.getPhrase(), 50,30+3*textHeight); 
  text("Best: " + ga.getBest(), 50,30+4*textHeight);
  text("Time: " + millis() + "ms", 50,30+5*textHeight);
  if (ga.solved()) {
    text("SOLVED!", 50,30+6*textHeight);
  }
  
  // Top Scores below graph
  ArrayList<Individual> hsl = ga.getHighScores();
  text("High Scores", 30, (height/2)+30);
  for (int i=0; i<hsl.size(); i++) {
    String spacingHack = "   ";
    if (i>=9) spacingHack = "  ";
    text("#" + (i+1) + spacingHack + hsl.get(i).getString() + "  " + hsl.get(i).getScore(), 50, (height/2)+30+(i+2)*textHeight);
  }
  //text("#1  " + hsl.get(0).getString() + "  " + hsl.get(0).getScore(), 50, (height/2)+30+2*textHeight);
  //text("#2  " + hsl.get(1).getString() + "  " + hsl.get(1).getScore(), 50, (height/2)+30+3*textHeight);
  //text("#3  " + hsl.get(2).getString() + "  " + hsl.get(2).getScore(), 50, (height/2)+30+4*textHeight);
  
  // Move the the next generation, increment the simulation one step
  ga.nextGen();
  gen++;
}

void mouseClicked() {
  if (pause) {
    pause = false;
    loop();
  } else {
    pause = true;
  }
}