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

    //PVector mouse = new PVector(mouseX, mouseY);
    //PVector dir = PVector.sub(mouse, location);
    //Float distanceToMouse = dir.mag();

    //dir.normalize();
    //dir.mult(0.5);

    //acceleration = dir;

    //velocity.add(acceleration);
    //velocity.limit(topspeed);
    location.add(velocity);
    acceleration.mult(0);  // Clear acceleration since it has no memory
  }

  void setColor() {
    stroke(0);
    fill(redColor, greenColor, blueColor);
  }
  
  void display() {
    setColor();
    
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
    velocity = new PVector(2, 2);
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
}