Population my_population;
Simulation[] simulations;

int population_size = 500;

float simulation_time = 1000; // [ms]
float last_selection_time;

void setup() {
  size(displayWidth,displayHeight);
  
  my_population = new Population(population_size, 2);
  simulations = new Simulation[population_size];
  
  // chromosomes initialized randomly
  for(int simulation_index=0; simulation_index<simulations.length; simulation_index++){
    simulations[simulation_index] = new Simulation();
  }
  
  last_selection_time = millis();
}


void draw() {
  background(0);
  
  // simulation and display
  for(int chromosome_index=0; chromosome_index<my_population.chromosomes.length; chromosome_index++){
  
    simulations[chromosome_index].simulate(my_population.chromosomes[chromosome_index].genes);
    simulations[chromosome_index].display(map(chromosome_index,-1,my_population.chromosomes.length,0,width));

    // Fitness function
    my_population.chromosomes[chromosome_index].fitness += -abs(simulations[chromosome_index].target-simulations[chromosome_index].altitude);
  }
  
  if(millis() - last_selection_time > simulation_time){
    last_selection_time = millis();
    
    my_population.natural_selection();
    println("Generation: " + my_population.generation + " max fitness: " + my_population.max_fitness + " mean fitness: " + my_population.mean_fitness + ", min fitness: " + my_population.min_fitness + ", death_toll: " + my_population.death_toll);
    
    for(int chromosome_index=0; chromosome_index<my_population.chromosomes.length; chromosome_index++){
      simulations[chromosome_index] = new Simulation();
    }
  }
  
  fill(255);
  textSize(24);
  textAlign(LEFT,UP);
  text("Generation: " + my_population.generation,25,50);
  
  stroke(255);
  strokeWeight(1);
  line(0,height/2,width,height/2);
  
}