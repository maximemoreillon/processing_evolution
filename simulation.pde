class Simulation{
  
  // Simulation parameters
  float position;
  float velocity;
  float acceleration;
  
  float target = height/2;
  float mass = 10;
  float gravity = 9.81;
  
  float error;
  float last_error;
  float error_integral;
  float error_derivative;
  
  float last_simulation_time;
  
  Simulation(){
    // Constructor
    
    // States initialization
    position = 0;
    velocity = 0;
    
    error = target-position;
    last_error = error; // prevent derivative spike
    error_integral = 0;
    
    last_simulation_time = millis();
  }
  
  
  
  void simulate(float[] simulation_parameters){
    
    // Time step computation
    float now = millis();
    float dt = (now - last_simulation_time)/1000.00;
    last_simulation_time = now;
    
    error = target-position;
    error_derivative = (error-last_error)/dt;
    error_integral += error*dt;
    last_error = error;
    
    // Constructing PID controller
    float Kp = simulation_parameters[0];
    float Ki = simulation_parameters[1];
    float Kd = simulation_parameters[2];
    
    // compute force applied on the mass
    float force = Kp*error + Ki*error_integral + Kd*error_derivative - mass*gravity;
    acceleration = force/mass;
    
    // Solving differential equation
    velocity += acceleration*dt;
    position += velocity*dt;
    
    // Boundaries
    if(position > height){
      position = height;
    }
    if(position < 0){
      position = 0;
    }
  }
  
  void display(float pos_x, float w) {

    // target
    stroke(255);
    line(pos_x-0.5*w,target,pos_x+0.5*w,target);
    
    // Position of the mass
    rectMode(CENTER);
    noStroke();
    fill(255,0,0);
    rect(pos_x, height-position,w,5);
  }
}
