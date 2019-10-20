float z;

void setup() {
  size(640, 360);
  float z = 0.0;
}

void createImage(float z) {
  loadPixels();

  float xoff = 0.0;
  for (int x = 0; x < width; x++) {
    float yoff = 0.0;
    for (int y = 0; y < height; y++) {
      //float bright = random(255);
      float bright = map(noise(xoff, yoff,z), 0, 1, 0, 255);
      pixels[x+y*width] = color(bright);
      yoff += 0.01;
    }
    xoff += 0.01;
  }
}

void draw() {
  createImage(z);
  updatePixels();
  z += 0.01;
}

