%function RunAutoDrive
% Program to control a car in Grand Theft Auto V (GTA V)
% Keys used:
%   P: Pause MATLAB run
%   U: Unpause MATLAB run
% 
% MATLAB version: starting with R2018b
%
% Revisions:
% -------
% 2019.03.24 - Added imcrop target
% 2018.01.18 - Function creation
% 
% Created by: Matt Viney / https://github.com/mattviney/GTA5-driverless-car
% Updated by: Ahmad Faisal Ayob / ahmad.faisal@umt.edu.my

%Load trained model
%p = load('SteeringNet.mat');
%AutoDriveNet = p.AutoDriveNet;

%j = load ('SteeringNetWeights.mat');
%AutoDriveNet = j.AutoDriveNet;
load('AugSteeringAlexNet.mat')
AutoDriveNet = AugSteeringAlexNet;

%Countdown
z=5;
while z>0
   disp(z);
   pause(1); 
   z=z-1;
end

W = 17;
A = 30;
S = 31;
D = 32;
stop = 0;



while(1)
    Press_Key(W);
    z=0;
    [direction, stop] = Key_read(stop);
    
    %If P pressed
    while stop == 1
        
        if z==0
            z=1;     
            disp('******Paused******');
            Release_Key(D);
            Release_Key(A);
            Release_Key(W);
        end
        [direction, stop] = Key_read(stop);
    end
    
    frame = GrabScreen();
    %frame = imcrop(frame,[0 180 800 300]); %car
    frame = imcrop(frame,[0 140 800 500]); %bus
    frame = imresize(frame, [227, 227]);
    
    %Classify frame
    [out, scores] = classify(AutoDriveNet, frame);
    disp(out)
    if scores(2) > 0.6
        disp('Left');
        Press_Key(A);
        pause(0.015);
        Release_Key(A);
    elseif scores(3) > 0.6
        disp('Right');
        Press_Key(D);
        pause(0.015);
        Release_Key(D);
    end
end

function [direction, stop] = Key_read(stop)
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

function [] = Press_Key(key)
%Press a key
py.Key_press.PressKey(uint64(key));
end

function [] = Release_Key(key)
%Release a key
py.Key_press.ReleaseKey(uint64(key));
end
%end

