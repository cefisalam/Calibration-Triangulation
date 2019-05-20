function cameraParams = calibration(imageFileNames,squareSize)
%% CALIBRATION function to perform Calibration of a Camera given Checkerboard Images taken at different orientations.

%   Input
%       imageFileNames - Checkerboard Images taken at different orientations
%       squareSize     - Checkerboard Size (in millimeters)
%
%   Output
%       cameraParams   - A structure containing all Calibration Parameters

%% Function starts here

% Detect Checkerboards in Images
[imagePoints, boardSize, imagesUsed] = detectCheckerboardPoints(imageFileNames);
imageFileNames = imageFileNames(imagesUsed);

% Read the First Image to obtain Image Size
originalImage = imread(imageFileNames{1});
[mrows, ncols, ~] = size(originalImage);

% Generate World Coordinates of the Corners of the Squares
worldPoints = generateCheckerboardPoints(boardSize, squareSize);

% Calibrate the Camera
[cameraParams, ~, ~] = estimateCameraParameters(imagePoints, worldPoints, ...
    'EstimateSkew', false, 'EstimateTangentialDistortion', false, ...
    'NumRadialDistortionCoefficients', 2, 'WorldUnits', 'millimeters', ...
    'InitialIntrinsicMatrix', [], 'InitialRadialDistortion', [], ...
    'ImageSize', [mrows, ncols]);

% Visualize Pattern Locations
figure,
showExtrinsics(cameraParams, 'CameraCentric');

end