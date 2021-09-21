boolean touched = false;

class Button {
  float x, y, w, h;
  float borderRadius, borderSize, textSize;
  color fillColor, borderColor, textColor;
  String text;

  Button(float _x, float _y, float _w, float _h) {
    this.x = _x;
    this.y = _y;
    this.w = _w;
    this.h = _h;

    this.borderRadius = 0;
    this.borderSize   = 1;
    this.textSize     = 32;

    this.fillColor   = color(255, 0, 0);
    this.borderColor = color(0);
    this.textColor   = color(255);

    this.text = "";
  }

  void display() {
    strokeWeight(1);
    textAlign(CENTER, CENTER);
    rectMode(CENTER);

    strokeWeight(borderSize);
    fill(fillColor);
    stroke(borderColor);
    rect(x, y, w, h, borderRadius);
    
    fill(textColor);
    textSize(textSize);
    text(text, x, y);
  }

  boolean isTouched() {
    PVector mouse = new PVector(mouseX, mouseY);
    boolean checkX = (mouse.x >= x-w/2) && (mouse.x <= x+w/2);
    boolean checkY = (mouse.y >= y-w/2) && (mouse.y <= y+h/2);
    //    line(x-w/2,0,x-w/2,height);line(x+w/2,0,x+w/2,height);
    //    debug("x:",checkX);debug("y:",checkY);debug("touched:",touched);
    return checkX && checkY && touched;
  }
}

void touchStarted() {
  touched = true;
}

void touchEnded() {
  touched = false;
}
