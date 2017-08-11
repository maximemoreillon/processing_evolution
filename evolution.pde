Population my_population;
Simulation[] simulations;

float simulation_time = 3000; // [ms]
float last_selection_time;

void setup() {
  size(1280,900);
  
  my_population = new Population(500, 3);
  simulations = new Simulation[my_population.chromosomes.length];
  
  // chromosomes initialized randomly
  for(int simulation_index=0; simulation_index<simulations.length; simulation_index++){
    simulations[simulation_index] = new Simulation();
  }
  
  last_selection_time = millis();
}


void draw() {
  background(0);
  
  // Display generation
  fill(255);
  textSize(24);
  textAlign(LEFT,UP);
  text("Generation: " + my_population.generation,25,50);
  
  // simulation and display
  for(int chromosome_index=0; chromosome_index<my_population.chromosomes.length; chromosome_index++){
  
    simulations[chromosome_index].simulate(my_population.chromosomes[chromosome_index].genes);
    simulations[chromosome_index].display(map(chromosome_index,-1,my_population.chromosomes.length,0,width), width/(my_population.chromosomes.length+1));

    // Fitness function: Get as close as possible to the line but try not to overshoot
    
    if(simulations[chromosome_index].error < 0) {
      my_population.chromosomes[chromosome_index].fitness += -10*abs(simulations[chromosome_index].error);
    }
    else
    {
      my_population.chromosomes[chromosome_index].fitness += -abs(simulations[chromosome_index].error);
    }
    
  }
  
  if(millis() - last_selection_time > simulation_time){
    last_selection_time = millis();
    
    my_population.natural_selection();
    println("Generation: " + my_population.generation + " max fitness: " + my_population.max_fitness + " mean fitness: " + my_population.mean_fitness + ", min fitness: " + my_population.min_fitness + ", death_toll: " + my_population.death_toll);
    
    for(int chromosome_index=0; chromosome_index<my_population.chromosomes.length; chromosome_index++){
      simulations[chromosome_index] = new Simulation();
    }
  }
}