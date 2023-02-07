function DestroyAndCreate
% Housekeeping Program to Delete all data and Create Storage Folder
% 
% MATLAB version: starting with R2018b
%
% Revisions:
% -------
% 2019.03.24 - Function creation
% 
% Created by: Ahmad Faisal Ayob / ahmad.faisal@umt.edu.my

% Delete all data folders
[status, message, messageid] = rmdir('data', 's');
% Recreate data folders
startup;
end