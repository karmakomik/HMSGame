/* 
* HaathiMeraSaathi Local 
* December 2015
* Author: Unnikrishnan R
* Ammachi Labs
*/

import processing.net.*;

Client c;

PFont f,f1,f2;
String s = "";
StringList cmdList;
String cmds = "";
PImage left,right,forward,eat;

void setup() 
{
  size(displayWidth, displayHeight);
  background(0);
  eat = loadImage("eat.png");
  left = loadImage("turnleft.png");
  right = loadImage("turnright.png");
  forward = loadImage("goforward.png");
  // Create the font
  //printArray(PFont.list());
  f = loadFont("SourceSansPro-Regular-160.vlw");
  f1 = loadFont("SourceSansPro-Regular-16.vlw");
  f2 = loadFont("SourceSansPro-Regular-48.vlw");
  //textFont(f,16);
  cmdList = new StringList();  
  //llkstextAlign(CENTER, CENTER);
  
  c = new Client(this, "127.0.0.1", 12345); // Replace with your server's IP and port
} 

void keyReleased()
{
  if(key == '1')
  {
      cmds="";
  }
  else if(s.length() < 15)
  {
      if(key == BACKSPACE)
      {
          if(s.length() > 0)
          {
              s = s.substring(0, s.length()-1);
          }      
      }
      else if(key == TAB)
      {
          s+="  ";
      }
      else if(key == ENTER)
      {
          println(s);
          if(s.equals("goforward();") || s.equals("turnleft();") || s.equals("turnright();") || s.equals("eat();"))
          {
              s+="\n";
              cmds+=s;
              c.write(s);
          }
          s = "";
      }
      else
      {
          if((key >= 32) && (key <=126))
          {
              s+=key;
          }
      }
  }
  else
  {
      s = s.substring(0, s.length()-1);
  }
}



void draw()
{
  background(0);
  
  fill(200,90,30);
  textFont(f,160);
  text(s,50,270); //current command
  
  fill(30,20,20);
  rect(0,500,1150,displayHeight-500); //bottom area
  textFont(f,48);
  fill(255,255,255);
  image(left,100,550);
  text("turnleft();",190,605);  
  image(right,600,550);
  text("turnright();",690,605); 
  image(forward,100,650);
  text("goforward();",190,700);  
  image(eat,600,650);
  text("eat();",690,700); 
  
  fill(20,20,60);
  rect(1155,0,displayWidth-1155,50);
  fill(255);
  textFont(f2,36);
  text("Program", 1200, 35);//past commands 
  
  textFont(f1,16);
  text(cmds, 1200, 70);//past commands
  
  fill(100);
  rect(1150,0,5,displayHeight); //line
  
}

boolean sketchFullScreen() 
{
  return !true;
}

