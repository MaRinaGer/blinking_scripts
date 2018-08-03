function [driftxy,corrMat_center] = getDrift(img0,img1,correlationInfo)

% Function to measure the shift between two images. The function computes
% the correlation matrix of the two input images and then fits the center
% area with a 2D gaussian to determine the maximum position.

% Last modified by Marina, 02.08.2018

maxDrift=correlationInfo.maxDrift;
scalingFactor=correlationInfo.scalingFactor;

% Calculate correlation matrix
corrMatrix = (normxcorr2(img0, img1));
corrMatrix(corrMatrix==0) = -inf;

% Fit center of the correlation matrix with a 2D gaussian to find maximum
corrMat_center=corrMatrix(...
    ceil(size(corrMatrix,1)/2)-maxDrift*scalingFactor:...
    ceil(size(corrMatrix,1)/2)+maxDrift*scalingFactor,...
    ceil(size(corrMatrix,2)/2)-maxDrift*scalingFactor:...
    ceil(size(corrMatrix,2)/2)+maxDrift*scalingFactor);

gpar=gauss2Dfit.gaussFit2(corrMat_center,1);

driftxy=[gpar(5) gpar(6)];

end