int[] randomCounts;

void setup() {
  size(640, 240);
  randomCounts = new int[20];
}

void draw() {
  background(255);

  int index = int(random(randomCounts.length));

  randomCounts[index]++;
  stroke(0);
  fill(175);
  int w = width/randomCounts.length;

  int maxValue = 0;
  int minValue = height+1;
  int maxIndex = -1;
  int minIndex = -1;
    for (int x = 0; x < randomCounts.length; x++) { 
    if (randomCounts[x] > maxValue) {
      maxValue = randomCounts[x];
      maxIndex = x;
    }
    if (randomCounts[x] < minValue) {
      minValue = randomCounts[x];
      minIndex = x;
    }
  }

  index = int(random(randomCounts.length));
  for (int x = 0; x < randomCounts.length; x++) { 
    if (x == maxIndex) {
      fill(250, 0, 0);
    } else if (x == minIndex) {
      fill(0, 250, 0);
    } else {
      fill(175);
    }  
    rect(x*w, height-randomCounts[x], w-1, randomCounts[x]);
    fill(0);
    text(x, x*w + w/2.5, height-30);
  }
}

