%   Program to store GTA V images into 1 of 3 categories:
%   Forward - when only forward or no button is pressed
%   Right - when only right or ripght and forward are pressed
%   Left - when only left or left and forward are pressed
%   P - pauses the program
%   U - unpauses the program
%
% MATLAB version: starting with R2018b
%
% Revisions:
% -------
% 2023.02.07 - Restructuring
% 2019.04.02 - All images have been saved uniquely using datestr(now,'yyyymmddTHHMMSS')
% 2019.03.24 - Un-hard-coded paths to data. Use startup.m
% 2018.01.18 - Function creation
%
% Created by: Matt Viney / https://github.com/mattviney/GTA5-driverless-car
% Updated by: Ahmad Faisal Ayob / ahmad.faisal@umt.edu.my

%   Initialize video player to display captured frames (commented out to speed
%   up GTA)

%videoPlayer = vision.VideoPlayer('Position', [960, 300, 820, 630]);



%5 second Countdown
z=5;
while z>0
    disp(z);
    pause(1);
    z=z-1;
end

i=1;
j=1;
k=1;
stop = 0;

while(1)
    
    [direction, stop] = Key_press(stop);
    
    %If pause pressed, sit in loop until unpause pressed
    z=0;
    while stop == 1
        if z==0
            z=1;

            text_str = 'Paused';
            
            disp('*****Paused*****');
        end
        [direction, stop] = Key_press(stop);

    end
    
    frame = GrabScreen();
    frame = imcrop(frame,[0 140 800 500]); %AFA 24/3/2019

    frame = imresize(frame, [227, 227]);
    
    if direction == 'F'
        %If Forward key was pressed, store to Forward folder
        imwrite(frame, strcat(pwd,'\data\Forward\image_', datestr(now,'yyyymmddTHHMMSS'), '.jpg'));

    elseif direction == 'R'
        %If Right key was pressed, store to Right folder
        imwrite(frame, strcat(pwd,'\data\Right\image_', datestr(now,'yyyymmddTHHMMSS'), '.jpg'));

    elseif direction == 'L'
        %If Left key was pressed, store to Left folder
        imwrite(frame, strcat(pwd,'\data\Left\image_', datestr(now,'yyyymmddTHHMMSS'), '.jpg'));

    end
    
    disp(direction);
    
end

function [direction, stop] = Key_press(stop)
%Function to read the keys pressed at current frame
%from python program Key_read.py

key = char(py.Key_read.key_check());
key_size = size(key,2);
key_1 = 0;
key_2 = 0;
key_3 = 0;

%Only store 3 pressed keys
if key_size == 2
    %no buttons pressed
elseif key_size == 5
    %1 button pressed
    key_1 = key(3);
    key_2 = 0;
    key_3 = 0;
elseif key_size == 10
    %2 buttons pressed
    key_1 = key(3);
    key_2 = key(8);
    key_3 = 0;
elseif key_size == 15
    %3 buttons pressed
    key_1 = key(3);
    key_2 = key(8);
    key_3 = key(15);
end

if key_1=='A' || key_2=='A' || key_3=='A'
    %if A pressed, go left
    direction = 'L';
elseif key_1=='D' || key_2=='D' || key_3=='D'
    %if D pressed, go right
    direction = 'R';
else
    %Else go forward
    direction = 'F';
end

if key_1=='P' || key_2=='P' || key_3=='P'
    %If pause pressed, toggle pause on
    stop = 1;
elseif key_1=='U' || key_2=='U' || key_3=='U'
    %If unpause pressed, toggle pause off
    stop = 0;
end
end
