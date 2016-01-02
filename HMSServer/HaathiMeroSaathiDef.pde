/*
 * This Sketch contains definitions of classes and other data structures required in the HMS game
 *
*/ 

//int i = 0;
int xOffset = 20;
int yOffset = 20;
int gridSize = 50;
int gridRowCount = 14;
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
float stepFactor = 0.01;

/* 
* Map conventions
* 0 - Empty 
* 1 - Banana
* 2 - Trees
*/

int[][] map1 = new int[][]
{
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0}
};

int[][] map2 = new int[][]
{
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0}, 
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0}, 
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0}, 
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2}, 
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 2}, 
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 1, 2}, 
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 2}, 
 {0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 2}, 
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
};

int[][] map3 = new int[][]
{
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 0, 0, 2, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 0, 2, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 2, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {2, 1, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
 {0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}, 
};

int [][] currentMap;
int startTime;
boolean timerStarted = true;

class map
{

}

class Haathi
{
     PImage northIm;
     PImage southIm;
     PImage eastIm;
     PImage westIm;
     PImage currIm;
     int haathiX;
     int haathiY;
     int currentHaathiDir;
     
     Haathi()
     {
     
     }
     
     void setHaathiParams()
     {
     
     }
     
}

Haathi redHaathi, blueHaathi;

void setUpHMSEnvironment()
{
    currentMap = map1;
  
    haathiNorthIm = loadImage("bluehaathinorth.png");
    haathiSouthIm = loadImage("redhaathisouth.png");
    haathiEastIm = loadImage("redhaathieast.png");
    haathiWestIm = loadImage("redhaathiwest.png");
    treeIm = loadImage("tree.png");
    bananaIm = loadImage("banana.png");
    
    //Set haathi orientation and position
    currentHaathiGridX = 0;
    currentHaathiGridY = gridRowCount - 1;
    currentHaathiDir = NORTH;
    
    currHaathiIm = haathiNorthIm;
    setHaathiParams();
    haathiX = imOffsetX + xOffset + currentHaathiGridX * gridSize;
    haathiY = imOffsetY + yOffset + currentHaathiGridY * gridSize;
    commandsList = new StringList();
    
    startTime = millis();
}

void goforward()
{
    commandsList.append("goforward");
}

void turnleft()
{
    commandsList.append("turnleft"); 
}

void turnright()
{
    commandsList.append("turnright");
}

void eat()
{
    commandsList.append("eat");
}

void processCommands()
{
  if(currentGameState == commandProcessingState)
  {
      //println("commandProcessingState");
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
    if(currCommand.equals("goforward"))
    {
          //println("animationState goforward");
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
    else if(currCommand.equals("turnleft"))
    {
          //println("animationState turnleft");
          //setHaathiParams();
          currentHaathiDir-=1;
          currentGameState = commandProcessingState;
          if(currentHaathiDir < NORTH)
          {
             currentHaathiDir = WEST;
          }   
          setHaathiParams();     
    }
    else if(currCommand.equals("turnright"))
    {
          //println("animationState turnleft");
          //setHaathiParams();
          currentHaathiDir+=1;
          currentGameState = commandProcessingState;
          if(currentHaathiDir > WEST)
          {
             currentHaathiDir = NORTH;
          } 
          setHaathiParams();       
    }   
    else if(currCommand.equals("eat"))
    {
          //println("eat banana!");
          currentGameState = commandProcessingState;
          if(currentMap[currentHaathiGridY][currentHaathiGridX] == 1) // Banana!
          {
              currentMap[currentHaathiGridY][currentHaathiGridX] = 0;
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
    
    //image(bananaIm, 10, 10);
    //Draw trees, cactus, bananas
    for(int i = 0; i < gridRowCount; i++)
    {
      for(int j = 0; j < gridColumnCount; j++)
      {      
       // println("i = " + i + ", j = " + j);
        if(currentMap[i][j] == 1) // Banana
        {
          image(bananaIm, 7 + xOffset + j * gridSize, 9 + yOffset + i * gridSize);
        }
        else if(currentMap[i][j] == 2) //Tree
        {
          image(treeIm, 7 + xOffset + j * gridSize, 9 + yOffset + i * gridSize);
        }
      }
    }
    
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
