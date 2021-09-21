class Solver {
  Cell[][] cells;
  int speed,counter;

  Cell finish, current;
  ArrayList<Cell> stack;
  boolean solvedMaze = false;
  
  float strokeWeight;


  Solver(Cell[][] _cells) {
    this.cells = copyGrid(_cells);
    counter = 0;

    int rows = cells.length;
    int cols = cells[0].length;
    finish  = cells[rows-1][cols-1];

    stack = new ArrayList<Cell>();
    current = cells[0][0];
    stack.add(current);

    solvedMaze = false;
  }

  void step() {
    if (!solvedMaze) {
      current = pop(stack);
      current.path = true;
      current.solved = true;
      Cell next = current.unsolvedNeighbor();
      if (next != null) {
        stack.add(current);
        stack.add(next);
        next.parent = current;
      } else {
        current.path = false;
      }
      solvedMaze = current.equals(finish);
      
      counter++;
    } else {
      for (Cell[] cellRow : cells) {
        for (Cell cell : cellRow) {
          if (!cell.path)
            cell.solved = false;
        }
      }
      finish.path = true;
    }
    strokeWeight(strokeWeight);
    drawGrid(cells);
    current.highlight();
    finish.highlight();
  }
  
  void drawPath() {
    for (Cell[] cellRow : cells) {
      for (Cell cell : cellRow) {
        cell.displayAsPath();
      }
    }
  }
}
