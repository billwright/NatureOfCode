int[] randomCounts;

void setup() {
  size(640, 240);
  randomCounts = new int[640];
  for (int x = 0; x < randomCounts.length; x++) { 
    randomCounts[x] = int(random(-120,120));
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

