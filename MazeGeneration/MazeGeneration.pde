int rows = 20;
int cols = 20;
float size,padding;

Cell[][] cells;
Solver solver;
boolean running;
color background;
Button playButton;

void setup() {
  background = color(150);
  size(700, 775);
  //frameRate(1);
  
  int sizeX = floor(height/rows);
  int sizeY = floor((height-75)/cols);
  size = min(sizeX,sizeY);
  padding = floor(size/3);

  playButton = new Button(width/2, height-37.5, 200, 74);
  playButton.borderRadius = 10;
  playButton.textSize = 70;
  playButton.text = "PLAY !";

  reset();
  running = false;
}

void reset() {
  cells = generateMaze(rows, cols);
  //noLoop();
  solver = new Solver(cells);
  solver.speed = 50>size ? floor(50/size) : 1;
  solver.strokeWeight = size/8;
}

void draw() {
  debugText = "";
  //  touched = false;
  background(background);
  rectMode(CORNER);
  drawGrid(solver.cells);
  if (running) {
    solver.step();
    if (solver.solvedMaze) {
      running = !playButton.isTouched();
    }
  } else {
    background(background,150);
  }
  if (playButton.isTouched()) {
    reset();
    running = true;
  }
    //    debug("Touched",touched);
    //    debug("Button",playButton.isTouched());
    //    debug("Running",running);
  //solver.drawPath();
  playButton.display();
  showDebug();
}


Cell[][] generateMaze(int rows, int cols) {
  Cell[][] cells = createGrid(rows, cols);
  Cell current = cells[0][0];
  current.traversed = true;
  ArrayList<Cell> stack = new ArrayList<Cell>();
  stack.add(current);

  while (stack.size() > 0) {
    current = pop(stack);
    Cell next = current.neighbor();
    if (next != null) {
      stack.add(current);
      removeWalls(current, next);
      next.traversed = true;
      stack.add(next);
    }
  }
  return cells;
}
