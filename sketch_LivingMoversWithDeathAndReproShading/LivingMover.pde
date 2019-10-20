class LivingMover extends Mover {

  Integer age = 1;
  Integer MAX_AGE_IN_SECONDS = 60;
  Integer deathAgeInSeconds = MAX_AGE_IN_SECONDS;
  Integer reproductiveIntervalInSeconds = (MAX_AGE_IN_SECONDS / 4);
  Integer reproductiveInterval = reproductiveIntervalInSeconds * 60;

  LivingMover() {
    super(1, random(width), random(height));
  }

  LivingMover(float m) {
    super(m, random(width), random(height));
    age = round(m) * 60;
    deathAgeInSeconds = round((MAX_AGE_IN_SECONDS / m) + (reproductiveIntervalInSeconds / 2));
    println("Born with mass " + m + " and a lifespan of " + deathAgeInSeconds + " seconds and will reproduce every " + reproductiveIntervalInSeconds + " seconds");
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

  Boolean isNearReproducing() {
    return (age % reproductiveInterval > (reproductiveInterval - 180)); // Near reproducing for 3 seconds
  }

  void setColor() {
    stroke(0);
    if ((age > (reproductiveInterval / 2)) && isNearReproducing()) {
      fill(255, 0, 0); // Turn red when near reproducing
    } else {
      Integer ageInSeconds = age / 60;
      Float percentageOfLifeLived = float(ageInSeconds) / deathAgeInSeconds;
      fill(255 - (percentageOfLifeLived * 255));
    }
  }
}