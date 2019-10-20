int[] randomCounts;

void setup() {
  size(640, 240);
  randomCounts = new int[640];
  float t = 0.1;
  for (int x = 0; x < randomCounts.length; x++) { 
    randomCounts[x] = int(240 * noise(t) - 120);
    t += 0.001;
  }
}

void draw() {
  background(255);

  int lastY = 120;
  for (int x = 0; x < randomCounts.length; x++) { 
    int newY = 120+randomCounts[x];
    point(x,newY);
    if (x > 0) {
      line(x-1,lastY, x, newY);
      lastY = newY;
    }
  }
}

