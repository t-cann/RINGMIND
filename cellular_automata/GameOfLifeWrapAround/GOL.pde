// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class GOL {

  int w = 10;
  int columns, rows;
  int rMax= width/2 -10;
  int rMin =width/20;

  // Game of life board
  Cell[][] board;


  GOL() {
    // Initialize rows, columns and set-up arrays
    columns = 90;
    rows = height/w;
    board = new Cell[columns][rows];
    //next = new int[columns][rows];
    // Call function to fill array with random values 0 or 1
    init();
  }

  void init() {
    for (int i =0; i < columns; i++) {
      for (int j =0; j < rows; j++) {
        board[i][j] = new Cell(((rMax-rMin)/rows)*j +rMin, (360/(columns-1))*i, (rMax-rMin)/rows, 360/(columns-1));
      }
    }
  }

  // The process of creating the new generation
  void generate() {

    int[][] next = new int[columns][rows];

    // Loop through every spot in our 2D array and check spots neighbors
    for (int x = 0; x < columns; x++) {
      for (int y = 0; y < rows; y++) {

        // Add up all the states in a 3x3 surrounding grid
        int neighbors = 0;
        for (int i = -1; i <= 1; i++) {
          for (int j = -1; j <= 1; j++) {
            if ((y+j>=0) && (y+j<=rows)) {
              neighbors += board[(x+i+columns)%columns][(y+j+rows)%rows].state;
            }
          }
        }

        // A little trick to subtract the current cell's state since
        // we added it in the above loop
        neighbors -= board[x][y].state;

        // Rules of Life
        if      ((board[x][y].state == 1) && (neighbors <  2)) next[x][y] = 0;           // Loneliness
        else if ((board[x][y].state == 1) && (neighbors >  3)) next[x][y] = 0;           // Overpopulation
        else if ((board[x][y].state == 0) && (neighbors == 3)) next[x][y] = 1;           // Reproduction
        else                                             next[x][y] = board[x][y].state; // Stasis
      }
    }

    // Next is now our board
    for (int x = 0; x < columns; x++) {
      for (int y = 0; y < rows; y++) {
        board[x][y].state = next[x][y];
      }
    }
  }

  // This is the easy part, just draw the cells, fill 255 for '1', fill 0 for '0'
  void display() {
    push();
    
    for ( int i = 0; i < columns; i++) {
      for ( int j = 0; j < rows; j++) {
        board[i][j].display();
      }
    }
    pop();
  }

  //  void display_Old() {
  //  push();
  //  translate(width/2, height/2);
  //  for ( int i = 0; i < columns; i++) {
  //    for ( int j = 0; j < rows; j++) {
  //      if ((board[i][j] == 1)) fill(0);
  //      else fill(255); 
  //      stroke(0);
  //      arc(0, 0, width-(width/rows)*j, height-(height/rows)*j, radians(180+(360/(columns-1))*i), radians(180+(360/(columns-1))*(i+1)));
  //    }
  //  }
  //  pop();
  //}
}
