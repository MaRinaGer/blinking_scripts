% im_In is your stack of images
% correlation info are the parameters for drift correction

im_In=temp;

% Parameters for drift correction
correlationInfo.maxDrift = 5;      % Maximum drift in px
correlationInfo.driftPeriod = 10;    % Number of frames that are averaged
correlationInfo.scalingFactor = 5;  % Accuracy (value above 1 for sub-px accuracy)

[correctedStack,drift]=drift_corr.correlationDrift(im_In,correlationInfo);