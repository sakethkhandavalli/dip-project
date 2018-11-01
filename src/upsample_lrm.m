function [ upsampled ] = upsample_lrm(lrm,pan)
    % Using imresize for now. Replace this with more robust approach
	upsampled = imresize(lrm,size(pan));
end