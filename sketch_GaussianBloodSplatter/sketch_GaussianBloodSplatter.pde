import java.util.*; 

Random generator;

void setup() {
  size(640, 360);
  generator = new Random();
}

void draw() {
  float num = (float) generator.nextGaussian();
  float sd = 20;
  float xmean = 320;
  
  float x = sd * num + xmean;
  
  num = (float) generator.nextGaussian();
  float ymean = 180;
  float y = sd * num + ymean;
  
  noStroke();
  fill(255,0,0);
  ellipse(x,y,2,2);
}
