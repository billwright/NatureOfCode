Mover[] movers = new Mover[2];
Liquid liquid;

boolean pauseAnimation = false;

float coefficientOfFriction = 0.01;
float coefficientOfDrag = 0.1;

PVector wind = new PVector(0.01, 0);

void setup() {
  //size(800, 600);
  frameRate(30);

  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover(0.1 + random(5), 50 + random(100), 50);
  }
  liquid = new Liquid(0, height/2, width, height/2, 0.1);
  print("Done with setup");
}

void draw() {
  if (! pauseAnimation) {
    background(255);

    liquid.display();

    for (int i = 0; i < movers.length; i++) {
      if (movers[i].isInside(liquid)) {
        movers[i].applyDrag(liquid);
      }

      applyGravity(movers[i]);
      applyFriction(movers[i]);
      movers[i].applyForce(wind);

      movers[i].update();
      movers[i].checkEdges();
      movers[i].display();
    }
  }
}

void applyGravity(Mover aMover) {
  PVector gravity = new PVector(0, 0.1 * aMover.mass);
  //PVector gravity = new PVector(0, 0.1);
  aMover.applyForce(gravity);
}

void applyFriction(Mover aMover) {
  PVector friction = aMover.velocity.get();
  friction.mult(-1);
  friction.normalize();
  friction.mult(coefficientOfFriction);
  aMover.applyForce(friction);
}

void keyPressed() {
  pauseAnimation = ! pauseAnimation;
}