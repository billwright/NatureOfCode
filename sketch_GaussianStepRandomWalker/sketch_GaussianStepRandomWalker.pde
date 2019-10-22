import java.util.*; 


class Walker {
  float x;
  float y;
  Random generator;

  Walker() {
    x = width/2;
    y = height/2;
    generator = new Random();
  }

  void display() {
    stroke(0);
    point(int(x), int(y));
  }

  float gaussian(float mean, float sd) {
    float num = (float) generator.nextGaussian();
    return num * sd + mean;
  }

  float montecarlo(int max) {
    while (true) {
      float r1 = random(0, max);

      float probability = r1; 
      float r2 = random(1, max); 

      if (r2 < probability) { 
        return r1;
      }
    }
  }

  void step() {
    //float stepSize = gaussian(5,1);
    float stepSize = montecarlo(10);
    x += random(-stepSize, stepSize);
    y += random(-stepSize, stepSize);
  }
}

Walker w;

void setup() {
  size(1280, 720);
  w = new Walker();
  background(255);
}

void draw() {
  w. step();
  w.display();
}
