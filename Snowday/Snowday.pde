  /**
 * Simple Read
 * 
 * Read data from the serial port and change the color of a rectangle
 * when a switch connected to a Wiring or Arduino board is pressed and released.
 * This example works with the Wiring / Arduino program that follows below.
 */


import processing.serial.*;

Serial port;  // Create object from Serial class
String val;      // Data received from the serial port
float[] vals;
int state = 0; 
color theme;

int themeState=0;

ArrayList<Snowflake> flakes;

void setup() 
{
  fullScreen();
  frameRate(30);
  flakes = new ArrayList();
  vals = new float[]{1750,1750,1,1,1};
  theme = color(125, 227, 227);
  String portName = Serial.list()[6];
  System.out.println(portName);
  port = new Serial(this, portName, 115200);
  
  //myPort = new Serial(this, portName, 9600);
}

void draw()
{
   /* Read Serial values*/
   if ( port.available() > 0) {  // If data is available,
     val = port.readStringUntil('\n');         // read it and store it in val
     val = trim(val);
     if(val!=null&& val.length()<18 && val.length()>=7){
       //System.out.println(val);
       String temp[] = val.split(",");
       for(int i = 0; i <temp.length; i++){
         if(isNumeric(temp[i])) vals[i] = Float.parseFloat(temp[i]);
       }
     }
     
     //if(val!=null){
     //  vals = val.split(",");
     //}
   }
   for(float s:vals){
     System.out.print(s+";");}
   System.out.println(";");
  
   /* Change States*/
   if(state == 0){ //init
     if(vals[4] == 0) state=1;
   }
   else if(state == 1){ //playing
     if(vals[3]==0) state=2;
     if(vals[4]==1) state=0;
   }
   else if(state==2){ //pause
     if(vals[3]==1) state=1;
     if(vals[4]==1) state=0;
   }
 
  background(theme);
  if(state==0)
    initScreen();
  else if(state==1)
    playing();
  else
    pause();
  
}

void initScreen(){ //stage0
  textSize(64);
  fill(39, 186, 98);
  text("Snow Day", width/2-32, height/2-32); 
  text("to change theme", width/2-32, height/2); 
  snowfall();
  themeChange();
}

void playing(){ //stage1
  snowfall();
  applyWind(vals[0]-1750,vals[1]-1860);
  if(vals[2]==0){
    heavySnow();
  }
}

void pause(){ //stage3
  triangle(width/2,height/2, width/2, height/2+80, width/2+60, height/2+40);
  for(Snowflake s: new ArrayList<Snowflake>(flakes)){
    s.display();
  }
}

void themeChange(){
  // themeState 0 -> bright theme, ready to change
  // themeState 1 -> dark theme, not ready to change
  // themeState 2 -> dark theme, ready to change
  // themeState 3 -> bright theme, not ready to change
   if(themeState == 0 &&vals[3] == 0) themeState = 1;
   else if(themeState == 1 && vals[3] == 1) themeState = 2;
   else if(themeState == 2 && vals[3] == 0) themeState = 3;
   else if(themeState == 3 && vals[3] == 1) themeState = 0;
   
   if(themeState == 0 || themeState == 1) theme = color(125, 227, 227);
   else theme = color(0);
}

void heavySnow(){
  for(int i = 1; i<10;i++)
  flakes.add(new Snowflake());
}
void snowfall(){
  flakes.add(new Snowflake());
  for(Snowflake s: new ArrayList<Snowflake>(flakes)){
    s.fall();
    s.display();
    if(s.outOfRange == true) flakes.remove(s);
  }
}

void applyWind(float x, float y){
  for(Snowflake s: new ArrayList<Snowflake>(flakes)){
    s.wind(x,y);
  }
}

class Snowflake{
  float posx, posy, diameter, xscale,yscale;
  boolean outOfRange = false;
  Snowflake(){
    posx = random(width);
    posy = random(-10,-100);
    
    xscale = random(0,0.1);
    yscale = random(0,0.1);
    diameter = random(5,10);
  }
  
  void fall(){
    posy += 80/diameter;
    if(posy > height+diameter){
      outOfRange = true;
    }
  }
  
  void wind(float x, float y){
    posy += y*yscale/diameter;
    posx += x*xscale/diameter;
  }
  
  void display(){
    fill(255);
    noStroke();
    ellipse(posx,posy,diameter, diameter);
  }
}

public static boolean isNumeric(String strNum) {
    if (strNum == null) {
        return false;
    }
    try {
        double d = Double.parseDouble(strNum);
    } catch (NumberFormatException nfe) {
        return false;
    }
    return true;
}
