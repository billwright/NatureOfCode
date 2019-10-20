class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;

  float mass;
  float radius;
  float topspeed;

  Integer redColor;
  Integer greenColor;
  Integer blueColor;

  void update() {

    acceleration = PVector.random2D();
    acceleration.mult(random(2));
    acceleration.mult(noise(2));

    PVector mouse = new PVector(mouseX, mouseY);
    PVector dir = PVector.sub(mouse, location);
    Float distanceToMouse = dir.mag();

    dir.normalize();
    dir.mult(0.5);

    acceleration = dir;

    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
    acceleration.mult(0);  // Clear acceleration since it has no memory
  }

  void display() {
    stroke(0);
    fill(redColor, greenColor, blueColor);

    ellipseMode(RADIUS);
    ellipse(location.x, location.y, radius, radius);
  }

  Mover() {
    this(1, random(width), random(height));
  }

  Mover(float m) {
    this(m, random(width), random(height));
  }

  Mover(float m, float x, float y) {
    mass = m;
    radius = mass * 16 / 2;

    if (x < radius) {
      x = radius;
    }
    if (x > (width - radius)) {
      x = width - radius;
    }
    if (y < radius) {
      y = radius;
    }
    if (y > (height - radius)) {
      y = height - radius;
    }
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    //acceleration = new PVector(-0.001, 0.01);
    acceleration = new PVector(0.0, 0.0);

    topspeed = 10;

    redColor = int(50+random(200));
    greenColor = int(50+random(200));
    blueColor = int(50+random(200));
  }

  void checkEdges() {
    if (location.x + radius > width) {
      location.x = width - radius;
      velocity.x *= -1;
    } else if (location.x - radius < 0) {
      location.x = radius;
      velocity.x *= -1;
    }
    if (location.y + radius > height) {
      location.y = height - radius;
      velocity.y *= -1;
    } else if (location.y - radius < 0) {
      location.y = radius;
      velocity.y *= -1;
    }
  }

  boolean isInside(Liquid l) {
    if (location.x > l.x && location.x < l.x+l.w && location.y > l.y && location.y < l.y+l.h)
    {
      return true;
    } else {
      return false;
    }
  }

  void applyForce(PVector force) {
    PVector f = PVector.div(force, mass);
    println("force applied to mover is " + f);
    acceleration.add(f);
  }

  void applyResistiveForce(PVector force) {
    PVector f = PVector.div(force, mass);
    println("adding a resistive force of " + f);
    int xForceDirection = 1;
    if (f.x < 0) {
      xForceDirection = -1;
    }
    f.x = xForceDirection * min(abs(f.x), abs(velocity.x));

    int yForceDirection = 1;
    if (f.y < 0) {
      yForceDirection = -1;
    }
    f.y = yForceDirection * min(abs(f.y), abs(velocity.y));

    acceleration.add(f);
  }

  void applyDrag(Liquid l) {
    float speed = velocity.mag();
    float dragMagnitude = l.coefficientOfDrag * speed * speed;

    PVector drag = velocity.get();
    drag.mult(-1);
    drag.normalize();

    drag.mult(dragMagnitude);
    println("speed is " + speed);
    println("Magnitude of drag is " + dragMagnitude);
    applyResistiveForce(drag);
  }
}

