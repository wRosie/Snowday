/**********************************************************************
  Filename    : Joystick
  Description : Read data from joystick.
  Auther      : www.freenove.com
  Modification: 2020/07/11
**********************************************************************/
int xyzPins[] = {13, 12, 14};   //x,y,z pins
void setup() {
  Serial.begin(115200);
  pinMode(xyzPins[2], INPUT_PULLUP);  //z axis is a button.
  pinMode(25, INPUT_PULLUP);
  pinMode(26, INPUT_PULLUP);
  pinMode(27, INPUT);
}

void loop() {
  int xVal = analogRead(xyzPins[0]);
  int yVal = analogRead(xyzPins[1]);
  int zVal = digitalRead(xyzPins[2]);
  //Serial.printf("X,Y,Z: %d,\t%d,\t%d\n", xVal, yVal, zVal);
  int bval1 = digitalRead(25);
  int bval2 = digitalRead(26);
  int sval = digitalRead(27);
  Serial.print(xVal);
  Serial.print(",");
  Serial.print(yVal);
  Serial.print(",");
  Serial.print(bval1);
  Serial.print(",");
  Serial.print(bval2);
  Serial.print(",");
  Serial.print(sval);
//  Serial.print(xVal + "," +yVal +","+bval1+","+bval2+","+sval);
  Serial.print("\n");
  delay(200);
}
