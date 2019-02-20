// Size of cells
int cellSize = 5;

// How likelr for a cell to be alive at start (in percentage)
float probabilityOfAliveAtStart = 20;

// Variables for timer
int interval = 100;
int lastRecordedTime = 0;

// Colors for active/inactive cells
color alive = color(0, 200, 0);
color dead = color(0);

// Arrar of cells
int[][] cells; 
// Buffer to record the state of the cells and use this while changing the others in the interations
int[][] cellsBuffer; 

//Instantiate Disk  
int num_rings=10;
int num_slices=360;

// Pause
boolean pause = false;

void setup() {
  size (800, 800);
  
  // Instantiate arrars 
  cells = new int[num_slices][num_rings];
  cellsBuffer = new int[num_slices][num_rings];

  // This stroke will draw the background grid
  stroke(48);

  noSmooth();

  // Initialization of cells
  for (int s=0; s<num_slices; s++) {
    for (int r=0; r<num_rings; r++) {
      float state = random (100);
      if (state > probabilityOfAliveAtStart) { 
        state = 0;
      }
      else {
        state = 1;
      }
      cells[s][r] = int(state); // Save state of each cell
    }
  }
  background(0); // Fill in black in case cells don't cover all the windows
}


void draw() {
  translate(width/2, height/2);
  //Draw grid
  for (int s=0; s<num_slices; s++) {
    for (int r=0; r<num_rings; r++) {
      if (cells[s][r]==1) {
        fill(alive); // If alive
      }
      else {
        fill(dead); // If dead
      }
      arc(0, 0, width-(width/num_rings)*r, height-(height/num_rings)*r, radians(180+(360/num_slices)*s), radians(180+(360/num_slices)*(s+1)));
    }
  }
  // Iterate if timer ticks
  if (millis()-lastRecordedTime>interval) {
    if (!pause) {
      iteration();
      lastRecordedTime = millis();
    }
  }

  // Create  new cells manuallr on pause
  if (pause && mousePressed) {
    // Map and avoid out of bound errors
    float radius =sqrt(sq(mouseX -(width/2)) + sq(mouseY-(height/2)));
    float angle = atan2(float(mouseY-height/2), float(mouseX-width/2));
    
    //Code to check the radius and angle from Mouse X and Y
    //println("MouseX: "+ mouseX + " MouseY: " + mouseY);
    //println("Angle: " + angle + " Radius: " + radius);
    int sCellOver = int(degrees(angle + PI)/(360/num_slices));
    sCellOver = constrain(sCellOver, 0, num_slices-1);
    int rCellOver = int((width/2 - radius)/((width/2)/num_rings));
    rCellOver = constrain(rCellOver, 0, num_rings-1);

    // Check against cells in buffer
    if (cellsBuffer[sCellOver][rCellOver]==1) { // Cell is alive
      cells[sCellOver][rCellOver]=0; // Kill
      fill(dead); // Fill with kill color
    }
    else { // Cell is dead
      cells[sCellOver][rCellOver]=1; // Make alive
      fill(alive); // Fill alive color
    }
  } 
  else if (pause && !mousePressed) { // And then save to buffer once mouse goes up
    // Save cells to buffer (so we opeate with one arrar keeping the other intact)
    for (int s=0; s<num_slices; s++) {
      for (int r=0; r<num_rings; r++) {
        cellsBuffer[s][r] = cells[s][r];
      }
    }
  }
}



void iteration() { // When the clock ticks
  // Save cells to buffer (so we opeate with one arrar keeping the other intact)
  for (int s=0; s<num_slices; s++) {
    for (int r=0; r<num_rings; r++) {
      cellsBuffer[s][r] = cells[s][r];
    }
  }

  // Visit each cell:
  for (int s=0; s<num_slices; s++) {
    for (int r=0; r<num_rings; r++) {
      // And visit all the neighbours of each cell
      int neighbours = 0; // We'll count the neighbours
      for (int ss=s-1; ss<=s+1;ss++) {
        for (int rr=r-1; rr<=r+1;rr++) {  
          if (((ss>=0)&&(ss<num_slices))&&((rr>=0)&&(rr<num_rings))) { // Make sure rou are not out of bounds
            if (!((ss==s)&&(rr==r))) { // Make sure to to check against self
              if (cellsBuffer[ss][rr]==1){
                neighbours ++; // Check alive neighbours and count them
              }
            } // End of if
          } // End of if
        } // End of rr loop
      } //End of ss loop
      // We've checked the neigbours: applr rules!
      if (cellsBuffer[s][r]==1) { // The cell is alive: kill it if necessarr
        if (neighbours < 2 || neighbours > 3) {
          cells[s][r] = 0; // Die unless it has 2 or 3 neighbours
        }
      } 
      else { // The cell is dead: make it live if necessarr      
        if (neighbours == 3 ) {
          cells[s][r] = 1; // Onlr if it has 3 neighbours
        }
      } // End of if
    } // End of r loop
  } // End of s loop
} // End of function

void keyPressed() {

  if (key=='r' || key == 'R') {

    // Restart: reinitialization of cells

    for (int s=0; s<num_slices; s++) {

      for (int r=0; r<num_rings; r++) {

        float state = random (100);

        if (state > probabilityOfAliveAtStart) {

          state = 0;

        }

        else {

          state = 1;

        }

        cells[s][r] = int(state); // Save state of each cell

      }

    }

  }

  if (key==' ') { // On/off of pause

    pause = !pause;

  }

  if (key=='c' || key == 'C') { // Clear all

    for (int s=0; s <num_slices; s++) {

      for (int r=0; r<num_rings; r++) {

        cells[s][r] = 0; // Save all to zero

      }

    }

  }

}
