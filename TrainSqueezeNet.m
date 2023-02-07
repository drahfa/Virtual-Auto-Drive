%   Program to train Convolutional Neural Network using SqueezeNet
%   Architecture
% 
% MATLAB version: starting with R2018b
%
% Revisions:
% -------
% 2020.01.07 - Begin writing for SqueezeNet
% 2019.03.24 - Un-hard-coded paths to data. Use startup.m
% 2018.01.18 - Function creation
% 
% Ahmad Faisal Ayob / ahmad.faisal@umt.edu.my
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
net = squeezenet();
% replace final layers| https://www.mathworks.com/help/deeplearning/examples/train-deep-learning-network-to-classify-new-images.html#TransferLearningUsingGoogLeNetExample-3
if isa(net,'SeriesNetwork') 
  lgraph = layerGraph(net.Layers); 
else
  lgraph = layerGraph(net);
end 

[learnableLayer,classLayer] = findLayersToReplace(lgraph);

numClasses = 3; % Forward_processed, Left_processed, Right_processed

if isa(learnableLayer,'nnet.cnn.layer.FullyConnectedLayer')
    newLearnableLayer = fullyConnectedLayer(numClasses, ...
        'Name','new_fc', ...
        'WeightLearnRateFactor',10, ...
        'BiasLearnRateFactor',10);
    
elseif isa(learnableLayer,'nnet.cnn.layer.Convolution2DLayer')
    newLearnableLayer = convolution2dLayer(1,numClasses, ...
        'Name','new_conv', ...
        'WeightLearnRateFactor',10, ...
        'BiasLearnRateFactor',10);
end

lgraph = replaceLayer(lgraph,learnableLayer.Name,newLearnableLayer);

newClassLayer = classificationLayer('Name','new_classoutput');
lgraph = replaceLayer(lgraph,classLayer.Name,newClassLayer);

% Freeze initial layers
layers = lgraph.Layers;
connections = lgraph.Connections;

%layers(1:10) = freezeWeights(layers(1:10));
lgraph = createLgraphUsingConnections(layers,connections);

% run Image Augmentation for Y-axis reflection
imageAugmenter = imageDataAugmenter('RandYReflection',true);
augimdsTrain = augmentedImageDatastore(layers(1).InputSize(1:2),imdsTrain, ...
    'DataAugmentation',imageAugmenter);
augimdsValidation = augmentedImageDatastore(layers(1).InputSize(1:2),imdsValidation);


options = trainingOptions('sgdm', ...
    'MiniBatchSize',16, ...
    'MaxEpochs',150, ...
    'InitialLearnRate',0.001, ...
    'Shuffle','every-epoch', ...
    'ValidationData',augimdsValidation, ...
    'ValidationFrequency',3, ...
    'Verbose',false, ...
    'Plots','training-progress');


AugSteeringSqueezeNet = trainNetwork(augimdsTrain,lgraph,options);
save AugSteeringSqueezeNet.mat



