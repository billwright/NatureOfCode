class LivingMover extends Mover {

  Integer age = 1;
  Integer MAX_AGE_IN_SECONDS = 60;
  Integer deathAgeInSeconds = MAX_AGE_IN_SECONDS;
  Integer reproductiveInterval = (MAX_AGE_IN_SECONDS / 4) * 60;

  LivingMover() {
    super(1, random(width), random(height));
  }

  LivingMover(float m) {
    super(m, random(width), random(height));
    deathAgeInSeconds = round(MAX_AGE_IN_SECONDS / m);
  }

  void update() {
    super.update();
    age++;
  }

  Boolean isAlive() {
    return (age <= deathAgeInSeconds * 60);
  }

  Boolean isReproducing() {
    return (age % reproductiveInterval == 0);
  }

  void setColor() {
    stroke(0);
    Integer ageInSeconds = age / 60;
    Float percentageOfLifeLived = float(ageInSeconds) / deathAgeInSeconds;
    println("Age in seconds is " + ageInSeconds + ", and % of life is " + percentageOfLifeLived + "%");
    fill(255 - (percentageOfLifeLived * 255));
  }
}