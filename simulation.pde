class Simulation{
  
  // Simulation parameters
  float altitude;
  float velocity;
  float acceleration;
  float mass = 1;
  float last_simulation_time;
  float target = height/2;

  
  Simulation(){
    
    // Constructor
    altitude = 0;
    velocity = 0;
    last_simulation_time = millis();
  }
  
  
  
  void simulate(float[] simulation_parameters){
    
    float Kp = simulation_parameters[0];
    float Kd = simulation_parameters[1];
    
    float force = Kp*(target-altitude) + Kd*velocity;
    
    float now = millis();
    float dt = (now - last_simulation_time)/1000.00;
    last_simulation_time = now;
    
    acceleration = force/mass;
    velocity += acceleration*dt;
    altitude += velocity*dt;
    
    if(altitude > height){
      altitude = height;
    }
    if(altitude < 0){
      altitude = 0;
    }
  }
  
  void display(float pos_x) {
    
    float rect_width = width/(population_size+1);
    float radius = 10;
    
    rectMode(CENTER);
    noStroke();
    fill(255,0,0);
    rect(pos_x, height-altitude,rect_width,5);

  }
}