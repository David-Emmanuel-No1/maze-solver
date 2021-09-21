Cell[][] createGrid(int rows,int cols) {
  Cell[][] cells = new Cell[rows][cols];
  for (int i=0;i<rows;i++) {
    for (int j=0;j<cols;j++) {
      cells[i][j] = new Cell(i,j,cells);
    }
  }
  return cells;
}

Cell[][] copyGrid(Cell[][] cells) {
  int rows = cells.length;
  int cols = cells[0].length;
  Cell[][] newCells = new Cell[rows][cols];
  for (int i=0;i<rows;i++) {
    for (int j=0;j<cols;j++) {
      newCells[i][j] = cells[i][j].copy(newCells);
    }
  }
  return newCells;
}

void drawGrid(Cell[][] cells) {
  background(255);
  for (int i=0;i<cells.length;i++) {
    for (int j=0;j<cells[0].length;j++) {
      cells[i][j].display();
    }
  }
}

class Tuple {
  int i,j;
  Tuple(int i,int j) {
    this.i = i;
    this.j = j;
  }
  Tuple() {
    this.i = 0;
    this.j = 0;
  }
  void set(int i,int j) {
    this.i = i;
    this.j = j;
  }
}

void removeWalls(Cell a, Cell b) {
  int dx = b.j - a.j;
  int dy = b.i - a.i;
  if (dx == -1) {
    a.walls[3] = false;
    b.walls[1] = false;
  } else if (dx == 1) {
    a.walls[1] = false;
    b.walls[3] = false;
  } else if (dy == -1) {
    a.walls[0] = false;
    b.walls[2] = false;
  } else if (dy == 1) {
    a.walls[2] = false;
    b.walls[0] = false;
  }
}

Cell pop(ArrayList<Cell> stack) {
  int index = stack.size()-1;
  Cell cell = stack.get(index);
  stack.remove(index);
  return cell;
}

String debugText = "";
void debug(Object... objs) {
  for (Object obj : objs) {
    debugText=debugText.concat(" ");
    debugText=debugText.concat(String.valueOf(obj));
  }
}
void showDebug() {
  fill(0);
  textSize(32);
  text(debugText, width/2, height/2);
}
