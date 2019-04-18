// can decide on these as we go along

enum State{
  introState,
  zoomState1,
  followState1
};



State systemState;


// scneario class - aka scene but cant use scene as its inbuilt into proscene

abstract class Scenario {
  abstract boolean transitionTo(float t);
  void update(int t){
  }
  void postRender(int t){
  }
  
}



// evaluate what state


void evalScenario(){
  
  int t =millis();
  
  switch(systemState){
    case introState:
    
    break;
    
    case zoomState1:
    
    break;
    
    case followState1:
    
    break;
  }
}

// scenarios each one extends Scenario

// timer class
