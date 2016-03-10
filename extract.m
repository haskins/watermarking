% extract.m
% Extracts a watermark from the host image using LSB.
%
% Author: Josh Haskins
% Date: April 25, 2015

%% Clears the workspace and sets up parameters
clc;    % Clears the command window
clear;  % Clears all variables
fontSize = 12; % Sets font size for all figures
set(gcf, 'units','normalized','outerposition',[0 0 1 1]); % Full window

%% Bit Plane Level
% Get the bit plane to hide the image in.
bitLevel = str2double(cell2mat(inputdlg('Please enter the bit plane level you would like to replace. (1 = LSB, 8 = MSB) ', 'Enter Bit Plane to Replace', 1, {'1'})));

%% Read in watermarked image
% Read in the host image by letting the user select image
watermarkedImage = imread(uigetfile(fullfile('' , {'*.jpg;*.jpeg;*.png;*.gif;*.tif;',...
    'Images (*.jpg,*.jpeg,*.png,*.gif,*.tif)';
    '*.jpg;*.jpeg',  'JPEG'; ...
    '*.png','PNG'; ...
    '*.gif','GIF'; ...
    '*.tif','TIF'; ...
    '*.*',  'All Files (*.*)'}), 'Select host image'));

% Get the number of rows and columns of the watermarked image.
[hostRows, hostCols, ~] = size(watermarkedImage);

%% Watermark Recovery
% Use the known bit plane of watermarked image to recover the watermark.
recoveredWatermark = zeros(size(watermarkedImage));
for col = 1:hostCols
    for row = 1:hostRows
        recoveredWatermark(row, col) = bitget(watermarkedImage(row, col), bitLevel);
    end
end

% Display the recovered watermark.
subplot(1, 1, 1);
imshow(uint8(255 * recoveredWatermark), []);
title(sprintf('Watermark Recovered'), 'FontSize', fontSize);
imwrite(uint8(255 * recoveredWatermark), 'recovered.jpg');