% embed.m
% Embeds a watermark into a host image using LSB.
%
% Author: Josh Haskins
% Date: April 25, 2015

%% Clears the workspace and sets up parameters
clc;    % Clears the command window
clear;  % Clears all variables
fontSize = 12; % Sets font size for all figures
plotCol = 2;
plotRow = 3;
binaryImageThresholdValue = 75; % Binary image threshold
set(gcf, 'units','normalized','outerposition',[0 0 1 1]); % Full window

%% Bit Plane
% Get the bit plane the user sets to hide the image in.
bitLevel = str2double(cell2mat(inputdlg('Please enter the bit plane level you would like to replace. (1 = LSB, 8 = MSB) ', 'Enter Bit Plane to Replace', 1, {'1'})));

%% Host Image
%Read in the host image by letting the user select image.
hostImage = imread(uigetfile(fullfile('' , {'*.jpg;*.jpeg;*.png;*.gif;*.tif;',...
    'Images (*.jpg,*.jpeg,*.png,*.gif,*.tif)';
    '*.jpg;*.jpeg',  'JPEG'; ...
    '*.png','PNG'; ...
    '*.gif','GIF'; ...
    '*.tif','TIF'; ...
    '*.*',  'All Files (*.*)'}), 'Select host image'));

% Get the number of rows, columns, and colours in the host image.
[hostRows, hostCols, colourChannels] = size(hostImage);

% If host image is in colour, convert to grayscale.
if colourChannels == 3
    hostImage = rgb2gray(hostImage);
end

% Display the host image.
subplot(plotRow, plotCol, 1);
imshow(hostImage, []);
title('Host Image', 'FontSize', fontSize);

%% Watermark
% Read in the watermark image by letting user select image
watermark = imread(uigetfile(fullfile('' , {'*.jpg;*.jpeg;*.png;*.gif;*.tif;',...
    'Images (*.jpg,*.jpeg,*.png,*.gif,*.tif)';
    '*.jpg;*.jpeg',  'JPEG'; ...
    '*.png','PNG'; ...
    '*.gif','GIF'; ...
    '*.tif','TIF'; ...
    '*.*',  'All Files (*.*)'}), 'Select watermark image'));

% Get the number of rows, columns, and colour channels in the watermark.
[watermarkRows, watermarkCols, colourChannels] = size(watermark);

% If watermark is in colour, convert to grayscale.
if colourChannels == 3
    watermark = rgb2gray(watermark);
end

% Display the watermark.
subplot(plotRow, plotCol, 2);
imshow(watermark, []);
title('Watermark', 'FontSize', fontSize);

%% Binary Watermark
% Ensure watermark is below threshold.
binaryWatermark = watermark < binaryImageThresholdValue;

% Display binary watermark.
subplot(plotRow, plotCol, 3);
imshow(binaryWatermark, []);
title(sprintf('Binary Watermark'), 'FontSize', fontSize);

%% Watermark Scaling
% If watermark is larger than host image, scale the watermark down in size.
if watermarkRows > hostRows || watermarkCols > hostCols
    binaryWatermark = imresize(binaryWatermark, min([hostRows / watermarkRows, hostCols / watermarkCols]));
    [watermarkRows, watermarkCols] = size(binaryWatermark);
end

% If watermark is smaller than host image, tile the watermark.
if watermarkRows < hostRows || watermarkCols < hostCols
    watermark = zeros(size(hostImage), 'uint8');
    for col = 1:hostCols
        for row = 1:hostRows
            watermark(row, col) = binaryWatermark(mod(row,watermarkRows)+1, mod(col,watermarkCols)+1);
        end
    end
    watermark = watermark(1:hostRows, 1:hostCols);
else
    % Watermark and host image are the same size.
    watermark = binaryWatermark;
end

% Display the thresholded binary image.
subplot(plotRow, plotCol, 4);
imshow(watermark, []);
title(sprintf('Thresholded Binary Watermark'), 'FontSize', fontSize);
imwrite(uint8(255 * watermark), 'watermark.jpg');

%% Combine the host image and watermark together.
watermarkedImage = hostImage; 
for col = 1 : hostCols
    for row = 1 : hostRows
        watermarkedImage(row, col) = bitset(hostImage(row, col), bitLevel, watermark(row, col));
    end
end

% Display the combined image.
subplot(plotRow, plotCol, 5);
imshow(watermarkedImage, []);
title(sprintf('Watermarked Image'), 'FontSize', fontSize);
imwrite(watermarkedImage,'watermarked.png');
