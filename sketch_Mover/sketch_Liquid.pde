class Liquid {
  float x,y,w,h;
  float coefficientOfDrag;
  
  Liquid(float x_, float y_, float w_, float h_, float c_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    coefficientOfDrag = c_;
  }
  
  void display() {
    noStroke();
    fill(175);
    rect(x,y,w,h);
  }
}

