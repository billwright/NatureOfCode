class Walker {
  float x;
  float y;

  Walker() {
    x = width/2;
    y = height/2;
  }

  void display() {
    stroke(0);
    point(int(x), int(y));
  }

  void step() {
    x += random(-1,1);
    y += random(-1,1);
  }
}

Walker w;

void setup() {
  size(640, 360);
  w = new Walker();
  background(255);
}

void draw() {
  w. step();
  w.display();
}

