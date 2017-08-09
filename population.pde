class Population {
  
  Chromosome[] chromosomes;
  float min_fitness, max_fitness, mean_fitness;
  int death_toll, generation;
  int parent_count = 1; // The number of parents needed to breed
  
  Population(int chromosome_count, int chromosome_gene_count) {
    // Constructor
    generation = 0;
    chromosomes = new Chromosome[chromosome_count];
    for(int chromosome_index=0; chromosome_index<chromosomes.length; chromosome_index++){
      chromosomes[chromosome_index] = new Chromosome(chromosome_gene_count);
    }
  }
  
  void natural_selection() {
    get_fitness_min_max();
    survival_of_the_fittest();
    offspring_of_the_fittest();
    generation ++;
  }

  void get_fitness_min_max() {
    // Gets the best and worst fitness in the population
    
    min_fitness = chromosomes[0].fitness;
    max_fitness = chromosomes[0].fitness;
    mean_fitness = 0;
    
    for(int chromosome_index = 0; chromosome_index < chromosomes.length; chromosome_index ++) {
      if(chromosomes[chromosome_index].fitness < min_fitness) {
        min_fitness = chromosomes[chromosome_index].fitness;
      }
      if(chromosomes[chromosome_index].fitness > max_fitness) {
        max_fitness = chromosomes[chromosome_index].fitness;
      }
      mean_fitness += chromosomes[chromosome_index].fitness/chromosomes.length;
    }
  }
  
  
  void survival_of_the_fittest() {
    // Chromosomes with higher fitness are more likely to survive
    
    death_toll = 0;
    for(int chromosome_index = 0; chromosome_index < chromosomes.length; chromosome_index ++) {
      float survival_probability = 0.00;
      if(min_fitness != max_fitness){
        // Probability of survival depends on how creature compares to others
         survival_probability = map(chromosomes[chromosome_index].fitness, min_fitness, max_fitness,0.00,1.00);
      }
      else {
        // Deal with the case where all chromosomes are identical: 50% chance of dying for everyone
        println("All chromosomes have the same genes");
        survival_probability = 0.5;
      }
      
      // Killing population according to their survival probability
      if(survival_probability < random(0,1)) {
        chromosomes[chromosome_index].alive = false;
        death_toll ++;
      }
    }
  }
  
  
  void offspring_of_the_fittest() {
    // Replacing dead chromosomes with offspring of the survivors
    if(death_toll <= chromosomes.length - parent_count) {
      // Otherwise, the survivors reproduce: dead creatures get replaced with the offspring of random survivors
      for(int chromosome_index = 0; chromosome_index < chromosomes.length; chromosome_index ++) {
        if(!chromosomes[chromosome_index].alive) {

          Chromosome potential_parent;
          do {
            // keep looking for a parent if the selected one is dead or has been selected already
            int potential_parent_index = round(random(0,chromosomes.length-1));
            potential_parent = chromosomes[potential_parent_index];
          }
          while(!potential_parent.alive);
          
          // If alive, the parent gets to breed
          chromosomes[chromosome_index].born_from(potential_parent);
        }
      }
      
      // Revive all chromosomes that were dead and reset everyone's fitness for the next generation (MIGHT NOT BE THE RIGHT PLACE FOR THIS)
      for(int chromosome_index = 0; chromosome_index < chromosomes.length; chromosome_index ++) {
        if(!chromosomes[chromosome_index].alive){
          chromosomes[chromosome_index].alive = true;
        }
        chromosomes[chromosome_index].fitness = 0;
      }
    }
    else {
      // If every chromosome died, re-initialize all of them randomly
      println("Not enough survivors");
      for(int chromosome_index = 0; chromosome_index < chromosomes.length; chromosome_index ++) {
        chromosomes[chromosome_index] = new Chromosome(chromosomes[chromosome_index].genes.length);
      }
    }
  }
}