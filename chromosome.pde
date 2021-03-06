class Chromosome{
  
  boolean alive;
  float[] genes;
  float fitness;
  float mutation_factor = 10;
  float initial_variance = 1000;
  
  Chromosome(int gene_count){
    // Constructor
    
    genes = new float[gene_count];
    
    // Genes initialized randomly
    for(int gene_index=0; gene_index<genes.length; gene_index++){
      genes[gene_index] = random(-initial_variance, initial_variance);
    }
    
    alive = true;
    fitness = 0;
  }

  
  void born_from(Chromosome parent){
    // Chromosome has genes similar to its parents', but slightly mutated
    for(int gene_index=0; gene_index<genes.length; gene_index++) {
      genes[gene_index] = parent.genes[gene_index] + mutation_factor * randomGaussian();
    }
  }
}
