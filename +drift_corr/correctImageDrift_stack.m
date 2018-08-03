function [correctedStack] = correctImageDrift_stack(im_In,drift,correlationInfo)

scalingFactor = correlationInfo.scalingFactor;

%waitbar.multiWaitbar('Correcting stack of images',0);

correctedStack=zeros(size(im_In,1),size(im_In,2),size(im_In,3));

for i=1:size(im_In,3)
    data_In = imresize(im_In(:,:,i),scalingFactor);
    Drift_In = drift(i,:);
    img_corr = drift_corr.correctImageDrift(data_In,-round(Drift_In*scalingFactor));
    correctedStack(:,:,i) = imresize(img_corr,1/scalingFactor);
    %waitbar.multiWaitbar('Correcting stack of images',i/size(im_In,3));
end

%waitbar.multiWaitbar('Correcting stack of images','Close');

end