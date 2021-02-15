# Snowday
## Overview
The cold Wisconsin winter has been my favorite time. I love snow days! It has been white outside for some time but the Covid prevents me from going outside and enjoy the snow. So what? Let’s bring it inside!

Snow flakes of random size will fall from top of the screen with variable speed (the larger ones should be slower). Using the joystick, I can apply a wind the the snow flakes and make them move.

A video demo can be found here: https://youtu.be/Sa0R2XtviNQ

## Technincal Requirements

First, make sure you have [Processing](https://www.processing.org) and [Arduino IDE](https://www.arduino.cc) installed.

Hardware used in the project:

1. An ESP32 for the controller (and an extension board if preferrably)
2. Raspberry Pi to run the programs
3. A monitor to display visuals
4. a joystick, two buttons, a SPST switch, and a few wires

The controller has a joystick, two buttons and a SPST switch. It is made up by an ESP32 and an extension board. I made an enclosure in the video demo using cardboard boxes to hide the messy wires.

The following describes how to use the controller. There are three states in the Snow Day program:

1. Initial Menu. In the menu, the user can switch between a bright theme and a dark theme using the green button. Move the switch to right to enter the Playing state. The joystick and the yellow button will not do anything in this state.
2. Playing State. Use the joystick to apply wind to the snow. The snow will blow to the approximate direction you indicate on the joystick. Press the yellow button for heavier snow. Press the green button to pause.
3. Paused State. The snow will stop moving. The joystick and the yellow button will not do anything in this state.
Move the switch to the left to return to the main menu (state 1) at anytime.

## To Reproduce

The visual part is programmed in Processing, and there is an Arduino script to program the ESP32.

To reproduce the controller, connect the joystick, buttons and the SPST switch to the ESP32. I did it using an ESP32 extension board.

![./IMG_7302.HEIC](./ESP32.png)

To correctly configure the controller, connect the ESP32 to a computer and upload the Arduino script to the ESP32 through Arduino IDE. Make sure you modify the port name and PIN number to the specific pin you use.

Then, connect the controller to the Raspberry Pi and run the processing script on the Raspberry Pi. Modify the port number in Serial.list() to the port you use. Enjoy the snow on your sceen!
