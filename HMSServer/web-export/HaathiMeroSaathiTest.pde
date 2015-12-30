/* 
* HaathiMeroSaathi Ver stepFactor
* August 2015
* Author: Unnikrishnan R
* Ammachi Labs
*/

//int i = 0;
int xOffset = 10;
int yOffset = 10;
int gridSize = 50;
int gridRowCount = 10;
int gridColumnCount = 16;
PImage haathiNorthIm, haathiSouthIm, haathiEastIm, haathiWestIm, treeIm, bananaIm, currHaathiIm;
int currentHaathiGridX;
int currentHaathiGridY;

final int NORTH = 0;
final int EAST = 1;
final int SOUTH = 2;
final int WEST = 3;
int currentHaathiDir = 0;

boolean isCommandRead = false;
StringList commandsList;
String currCommand;
final int animationState = 1;
final int commandProcessingState = 2;
int currentGameState = 0;
int imOffsetX = 0;
int imOffsetY = 0;
float haathiX;
float haathiY;
float steps = 0;
float stepFactor = 0.05;

/* 
* Map conventions
* 0 - Empty 
* 1 - Banana
* 2 - Trees
* 3 - Haathi
*/

int[][] map1 = new int[][]{
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
};

int startTime;

void setup()
{
    size(displayWidth, displayHeight);
    background(255);
    haathiNorthIm = loadImage("haathinorth.png");
    haathiSouthIm = loadImage("haathisouth.png");
    haathiEastIm = loadImage("haathieast.png");
    haathiWestIm = loadImage("haathiwest.png");
    treeIm = loadImage("tree.png");
    bananaIm = loadImage("banana.jpg");
    
    //Set haathi orientation and position
    currentHaathiGridX = 5;
    currentHaathiGridY = 3;
    currentHaathiDir = NORTH;
    
    currHaathiIm = haathiNorthIm;
    setHaathiParams();
    haathiX = imOffsetX + xOffset + currentHaathiGridX * gridSize;
    haathiY = imOffsetY + yOffset + currentHaathiGridY * gridSize;
    commandsList = new StringList();
    
    startTime = millis();
}

boolean timerStarted = true;

void draw()
{
    background(255);
    drawGrid();
  
    //drawTrees();
    if(millis() - startTime > 2000 && timerStarted)
    {
        currentGameState = commandProcessingState;
        timerStarted = false;
        isCommandRead = true;     
    }
  
    if(isCommandRead)
    {
        moveForward();
        turnLeft();
        moveForward();
        moveForward();
        turnRight();
        moveForward();
        moveForward();
        turnLeft();
        moveForward();
        //moveForward();
        //
        //turnRight();
        // 
       isCommandRead = false; 
    }
    processCommands();
    //drawBananas();  
    drawHaathi(haathiX, haathiY);
    //image(currHaathiIm, imOffsetX + xOffset + currentHaathiGridX * gridSize, imOffsetY + yOffset + currentHaathiGridY * gridSize);
}

void moveForward()
{
    commandsList.append("moveForward");
}

void turnLeft()
{
    commandsList.append("turnLeft"); 
}

void turnRight()
{
    commandsList.append("turnRight");
}

void eat()
{
    commandsList.append("eat");
}

