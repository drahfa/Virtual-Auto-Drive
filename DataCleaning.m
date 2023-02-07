function DataCleaning
%   Program to find the number of images in each category, and deletes the extra
%   ones from the remaining 2 categories to give three randomized equally
%   sized data sets in the folders Forward_processed, left_processed,
%   right_processed.
%
%   Note:   Augmenting training images helps to prevent the network from 
%           overfitting and memorizing the exact details of the training images.
% 
% MATLAB version: starting with R2018b
%
% Revisions:
% -------
% Todo: Properly augment the data based on the histograms
% 2019.03.24 - Un-hard-coded paths to saving data. Use startup.m
% 2018.01.18 - Function creation
% 
% Created by: Ahmad Faisal Ayob / ahmad.faisal@umt.edu.my

%Number of images in Forward file
Forward=dir([strcat(pwd,'\data\Forward') '/*.jpg']);
Forward_size=size(Forward,1);

%Number of images in Left file
Left=dir([strcat(pwd,'\data\Left') '/*.jpg']);
Left_size=size(Left,1);

%Number of images in Right file
Right=dir([strcat(pwd,'\data\Right') '/*.jpg']);
Right_size=size(Right,1);

%Find which category has the minimum number of images
min_images_number = min([Forward_size, Left_size, Right_size]);

% Taken from: https://www.mathworks.com/matlabcentral/answers/330208-random-extraction-of-files-from-a-folder
% Processing Forward Images Data
Dest     = strcat(pwd,'\data\Forward_processed');
FileList = dir([strcat(pwd,'\data\Forward') '/*.jpg']);
index    = randperm(numel(FileList), min_images_number);
for k = 1:min_images_number
  Source = fullfile(strcat(pwd,'\data\Forward'), FileList(index(k)).name);
  copyfile(Source, Dest);
end

% Processing Left Images Data
Dest     = strcat(pwd,'\data\Left_processed');
FileList = dir([strcat(pwd,'\data\Left') '/*.jpg']);
index    = randperm(numel(FileList), min_images_number);
for k = 1:min_images_number
  Source = fullfile(strcat(pwd,'\data\Left'), FileList(index(k)).name);
  copyfile(Source, Dest);
end

% Processing Forward Images Data
Dest     = strcat(pwd,'\data\Right_processed');
FileList = dir([strcat(pwd,'\data\Right') '/*.jpg']);
index    = randperm(numel(FileList), min_images_number);
for k = 1:min_images_number
  Source = fullfile(strcat(pwd,'\data\Right'), FileList(index(k)).name);
  copyfile(Source, Dest);
end


end
