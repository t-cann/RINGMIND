// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

class GOL {

  int r = 20;
  int theta =90;
  int columns, rows;
  
  // Game of life board
  Cell[][] board;


  GOL() {
    // Initialize rows, columns and set-up arrays
    columns = theta;
    rows = height/(2*int(r));
    board = new Cell[columns][rows];
    init();
  }

  void init() {
    
    for (int i = 0; i < columns; i++) {
      for (int j = 0; j < rows; j++) {
         board[i][j] = new Cell(j*r,i*360/columns,r,360 /theta);
      }
    }
  }



  // This is the easy part, just draw the cells, fill 255 for '1', fill 0 for '0'
  void display() {
    for ( int i = 0; i < columns;i++) {
      for ( int j = 4; j < rows;j++) {
        board[i][j].display();
      }
    }
  }
}
