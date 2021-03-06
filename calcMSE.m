% calcMSE.m
% Calculates the MSE between two images
%
% Author: Josh Haskins
% Date: April 25, 2015

error = double(imread(uigetfile(fullfile('' , {'*.jpg;*.jpeg;*.png;*.gif;*.tif;',...
    'Images (*.jpg,*.jpeg,*.png,*.gif,*.tif)';
    '*.jpg;*.jpeg',  'JPEG'; ...
    '*.png','PNG'; ...
    '*.gif','GIF'; ...
    '*.tif','TIF'; ...
    '*.*',  'All Files (*.*)'}), 'Select reference image'))) - double(imread(uigetfile(fullfile('' , {'*.jpg;*.jpeg;*.png;*.gif;*.tif;',...
    'Images (*.jpg,*.jpeg,*.png,*.gif,*.tif)';
    '*.jpg;*.jpeg',  'JPEG'; ...
    '*.png','PNG'; ...
    '*.gif','GIF'; ...
    '*.tif','TIF'; ...
    '*.*',  'All Files (*.*)'}), 'Select target image')));
[M, N] = size(error);
fprintf('\n The MSE value is %0.4f \n', sum(sum(error .* error)) / (M * N));