void processCommands()
{
  if(currentGameState == commandProcessingState)
  {
      println("commandProcessingState");
      if(commandsList.size() > 0) //Non empty
      {      
        currCommand = commandsList.get(0);
        setHaathiParams();
        currentGameState = animationState;
        commandsList.remove(0); //remove first element in queue   
        steps = 0;
      }      
  }
  
  if(currentGameState == animationState)
  {
    if(currCommand.equals("moveForward"))
    {
          println("animationState moveForward");
          if(currentHaathiDir == NORTH)
          { 
            haathiY = lerp(imOffsetY + yOffset + currentHaathiGridY * gridSize, imOffsetY + yOffset + (currentHaathiGridY - 1) * gridSize, steps);
            haathiX = imOffsetX + xOffset + currentHaathiGridX * gridSize; 
            
            if(steps < 1.0)
            {
                steps = steps + stepFactor;
            }
            else // animation over
            {
              currentGameState = commandProcessingState;
              --currentHaathiGridY;
              steps = 0;
            }             
          }
          if(currentHaathiDir == SOUTH)
          {
            //++currentHaathiGridY;
            haathiY = lerp(imOffsetY + yOffset + currentHaathiGridY * gridSize, imOffsetY + yOffset + (currentHaathiGridY + 1) * gridSize, steps);
            haathiX = imOffsetX + xOffset + currentHaathiGridX * gridSize; 
            
            if(steps < 1.0)
            {
                steps = steps + stepFactor;
            }
            else // animation over
            {
              currentGameState = commandProcessingState;
              ++currentHaathiGridY;
              steps = 0;
            }              
            
          } 
          if(currentHaathiDir == EAST)
          {            
            //++currentHaathiGridY;
            haathiY = imOffsetY + yOffset + currentHaathiGridY * gridSize;             
            haathiX = lerp(imOffsetX + xOffset + currentHaathiGridX * gridSize, imOffsetX + xOffset + (currentHaathiGridX + 1) * gridSize, steps);
            
            if(steps < 1.0)
            {
                steps = steps + stepFactor;
            }
            else // animation over
            {
              currentGameState = commandProcessingState;
              ++currentHaathiGridX;
              steps = 0;
            }                        
          }
          if(currentHaathiDir == WEST)
          {
            //--currentHaathiGridX;

            haathiY = imOffsetY + yOffset + currentHaathiGridY * gridSize;             
            haathiX = lerp(imOffsetX + xOffset + currentHaathiGridX * gridSize, imOffsetX + xOffset + (currentHaathiGridX - 1) * gridSize, steps);
            
            if(steps < 1.0)
            {
                steps = steps + stepFactor;
            }
            else // animation over
            {
              currentGameState = commandProcessingState;
              --currentHaathiGridX;
              steps = 0;
            }               
            
          }
          //currentGameState = animationState;      
    }
    else if(currCommand.equals("turnLeft"))
    {
          println("animationState turnLeft");
          setHaathiParams();
          currentHaathiDir-=1;
          currentGameState = commandProcessingState;
          if(currentHaathiDir < NORTH)
          {
             currentHaathiDir = WEST;
          }        
    }
    else if(currCommand.equals("turnRight"))
    {
          println("animationState turnLeft");
          setHaathiParams();
          currentHaathiDir+=1;
          currentGameState = commandProcessingState;
          if(currentHaathiDir > WEST)
          {
             currentHaathiDir = NORTH;
          }        
    }    
  }  
} 
  

void drawGrid()
{
    stroke(0);
    for(int j = 0; j < gridRowCount + 1; j++)
    {
      line(xOffset, yOffset + (j * gridSize),  xOffset + (gridColumnCount * gridSize), yOffset + (j * gridSize));
    }
    for(int i = 0; i < gridColumnCount + 1; i++)
    {
      line(xOffset + (i * gridSize), yOffset, xOffset + (i * gridSize), yOffset + (gridRowCount * gridSize));
    }
    
    //Draw trees, cactus, bananas
    //for(int i = 0; i < gridRowCount; i++)
    //{
     // image(treeIm, 10, 10);
   // }
    
}

void drawLineBwGrids(int a1, int b1, int a2, int b2)
{
  
}

void setHaathiParams()
{
    if(currentHaathiDir == NORTH)
    {
      currHaathiIm = haathiNorthIm;
      imOffsetX = 10;
      imOffsetY = 5;   
    }
    if(currentHaathiDir == SOUTH)
    {
      currHaathiIm = haathiSouthIm;
      imOffsetX = 10;
      imOffsetY = 5;        
    } 
    if(currentHaathiDir == EAST)
    {
      currHaathiIm = haathiEastIm;
      imOffsetX = 3;
      imOffsetY = 10;  
    }
    if(currentHaathiDir == WEST)
    {
      currHaathiIm = haathiWestIm;
      imOffsetX = 3;
      imOffsetY = 10;        
    }
}

void drawHaathi(float x, float y)
{
    //lerp()
    image(currHaathiIm, x, y);  
    //image(currHaathiIm, imOffsetX + xOffset + currentHaathiGridX * gridSize, imOffsetY + yOffset + currentHaathiGridY * gridSize);  
}

boolean sketchFullScreen() 
{
  return true;
}

