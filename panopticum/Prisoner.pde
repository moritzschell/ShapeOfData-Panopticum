class Prisoner {

  int id;
  PVector planePosition;

  float planeRotationY;
  float planeWidth;
  float planeHeight;

  PVector leftUp, rightBottom;
  PVector leftUpScreen, rightBottomScreen;

  boolean isHovering = false;

  PImage textureImage;

  Prisoner(int _id, float _planeX, float _planeY, float _planeZ, float _planeRotationY, float _planeWidth, float _planeHeight) {
    id = _id;
    planePosition = new PVector(_planeX, _planeY, _planeZ);
    planeRotationY = _planeRotationY;
    planeWidth = _planeWidth - 4;
    planeHeight = _planeHeight -4;

    leftUp = new PVector(-planeWidth*0.5, -planeHeight*0.5, 0);
    rightBottom = new PVector(planeWidth*0.5, planeHeight*0.5, 0);

    leftUpScreen = new PVector(screenX(leftUp.x, leftUp.y, leftUp.z), screenY(leftUp.x, leftUp.y, leftUp.z));
    rightBottomScreen = new PVector(screenX(rightBottom.x, rightBottom.y, rightBottom.z), screenY(rightBottom.x, rightBottom.y, rightBottom.z));

    textureImage = createTexture(planeWidth, planeHeight, String.valueOf(id));

    println("pW " + planeWidth + " pH "+ planeHeight);
    println(planePosition);
  }

  void display() {
  
    pushStyle();
    pushMatrix();
    //fill(255);
    
    noStroke();
    if (isHovering) {
      
      tint(0, 255, 0);
    }

    translate(planePosition.x, planePosition.y, planePosition.z);
    rotateY(PI*1.5 - planeRotationY);

    textureMode(NORMAL);
    beginShape();
    texture(textureImage);
    vertex(leftUp.x, leftUp.y, 0, 0, 0);
    vertex(rightBottom.x, leftUp.y, 0, 1, 0);
    vertex(rightBottom.x, rightBottom.y, 0, 1, 1);
    vertex(leftUp.x, rightBottom.y, 0, 0, 1);
    endShape();

    leftUpScreen = new PVector(screenX(leftUp.x, leftUp.y, leftUp.z), screenY(leftUp.x, leftUp.y, leftUp.z));
    rightBottomScreen = new PVector(screenX(rightBottom.x, rightBottom.y, rightBottom.z), screenY(rightBottom.x, rightBottom.y, rightBottom.z));

    popMatrix();
    popStyle();
  }

  void hover(float _x, float _y) {
    if (_x > leftUpScreen.x && _y > leftUpScreen.y && _x < rightBottomScreen.x && _y < rightBottomScreen.y) {
      isHovering = true;
    } else {
      isHovering = false;
    }
  }

  PImage createTexture(float w, float h, String text) {
    PGraphics pg = createGraphics((int)w, (int)h);

    println((int)w + " " + (int)h);

    pg.beginDraw();
    pg.background(255, 0, 0);

    pg.textSize(50);
    pg.textAlign(CENTER, CENTER);

    pg.fill(255);
    pg.text(text, pg.width/2, pg.height/2);

    //pg.stroke(255);
    //pg.strokeWeight(5.0);
    //pg.line(0, 0, pg.width, pg.height);
    //pg.line(0, pg.height, pg.width, 0);

    //pg.ellipse(0, 0, 20, 20);
    //pg.ellipse(pg.width, 0, 20, 20);
    //pg.ellipse(pg.width, pg.height, 20, 20);
    //pg.ellipse(0, pg.height, 20, 20);

    pg.endDraw();
    return pg.get();
  }
}
