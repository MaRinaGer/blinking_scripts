function [drift] = getDrift_stack(imCropped,correlationInfo)

maxDrift = correlationInfo.maxDrift;
driftPeriod = correlationInfo.driftPeriod;
%scalingFactor = correlationInfo.scalingFactor;

% Select reference image for drift correction
mid=round(size(imCropped,3)/2);
%img0 = imresize(mean(imCropped(:,:,mid:mid+driftPeriod),3),scalingFactor);
img0 = mean(imCropped(:,:,mid:mid+driftPeriod),3);

%waitbar.multiWaitbar('Detecting drift',0);

figure

% Loop through movie for drift correction
for i=1:floor(size(imCropped,3)/driftPeriod)
    
    % Image that enters correlation matrix
    %img1 = imresize(mean(imCropped(:,:,(i-1)*driftPeriod+1:i*driftPeriod),3),scalingFactor);
    img1 = mean(imCropped(:,:,(i-1)*driftPeriod+1:i*driftPeriod),3);
    
    % Calculate drift
    [driftxy,corrMat_center] = drift_corr.getDrift(img0,img1,correlationInfo);
    
    % Get drift from fitting parameters
    drift((i-1)*driftPeriod+1:i*driftPeriod,1)=driftxy(1);
    drift((i-1)*driftPeriod+1:i*driftPeriod,2)=driftxy(2);    
    
    % Output data
    pause(0.1)
    imagesc(corrMat_center)
    hold on  
    plot(... % drift(1:i*driftPeriod,1)+maxDrift*scalingFactor+1,drift(1:i*driftPeriod,2)+maxDrift*scalingFactor+1,'x')
        drift(1:i*driftPeriod,1)+maxDrift+1,...
        drift(1:i*driftPeriod,2)+maxDrift+1,'x')

    hold off
    %waitbar.multiWaitbar('Detecting drift',i/(floor(size(imCropped,3)/driftPeriod)));
end

%waitbar.multiWaitbar('Detecting drift','Close');

end