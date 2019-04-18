import netP5.*;
import oscP5.*;

NetAddress soundEngine;
//as we never listen for osc coming back we can save half the comp power by niot using the oscp5 listener function
int portNum = 6448;

void setupOSC() {
  // tony to have correct port listening
  // follow ethernet hookup guide
  soundEngine = new NetAddress("localhost", portNum);
  println("comms connected on port "+portNum);
}

//basic tests
void transmitRingOSC(Ring r) {
  //create a new bundle that can store more than one addresstag and data and then the entire lot can be sent in one go quickly and tony can parse out
  OscBundle bundle = new OscBundle();

  //first bit of data is the ring id
  OscMessage msg = new OscMessage("/ringnumber");
  msg.add(r.ringID);
  bundle.add(msg);
  //clear the message for next data (dont worry its still in the bundle ready to go) 
  msg.clear();
  

  // next bit of data 
  msg.setAddrPattern("/particlesInRing");
  msg.add(r.particles.size());
  bundle.add(msg);
  msg.clear();


 //other info tony needs from the ring
 
 //moon info tony needs - maybe grab in seperate osctransmit as this may change more than the ring ? he doesnt want or need every particle...good grief no



  //send the bundle in one go

  bundle.setTimetag(bundle.now() + 1000);
  // flush the message out
  OscP5.flush(bundle, soundEngine); 
  println("osc data sent to sound");
}



void transmitAllRingsOSC(){
  //first data blast to setup all rings data for the sound engine
  println("sending ring data to sound engine");
  for (Ring rr : Saturn.rings){
    transmitRingOSC(rr);
  } 
}



//think about what data needs changing for each scenario and come up with a global osc packet send - most likely just use inheritance and extend or implement the class
