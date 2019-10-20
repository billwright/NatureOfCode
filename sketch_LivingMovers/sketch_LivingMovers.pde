// Five moving bodies
ArrayList<LivingMover> movers;

void setup() {
  size(600, 600);
  randomSeed(1);
  reset();
}

void draw() {
  background(255);
  // Update and display
  
  ArrayList<LivingMover> childMovers = new ArrayList<LivingMover>();
  for (LivingMover mover : movers) {
    mover.update();
    mover.display();
    mover.checkEdges();
  }
  
  for (LivingMover mover : childMovers) {
    movers.add(mover);
  }
}

void mousePressed() {
  reset();
}

// Restart all the Mover objects randomly
void reset() {
  movers = new ArrayList<LivingMover>();
  for (int i = 0; i < 5; i++) {
    movers.add(new LivingMover(random(5) + 1));
  }
}