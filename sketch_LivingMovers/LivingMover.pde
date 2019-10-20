class LivingMover extends Mover {
  
  Integer age = 1;
  Integer MAX_AGE_IN_SECONDS = 60;
  Integer deathAge = MAX_AGE_IN_SECONDS;
  Integer reproductiveInterval = (MAX_AGE_IN_SECONDS / 4) * 60;
  
   LivingMover() {
    super(1, random(width), random(height));
  }

  LivingMover(float m) {
    super(m, random(width), random(height));
    deathAge = round(MAX_AGE_IN_SECONDS / m);
  }
  
  void update() {
    super.update();
    age++;
  }
  
  Boolean isAlive() {
    return (age <= deathAge * 60); 
  }
  
  Boolean isReproducing() {
    return (age % reproductiveInterval == 0);
  }
  
  
}