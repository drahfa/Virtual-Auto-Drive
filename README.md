# GTA5-driverless-car

## Readme for 2023 version

Some modification and restructuring were done from the previous codes by Matt, which is self-explanatory.
The updates will be made from time to time.

Before you start, on cmd, don't forget to install pypiwin32 and matlabengine for python
> python -m pip install pypiwin32

> python -m pip install matlabengine

Cheers, Faisal

## Readme for 2018 version
Code for training and running a CNN to drive a car in GTA5 using MATLAB

The idea came from Sentdex (https://github.com/Sentdex/pygta5) from his implementation in Python.

The code consists of 6 main files:

1 - Training_data.m - This file records the keyboard buttons being pressed and saves a screenshot of the game to a file location to create training data. The file it saves it to depends on the button pressed. ie if W is pressed, it saves the image into a file for forward direction.

2 - Key_read.py - This python script reads any keys that are currently being pressed on the keyboard. The MATLAB API for python must be installed to used Python functions within MATLAB: https://uk.mathworks.com/help/matlab/matlab-engine-for-python.html

3 - Shuffle_resize_training_data.m - This script randomises the stored images, and deletes excess ones, providing a data set of randomized images of the three categories for driving (forward, left, right).

4 - Train_classifier.m - Trains a CNN for the three image categories using the AlexNet layer structure.

5 - GTA5_control.m - This script drives the car. It grabs a screenshot of GTA5, classifies it with the CNN trained in Train_classifier.m and then presses the corresponding key to drive the car.

6 - Key_press.py - Python script to simulated pressed keyboard keys (taken from  http://stackoverflow.com/questions/14489013/simulate-python-keypresses-for-controlling-a-game)

