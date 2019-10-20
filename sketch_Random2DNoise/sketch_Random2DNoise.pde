size(640, 360);

loadPixels();

for (int x = 0; x < width; x++) {
  float yoff = 0.0;
  for (int y = 0; y < height; y++) {
    float bright = random(255);
    pixels[x+y*width] = color(bright);
  }
}
updatePixels();
