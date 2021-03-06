% compare.m
% Compares two images to see if they are the same
%
% Author: Josh Haskins
% Date: April 25, 2015

if imread(uigetfile(fullfile('' , {'*.jpg;*.jpeg;*.png;*.gif;*.tif;',...
    'Images (*.jpg,*.jpeg,*.png,*.gif,*.tif)';
    '*.jpg;*.jpeg',  'JPEG'; ...
    '*.png','PNG'; ...
    '*.gif','GIF'; ...
    '*.tif','TIF'; ...
    '*.*',  'All Files (*.*)'}), 'Select original watermark image')) == imread(uigetfile(fullfile('' , {'*.jpg;*.jpeg;*.png;*.gif;*.tif;',...
    'Images (*.jpg,*.jpeg,*.png,*.gif,*.tif)';
    '*.jpg;*.jpeg',  'JPEG'; ...
    '*.png','PNG'; ...
    '*.gif','GIF'; ...
    '*.tif','TIF'; ...
    '*.*',  'All Files (*.*)'}), 'Select recovered watermark image'))
    fprintf('They are the same')
else
    fprintf('They are NOT the same')
end