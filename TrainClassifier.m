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

%Name of three categories (folder names)
categories = {'Forward_processed', 'Right_processed', 'Left_processed'};
%Folder location of image categories
rootFolder = strcat(pwd,'\data'); 
imds = imageDatastore(fullfile(rootFolder, categories), 'LabelSource', 'foldernames');
% split to 70% for training 30% for validation
[imdsTrain,imdsValidation] = splitEachLabel(imds,0.7,'randomized');

layers = [ ...
    imageInputLayer([227 227 3])
    convolution2dLayer(11, 96, 'Stride', [4 4], 'NumChannels' , 3)
    reluLayer
    crossChannelNormalizationLayer(5, 'Alpha', 0.0001, 'Beta', 0.75, 'K', 1)
    maxPooling2dLayer(3, 'Stride', 2)
    convolution2dLayer(5, 256, 'Stride', [1 1])
    reluLayer
    crossChannelNormalizationLayer(5, 'Alpha', 0.0001, 'Beta', 0.75, 'K', 1)
    maxPooling2dLayer(3, 'Stride', 2)
    convolution2dLayer(3, 384, 'Stride', [1 1])
    reluLayer
    convolution2dLayer(3, 384, 'Stride', [1 1])
    reluLayer
    convolution2dLayer(3, 256, 'Stride', [1 1])
    reluLayer
    maxPooling2dLayer(3, 'Stride', 2)
    fullyConnectedLayer(4096)
    reluLayer
    fullyConnectedLayer(4096)
    reluLayer
    fullyConnectedLayer(3)
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
    'MiniBatchSize',64, ...
    'MaxEpochs',150, ...
    'InitialLearnRate',0.001, ...
    'Shuffle','every-epoch', ...
    'ValidationData',augimdsValidation, ...
    'ValidationFrequency',3, ...
    'Verbose',false, ...
    'Plots','training-progress');

AugSteeringNet = trainNetwork(augimdsTrain,layers,options);
save AugSteeringNet.mat



