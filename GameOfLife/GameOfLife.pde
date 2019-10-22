 //<>// //<>// //<>// //<>// //<>// //<>//
Integer width = 1200;
Integer height = 1200;
Integer cellSize = 15;
Integer numColumns = width / cellSize;
Integer numRows = height / cellSize;

Integer cycleSearchLength = 8;

Integer[][] board = new Integer[numColumns][numRows];
Integer[][] startingPosition;
ArrayList<Integer[][]> lastSavedPositions = new ArrayList<Integer[][]>();

Boolean isRunning = false;
Boolean singleStep = false;

Integer generation = 0;
Integer savedBoardNumber = 1;

void setup() {
  size(1200, 1200);
  clearBoard();
  drawBoard();
  frameRate(3);
  clearSavedPositions();
  printDirections();
}

void clearSavedPositions() {
  lastSavedPositions = new ArrayList<Integer[][]>();
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
  printDirections();
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
  } else if (key == 'r') {
    if (startingPosition != null) {
      println("Resetting state of puzzle to the start position...");
      board = startingPosition;
    }
  } else if (key == 'm') {
    println("Starting from a random position...");
    resetBoardRandomly();
    generation = 0;
    isRunning = true;
  } else if (key == 'w') {
    String fileName = saveBoardStateToFile();
    println("Board position saved to file: " + fileName);
  } else if (key == 'l') {
    loadBoardStateFromFile(1);
    println("Board position loaded from file 1.");
  } else {
    singleStep = false;
    if (!isRunning) {
      saveStartingPosition();
    }
    isRunning = ! isRunning;
    if (isRunning) {
      println("Running...");
      if (isBoardCleared()) {
        println("Board is empty, so randomly setting it before starting");
        resetBoardRandomly();
        generation = 0;
      } else {
        println("Running from manual configuration");
      }
    } else {
      clearBoard();
      drawBoard();
      println("Click to initialize a cell");
    }
  }
  printDirections();
}

void printDirections() {
  print(new String(new char[50]).replace("\0", "\r\n"));
  if (isRunning) {
    println("RUNNING:");
    println("Click to set the board to a random configuration and run");
    println("Press any key to stop and clear the board");
  } else {
    println("NOT RUNNING:");
    println("Click to initialize a cell");
    println("Press 's' to advance one generation");
    println("Press 'w' to write out the state of the board");
    println("Press 'l' to load a board");
    println("Press any other key to start running");
  }
}

// Randomly reeset board cells 
void resetBoardRandomly() {
  //background(11, 222, 242);
  for (int x = 0; x < numColumns; x++) {
    for (int y = 0; y < numRows; y++) {
      if (board[x][y] == null) { //<>//
        printBoard();
        println("Postion ", x, y, " is null!");
      }
      board[x][y] = (int)Math.floor(random(2));
    }
  }
  saveStartingPosition();
}

void saveStartingPosition() {
  startingPosition = new Integer[numColumns][numRows];
  for (int x = 0; x < numColumns; x++) {
    for (int y = 0; y < numRows; y++) {
      startingPosition[x][y] = board[x][y];
    }
  }
  clearSavedPositions();
  saveBoard(board);
}

// Clear board
void clearBoard() {
  generation = 0;
  for (int x = 0; x < numColumns; x++) {
    for (int y = 0; y < numRows; y++) {
      board[x][y] = 0;
    }
  }
  println("Board cleared...");
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
      if (board[x][y] == null) {
        printBoard();
        println("Postion ", x, y, " is null!");
      }
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

void printBoard() {
  for (int x = 0; x < numColumns; x++) {
    print("Row ", x, ":");
    for (int y = 0; y < numRows; y++) {
      print(board[x][y], ", ");
    }
    println();
  }
}

void advanceAGeneration() {
  Integer[][] next = new Integer[numColumns][numRows];
  for (int x = 0; x < numColumns; x++) {
    for (int y = 0; y < numRows; y++) {
      next[x][y] = nextState(x, y);
    }
  }

  board = next;
  generation++;
  if (generation % 25 == 0) {
    println("Created generation ", generation);
  }

  if (cycleDetected()) {
    println("Cycle detected, so stopping after", generation, " generations");
    isRunning = false;
  } else {
    saveBoard(board);
  }
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
        //println("Adding neighbors for coordinates " + neighborX + "," + neighborY);
      } else {
        //println("Not adding neighbors for coordinates " + neighborX + "," + neighborY);
      }
    }
  }
  neighbors -= board[x][y];
  return neighbors;
}

Integer nextState(int x, int y) {
  // If alive and I have less than two neighbors, I'll die of lonliness
  if ((board[x][y] == 1) && (numNeighbors(x, y) < 2)) return 0;

  // If alive and I have more than three neighbors, I'll die due to overpopulation
  if ((board[x][y] == 1) && (numNeighbors(x, y) > 3)) return 0;

  // If dead and I have exactly three neighbors, I'll be reborn
  if ((board[x][y] == 0) && (numNeighbors(x, y) == 3)) return 1;

  // Else, I'll stay in my current state, either dead or alive
  else return board[x][y];
}

String saveBoardStateToFile() {
  JSONArray boardColumns = new JSONArray();
  for (int i = 0; i < numColumns; i++) {
    JSONArray currentRow = new JSONArray();
    for (int j = 0; j < numRows; j++) {
      currentRow.setInt(j, board[i][j]);
    }
    boardColumns.setJSONArray(i, currentRow);
  }

  String fileName = getFileName(savedBoardNumber);
  saveJSONArray(boardColumns, getFileName(savedBoardNumber), "indent=4");
  savedBoardNumber++;
  return fileName;
}

void loadBoardStateFromFile(Integer fileNumber) {
  String fileName = getFileName(fileNumber);
  println("Loading board from file", fileName);
  JSONArray boardColumns = loadJSONArray(fileName);
  for (int i = 0; i < boardColumns.size(); i++) {
    JSONArray currentRow = boardColumns.getJSONArray(i);
    for (int j = 0; j < currentRow.size(); j++) {
      board[i][j] = currentRow.getInt(j);
    }
  }
}

String getFileName(Integer fileNumber) {
  return "/tmp/latestLifeBoard_" + fileNumber + ".life";
}

Boolean boardsAreEqual(Integer[][] board1, Integer[][]board2) {
  for (int i = 0; i < board1.length; i++) {
    for (int j = 0; j < board1[0].length; j++) {
      if (board1[i][j] != board2[i][j]) {
        return false;
      }
    }
  }
  return true;
}

void saveBoard(Integer[][] aBoardPosition) {
  Integer[][] newBoardPosition = new Integer[numColumns][numRows];
  for (int i = 0; i < numColumns; i++) {
    for (int j = 0; j < numRows; j++) {
      newBoardPosition[i][j] = aBoardPosition[i][j];
    }
  }
  if (lastSavedPositions.size() == cycleSearchLength) {
    lastSavedPositions.remove(0);
  }
  lastSavedPositions.add(newBoardPosition);
}

Boolean cycleDetected() {
  Integer cycleLength = lastSavedPositions.size();
  for (int i = 0; i < lastSavedPositions.size(); i++) {
    if (boardsAreEqual(board, lastSavedPositions.get(i))) {
      println("Cycle length is ", cycleLength);
      return true;
    } else {
      cycleLength--;
    }
  }
  return false;
}

// TODO:
//   * Add ability to save initial board state and then to reload it. 
//   * Automatically save state for each restart (overwriting from previous start of program)
//   * Recognize when the state is cycling (settable number of states to store) - one example cycled between 7 different states
//
