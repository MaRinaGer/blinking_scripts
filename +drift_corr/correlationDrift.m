function [correctedStack,drift]=correlationDrift(im_In,correlationInfo)

% Last modified by Marina, 02.08.2018

% This function outputs the sample drift and a stack of images corrected by
% this drift.

% Function input:
% Im_In: Stack of images to correct
% correlationInfo: Set of parameters for Drift correction

maxDrift = correlationInfo.maxDrift;
driftPeriod = correlationInfo.driftPeriod;
scalingFactor = correlationInfo.scalingFactor;

% Localization of the area of interest
threshold=0.1;
rp=4;
r=10;
closeness=1;
[x,y,bg] = localize.localize(mean(im_In,3),threshold,rp,r,closeness);
lb=[min(y)-r min(x)-r];
ub=[max(y)+r max(x)+r];
imCropped = im_In(lb(1): ub(1),lb(2):ub(2),:);

% Get drift for the stack of images (unit is subpixel)
[drift] = drift_corr.getDrift_stack(imCropped,correlationInfo);

% Correct stack of images
[correctedStack] = drift_corr.correctImageDrift_stack(im_In,drift,correlationInfo);

figure
subplot(2,1,1)
plot(drift(:,1))
xlabel('frame-no.')
ylabel('drift (px)')
title('x-drift')
subplot(2,1,2)
plot(drift(:,2))
xlabel('frame-no.')
ylabel('drift (px)')
title('y-drift')
pause(2)
close all

end