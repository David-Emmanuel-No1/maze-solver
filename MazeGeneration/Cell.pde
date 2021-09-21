class Cell {
  int i, j;
  Cell parent;
  boolean traversed, solved, path;
  boolean[] walls;
  Cell[][] cells;

  Cell(int _i, int _j, Cell[][] _cells) {
    this.i = _i;
    this.j = _j;
    traversed = false;
    solved = false;
    path = false;
    walls = new boolean[4];
    walls[0] = true;
    walls[1] = true;
    walls[2] = true;
    walls[3] = true;
    cells = _cells;
  }

  Cell copy(Cell[][] newCells) {
    Cell newCell = new Cell(i, j, newCells);

    newCell.traversed = traversed;
    newCell.solved = solved;
    newCell.path = path;

    newCell.walls[0] = walls[0];
    newCell.walls[1] = walls[1];
    newCell.walls[2] = walls[2];
    newCell.walls[3] = walls[3];

    return newCell;
  }

  Cell neighbor() {
    ArrayList<Cell> neighbors;
    neighbors = new ArrayList<Cell>();
    int rows = cells.length;
    int cols = cells[0].length;

    if (i > 0) {
      Cell top = cells[i-1][j];
      if (!top.traversed) {
        neighbors.add(top);
      }
    }

    if (j < cols-1) {
      Cell right = cells[i][j+1];
      if (!right.traversed)
        neighbors.add(right);
    }

    if (i < rows-1) {
      Cell bottom = cells[i+1][j];
      if (!bottom.traversed)
        neighbors.add(bottom);
    }

    if (j > 0) {
      Cell left = cells[i][j-1];
      if (!left.traversed)
        neighbors.add(left);
    }

    int n = neighbors.size();
    if (n > 0) {
      int index = floor(random(0, n));
      return neighbors.get(index);
    } else {
      return null;
    }
  }

  Cell unsolvedNeighbor() {
    ArrayList<Cell> neighbors;
    neighbors = new ArrayList<Cell>();
    int rows = cells.length;
    int cols = cells[0].length;

    if (i > 0) {
      Cell top = cells[i-1][j];
      if (!(top.solved || walls[0]))
        neighbors.add(top);
    }

    if (j < cols-1) {
      Cell right = cells[i][j+1];
      if (!(right.solved || walls[1]))
        neighbors.add(right);
    }

    if (i < rows-1) {
      Cell bottom = cells[i+1][j];
      if (!(bottom.solved || walls[2]))
        neighbors.add(bottom);
    }

    if (j > 0) {
      Cell left = cells[i][j-1];
      if (!(left.solved || walls[3]))
        neighbors.add(left);
    }

    int n = neighbors.size();
    if (n > 0) {
      int index = floor(random(0, n));
      return neighbors.get(index);
    } else {
      return null;
    }
  }



  void display() {
    color c;
    if (solved && !path) {
      c = color(255, 0, 0);
    } else if (traversed) {
      c = color(200, 50, 100);
    } else {
      c = color(255);
    }
    display(c);

    if (path) {
      Tuple topLeft = new Tuple();
      boolean horizontal = true;

      Cell[] neighbors = solvedNeighbor();
      for (Cell cell : neighbors) {

        int dx = cell.j - this.j;
        int dy = cell.i - this.i;
        if (dx == -1) {
          topLeft.set(i, j-1);
          horizontal = true;
        } else if (dx == 1) {
          topLeft.set(i, j);
          horizontal = true;
        } else if (dy == -1) {
          topLeft.set(i-1, j);
          horizontal = false;
        } else if (dy == 1) {
          topLeft.set(i, j);
          horizontal = false;
        }

        float w, h;
        if (horizontal) {
          w = (size - padding)*2;
          h = size - padding*2;
        } else {
          w = size - padding*2;
          h = (size - padding)*2;
        }
        noStroke();
        fill(255, 255, 0);
        rect(topLeft.j*size+padding, 
          topLeft.i*size+padding, 
          w, h);
      }
    }
  }

  Cell[] solvedNeighbor() {
    ArrayList<Cell> neighbors;
    neighbors = new ArrayList<Cell>();
    int rows = cells.length;
    int cols = cells[0].length;

    if (i > 0) {
      Cell top = cells[i-1][j];
      if (top.solved && !walls[0])
        neighbors.add(top);
    }

    if (j < cols-1) {
      Cell right = cells[i][j+1];
      if (right.solved && !walls[1])
        neighbors.add(right);
    }

    if (i < rows-1) {
      Cell bottom = cells[i+1][j];
      if (bottom.solved && !walls[2])
        neighbors.add(bottom);
    }

    if (j > 0) {
      Cell left = cells[i][j-1];
      if (left.solved && !walls[3])
        neighbors.add(left);
    }

    Cell[] out = new Cell[neighbors.size()];
    return neighbors.toArray(out);
  }

  void displayAsPath() {
    Tuple topLeft = new Tuple();
    boolean horizontal = true;

    if (this.path && this.parent != null) {
      int dx = this.parent.j - this.j;
      int dy = this.parent.i - this.i;
      if (dx == -1) {
        topLeft.set(i, j-1);
        horizontal = true;
      } else if (dx == 1) {
        topLeft.set(i, j);
        horizontal = true;
      } else if (dy == -1) {
        topLeft.set(i-1, j);
        horizontal = false;
      } else if (dy == 1) {
        topLeft.set(i, j);
        horizontal = false;
      }

      float w, h;
      if (horizontal) {
        w = (size - padding)*2;
        h = size - padding*2;
      } else {
        w = size - padding*2;
        h = (size - padding)*2;
      }
      noStroke();
      fill(0, 255, 0);
      rect(topLeft.j*size+padding, 
        topLeft.i*size+padding, 
        w, h);
    }
  }

  void display(color c) {
    noStroke();
    fill(c);
    rect(j*size, i*size, size, size);

    stroke(0);
    if (walls[0]) {
      line(j*size, i*size, (j+1)*size, i*size);
    }
    if (walls[1]) {
      line((j+1)*size, i*size, (j+1)*size, (i+1)*size);
    }
    if (walls[2]) {
      line((j+1)*size, (i+1)*size, j*size, (i+1)*size);
    }
    if (walls[3]) {
      line(j*size, (i+1)*size, j*size, i*size);
    }
  }

  void highlight() {
    display(color(0, 255, 0));
  }

  boolean equals(Cell other) {
    return i==other.i && j==other.j;
  }
}
