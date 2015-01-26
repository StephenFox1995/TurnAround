/* Use this class for creating buttons */

class Button extends SplashScreen {
  
  PImage[] image = new PImage[2];
  String imagename;
  String imageNameOnHover;
  PVector textPos;
  boolean changeImageOnHover;
  boolean hoverOver;
  boolean playSoundOnClick = false;
  
  
  AudioPlayer audioPlayer;
  AudioInput input;
  
  Button(float x, float y, String imagename){
    this.pos = new PVector(x, y);
    this.image[0] = loadImage(imagename);
    this.w = 220;
    this.h = 47;
    this.hidden = false;
  }
  
  void display() {
    if(!hidden) {
    
      if(hoverOver && changeImageOnHover){
        image(image[1], pos.x, pos.y);
      
      } else {
        image(image[0], pos.x, pos.y);
      }
    } 
  }
  
  void setToHidden() {
    hidden = true;
  }
  
  void setToUnHidden() {
    hidden = false;
  }
  
  // Sets an image when mouse hovers over the button.
  void setImageOnHover(String imageName) {
    changeImageOnHover = true;
    image[1] = loadImage(imageName);
  }
  
  // Sets sound for button click
  void setSound(String filename) {
      audioPlayer = minim.loadFile(filename);
  }
  
  void playSound() {
    audioPlayer.play();
  }
  
  boolean clicked() {
    if(mouseX > pos.x && mouseX < (pos.x + w) &&
       mouseY > pos.y && mouseY < (pos.y + h) && 
       mousePressed){
        // Check if hidden. Disable clicking functionality
        // if hidden. 
        if(!hidden) {
          
            if(playSoundOnClick){
              playSound();
            }
            
            return true;
        }
        else {
          return false;
        }
     }
     else {
          return false;
      }
  }
  
  boolean hover(){
    if(mouseX > pos.x && mouseX < (pos.x + w) &&
       mouseY > pos.y && mouseY < (pos.y + h)) {
         hoverOver = true;
         return true;
    }
    else {
      hoverOver = false;
      return false;
    }
       
  }
}
