function [correctedImage]=correctImageDrift(im_In,Drift)
% This function corrects the drift of the input image

DriftCorrx = round(mean(Drift(:,1)));
DriftCorry = round(mean(Drift(:,2)));

% add padding for shifting images
correctedImage=ones(size(im_In,1)+2*abs(DriftCorry),size(im_In,2)+...
    2*abs(DriftCorrx))*min(min(im_In));

% Shift the image according to the drift
correctedImage(abs(DriftCorry)+DriftCorry+1:abs(DriftCorry)+DriftCorry+size(im_In,1),...
    abs(DriftCorrx)+DriftCorrx+1:abs(DriftCorrx)+DriftCorrx+size(im_In,2))...
    = im_In;

% Remove the paddings to obtain the same size as the input image
correctedImage(1:abs(DriftCorry),:,:)=[];
correctedImage(size(im_In,1)+1:size(im_In,1)+abs(DriftCorry),:,:)=[];
correctedImage(:,1:abs(DriftCorrx),:)=[];
correctedImage(:,size(im_In,2)+1:size(im_In,2)+abs(DriftCorrx),:)=[];

end