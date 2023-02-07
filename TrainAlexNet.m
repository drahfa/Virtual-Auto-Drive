%   Program to train Convolutional Neural Network using AlexNet
%   Architecture
% 
% MATLAB version: starting with R2018b
%
% Revisions:
% -------
% 2019.03.24 - Un-hard-coded paths to data. Use startup.m
% 2018.01.18 - Function creation
% 
% Created by: Matt Viney / https://github.com/mattviney/GTA5-driverless-car
% Updated by: Ahmad Faisal Ayob / ahmad.faisal@umt.edu.my
clear all;
clc;

%Name of three categories (folder names)
categories = {'Forward_processed', 'Right_processed', 'Left_processed'};
%Folder location of image categories
rootFolder = strcat(pwd,'\data'); 
imds = imageDatastore(fullfile(rootFolder, categories), 'LabelSource', 'foldernames');
% split to 70% for training 30% for validation
[imdsTrain,imdsValidation] = splitEachLabel(imds,0.7,'randomized');

% try using transfer learning
net = alexnet;
% replace final layers
layersTransfer = net.Layers(1:end-3);
numClasses = 3;

layers = [
    layersTransfer
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20,'BiasLearnRateFactor',20)
    softmaxLayer
    classificationLayer];

% run Image Augmentation for Y-axis reflection
imageAugmenter = imageDataAugmenter('RandYReflection',true);
augimdsTrain = augmentedImageDatastore(layers(1).InputSize(1:2),imdsTrain, ...
    'DataAugmentation',imageAugmenter);
augimdsValidation = augmentedImageDatastore(layers(1).InputSize(1:2),imdsValidation);

% 
% options = trainingOptions('sgdm','InitialLearnRate',0.001, ...
%     'MaxEpochs',100, 'Plots','training-progress');

options = trainingOptions('sgdm', ...
    'MiniBatchSize',128, ...
    'MaxEpochs',150, ...
    'InitialLearnRate',0.001, ...
    'ValidationData',augimdsValidation, ...
    'ValidationFrequency',3, ...
    'Verbose',true, ...
    'Plots','training-progress');


AugSteeringAlexNet = trainNetwork(augimdsTrain,layers,options);
save AugSteeringAlexNet.mat



