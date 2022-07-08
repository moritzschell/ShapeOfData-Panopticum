ArrayList <Prisoner> prisoners;

int PLANE_COUNT = 48;
int CYCLE_COUNT = 6;
int CYCLE_RADIUS = 1000;

float camRotationY = 0;

void setup() {
  size(1920, 1080, P3D);
  pixelDensity(2);
  prisoners = new ArrayList<Prisoner>();

  float planeWidth = calculatePlaneWidth(CYCLE_RADIUS, PLANE_COUNT);
  float angleBetweenPlanes = calculateAngle(PLANE_COUNT);
  float cylinderHeight = planeWidth * (CYCLE_COUNT - 1);

  //println(planeWidth);
  //println(angleBetweenPlanes);
  //println(cylinderHeight);

  int index = 0;

  for (int i = 0; i < CYCLE_COUNT; i++) {
    float y = map(i, 0, CYCLE_COUNT - 1, -cylinderHeight / 2, cylinderHeight / 2);
    PVector yPos = new PVector(0, y, 0);
    for (float phi = 0; phi < TWO_PI; phi += angleBetweenPlanes) {
      PVector newPos = pointOnCircleXZ(phi, CYCLE_RADIUS);
      newPos.add(yPos);

      prisoners.add(new Prisoner(index, newPos.x, newPos.y, newPos.z, phi, planeWidth, planeWidth));
      index++;
    }
  }
}


void draw() {
  //Display FrameRate
  surface.setTitle("Panopticum — fps: " + (int)frameRate);

  background(0);

  //Look around
  //float camRotationY = map(mouseX, 0, width, 0, TWO_PI);
  float x = cos(camRotationY) * 1.0;
  float z = sin(camRotationY) * 1.0;
  camera(0.0, 0.0, 0.0, x, 0.0, z, 0.0, 1.0, 0.0);

  //display prisoners
  for (Prisoner p : prisoners) {
    p.hover(mouseX, mouseY);
    p.display();
  }
}


////__________________________________////
////          Helper Functions        ////
////__________________________________////

//Circumference of circle: 2*PI*r
float calculatePlaneWidth(float radius, int numberOfPlanes) {
  float circumference = 2 * PI * radius;
  float planeWidth = circumference / (float)numberOfPlanes;
  return planeWidth;
}

float calculateAngle(int numberOfPlanes) {
  return (2 * PI) / (float)numberOfPlanes;
}

PVector pointOnCircleXZ(float angle, float radius) {
  float x = cos(angle) * radius;
  float z = sin(angle) * radius;
  return(new PVector(x, 0, z));
}


////__________________________________////
////          User Interaction        ////
////__________________________________////

public void mouseWheel(MouseEvent me) {
  //println(me.getAction());

  //Horizontal Scroll:
  if (me.isShiftDown()) {
      println("Horizontal scroll");
      println(me.getCount());
      camRotationY += me.getCount()/100.0;
  }
}
