/* Use this class for creating buttons */

class Button extends Splashscreen {
  
  PImage image;
  String imagename;
  String imageNameOnHover;
  
  boolean buttonClicked = false;
  boolean playSoundOnClick = false;
  
  
  
  AudioPlayer audioPlayer;
  AudioInput input;
  
  Button(float x, float y, String imagename){
    this.pos = new PVector(x, y);
    this.image = loadImage(imagename);
    this.w = 220;
    this.h = 47;
  }
  
  // Sets sound for button click
  void setSound(String filename) {
      audioPlayer = minim.loadFile(filename);
  }
  
  void playSound() {
    audioPlayer.play();
  }
  
  void display() {
     image(image, pos.x, pos.y);
  }
  
  boolean clicked() {
    if(mouseX > pos.x && mouseX < (pos.x + w) &&
       mouseY > pos.y && mouseY < (pos.y + h) && 
       mousePressed){
          buttonClicked = true;
          
          if(playSoundOnClick){
            playSound();
          }
          
          return true;
     }
     else {
          return false;
      }
  }
  
  boolean hover(){
    if(mouseX > pos.x && mouseX < (pos.x + w) &&
       mouseY > pos.y && mouseY < (pos.y + h)) {
         println("dd");
         image = loadImage(imageNameOnHover);
         image(image, pos.x, pos.y);
         return true;
       }
       else {
          return false;
       }
       
    }
}
