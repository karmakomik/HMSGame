/* 
* HaathiMeroSaathi Ver stepFactor
* August 2015
* Author: Unnikrishnan R
* Ammachi Labs
*/

import processing.net.*;

PFont f;
Server s;
Client c;

void setup()
{
    size(displayWidth, displayHeight);   
    setUpHMSEnvironment();
    s = new Server(this, 12345); // Start a simple server on a port
    //f = loadFont("Georgia-48.vlw");//createFont("Georgia", 24);//loading vlw fonts are faster than creating one
    //textFont(f);
}

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
  
    if(c!=null)
    {
      String s = c.readString();

      if(s!=null)
      {
          //println("**"+s+"**");
          s = s.substring(0, s.indexOf("\n"));
          if(s.equals("goforward();"))
          {
              commandsList.append("goforward");
          }
          else if(s.equals("turnleft();"))
          {
              commandsList.append("turnleft");
          }
          else if(s.equals("turnright();"))
          {
              commandsList.append("turnright");
          }
          else if(s.equals("eat();"))
          {
              commandsList.append("eat");
          }              
      }
    }  
  
    if(isCommandRead)
    {
      //for(int i=0; i<=6; i++)
      //{
        //turnright();
        //goforward();
        //turnleft();
       // goforward();
      //}
      
       isCommandRead = false; 
    }
    processCommands();
    //drawBananas();  
    drawHaathi(haathiX, haathiY);
    //image(currHaathiIm, imOffsetX + xOffset + currentHaathiGridX * gridSize, imOffsetY + yOffset + currentHaathiGridY * gridSize);
}

void serverEvent(Server someServer, Client someClient) 
{
  c = someClient;
  println("We have a new client: " + someClient.ip());
}

