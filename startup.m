% Housekeeping Program to Create Storage Folder
% 
% MATLAB version: starting with R2018b
%
% Revisions:
% -------
% 2019.03.24 - Function creation
% 
% Created by: Ahmad Faisal Ayob / ahmad.faisal@umt.edu.my

if ~exist('data', 'dir')
    mkdir('data')
    cd data
 
    mkdir('Forward')
    mkdir('Left')
    mkdir('Right')
    
    mkdir('Forward_processed')
    mkdir('Left_processed')
    mkdir('Right_processed')
    cd ..
end
addpath('actions')
addpath('helpers')
addpath('data')
