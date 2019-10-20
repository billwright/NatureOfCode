 //<>//
Integer width = 600;
Integer height = 600;
Integer cellSize = 30;
Integer numColumns = width / cellSize;
Integer numRows = height / cellSize;

int[][] board = new int[numColumns][numRows];

Boolean isRunning = false;
Boolean singleStep = false;

Integer generation = 0;

void setup() {
  size(600, 600);
  clearBoard();
  drawBoard();
  frameRate(3);
}

void mousePressed() {
  if (!isRunning) {
    // Initialize board
    int cellX = mouseX / cellSize;
    int cellY = mouseY / cellSize;
    if (board[cellX][cellY] == 0) {
      board[cellX][cellY] = 1;
    } else {
      board[cellX][cellY] = 0;
    }
    println("Setting cell [" + cellX + "," + cellY + "] alive");
    drawBoard();
  } else {
    resetBoardRandomly();
  }
}

void keyPressed() {
  if (key == 's') {
    if (isRunning) {
      println("Stopping in current state");
      isRunning = false;
    } else {
      println("Stepping one generation...");
      singleStep = true;
      advanceAGeneration();
    }
  } else {
    singleStep = false;
    isRunning = ! isRunning;
    if (isRunning) {
      println("Running...");
      if (isBoardCleared()) {
        println("Board is empty, so randomly setting it before starting");
        resetBoardRandomly();
      } else {
        println("Running from manual configuration");
      }
    } else {
      clearBoard();
      drawBoard();
      println("Click to initialize a cell");
    }
  }
}

void printDirections() {
  if (isRunning) {
    println("Click to set the board to a random configuration and run");
    println("Press any key to stop and clear the board");
  } else {
    println("Click to initialize a cell");
    println("Press 's' to advance one generation");
    println("Press any other key to start running");
  }
}

// Radomly reeset board cells 
void resetBoardRandomly() {
  //background(11, 222, 242);
  for (int x = 0; x < numColumns; x++) {
    for (int y = 0; y < numRows; y++) {
      board[x][y] = int(random(2));
    }
  }
}

// Clear board
void clearBoard() {
  generation = 0;
  for (int x = 0; x < numColumns; x++) {
    for (int y = 0; y < numRows; y++) {
      board[x][y] = 0;
    }
  }
}

Boolean isBoardCleared() {
  for (int x = 0; x < numColumns; x++) {
    for (int y = 0; y < numRows; y++) {
      if (board[x][y] == 0) return false;
    }
  }
  return true;
}

void draw() {
  if (isRunning) {
    advanceAGeneration();
  }
  drawBoard();
}

void drawBoard() {
  for (int x = 0; x < numColumns; x++) {
    for (int y = 0; y < numRows; y++) {
      if (board[x][y] == 0) {
        fill(255);
      } else {
        fill(0);
      }
      stroke(0);
      rect(x*cellSize, y*cellSize, cellSize, cellSize);
    }
  }
}

void advanceAGeneration() {
  int[][] next = new int[numColumns][numRows];
  for (int x = 1; x < numColumns-1; x++) {
    for (int y = 1; y < numRows-1; y++) {
      next[x][y] = nextState(x, y);
    }
  }

  board = next;
  println("Created generation " + generation);
  generation++;
}

// if state is equal to 1, then the cell is alive
int numNeighbors(int x, int y) {
  int neighbors = 0;
  for (int i = -1; i <= 1; i++) {
    for (int j = -1; j <= 1; j++) {
      int neighborX = x + i;
      int neighborY = y + j;
      if (neighborX >=0 && neighborX < numColumns && neighborY >= 0 && neighborY < numRows) {
        neighbors += board[neighborX][neighborY];
      } else {
        println("Not adding neighbors for coordinates " + x + "," + y); //<>//
      }
    }
  }
  neighbors -= board[x][y];
  return neighbors;
}

int nextState(int x, int y) {
  // If alive and I have less than two neighbors, I'll die of lonliness
  if ((board[x][y] == 1) && (numNeighbors(x, y) < 2)) return 0;

  // If alive and I have more than three neighbors, I'll die due to overpopulation
  if ((board[x][y] == 1) && (numNeighbors(x, y) > 3)) return 0;

  // If dead and I have exactly three neighbors, I'll be reborn
  if ((board[x][y] == 0) && (numNeighbors(x, y) == 3)) return 1;

  // Else, I'll stay in my current state, either dead or alive
  else return board[x][y];
}
