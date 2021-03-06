class Score extends GameObject {
  
  String title;
  String scoreText;
  int scoreValue;
  String[] scoreFromFile;
  int fileContents = 0;
  
  Score(){
    this(0, 0, "Score:", 0);
  }
  
  Score(float x, float y, String title, int value) {
    this.pos = new PVector(x , y);
    this.colour = color(255);
    this.scoreValue = value;
    this.title = title;
    
    // ScoreText is the title e.g. "Score" and the actual score value given
    this.scoreText = title + " " + scoreValue;
  }
  
  void display() {
    fill(colour);
    stroke(colour);
    textSize(20);
    text(scoreText, pos.x, pos.y);
  }
  
  void update() {
  }
  
  void updateScore(int amount){
    scoreValue = scoreValue + amount;
    scoreText = title + " " + scoreValue;
  }
  
  void setPosition(float x, float y) {
    pos.x = x;
    pos.y = y;
  }
  
  int readScoreFromFile(String filename) {
    String filePath;
    String[] scoreFromFile;
    
    // Check if file exists
    if((filePath = checkFileExists(filename)) != null) {
      
      scoreFromFile = loadStrings(filePath);
      fileContents = Integer.parseInt(scoreFromFile[0]);
      return fileContents;
    } 
    else {
      // File doesn't exist so create it
      // and then just return 0
      createFile(filename);  
      return 0;
    }
    
  }
  
  void saveScoreToFile(String filename) {
    PrintWriter output;
    String filePath;
    
    // Check if file exists
    if((filePath = checkFileExists(filename)) != null) {
      output = createWriter(filePath);
      output.println(scoreValue);
      output.flush();
      output.close();
    } 
    else {
      // File doesn't exist so create it
      createFile(filename); 
      
      // Get filepath
      filePath = getFilePath();
      
      // Append filename to filepath
      filePath = filePath + filename;
            
      output = createWriter(filePath);
      output.println(scoreValue);
      output.flush();
      output.close();
    }
  }
  
  
  // Checks to see if a file exists at a directory
  // Will return a string with the filepath to
  // that file if it does exist. Otherwise
  // returns null
  String checkFileExists(String filename) {
    File file = new File("");
    String filePath = "";
    String currentOS = System.getProperty("os.name");
    
    // Gets the filepath depending on the OS
    filePath = getFilePath();
    
    // Apend the filename to filepath
    filePath = filePath + filename;
     
    // Make file type with the filepath
    file = new File(dataPath(filePath));
    
    // Check if it exists.
    if(file.exists()) {
      return filePath;
    } else {
      return null;
    } 
  }
  
  // Returns filepath depending on the OS
  // the user is running.
  // Filepaths are arbitrary for each os.
  // Mac OS X - /Users/user/Library/TurnAround/filename
  // Windows - C:/ProgramData/TurnAround/filenam
  String getFilePath() {
    String filePath = "";
    String currentOS = System.getProperty("os.name");
    
    // Create filepath to directory depending on the
    // operating system 
    if(currentOS.toLowerCase().contains("window")) {
        filePath = "C:/ProgramData/TurnAround/";
        
        return filePath;
    }
    else if(currentOS.toLowerCase().contains("mac")) {
        String user = System.getProperty("user.name");
        filePath = "/Users/" + user + "/Library/TurnAround/";
        
        return filePath;   
    } else {
        return filePath;
    }
    
    
  }
  
  
  
  void createFile(String filename) {
    String filePath;
    PrintWriter output;
    
    filePath = getFilePath();
    
    // Append the filename to filepath.
    filePath = filePath + filename;
    
    output = createWriter(filePath);
    output.println(0);
    output.flush();
    output.close();
  }
}
