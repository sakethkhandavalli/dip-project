function [ sharpened ] = ihs_method(lrm, pan)
	
	% Upsample the LRM image
	lrm = double(upsample_lrm(lrm,pan));
	
	% Transform into IHS model
	hsi = rgb2hsv(lrm);

	% Use Pan image to replace the Intensity component
	pan = double(pan)/255.0;
	hsi(:,:,3) = pan;

	% Transform back into RGB model
	sharpened = hsv2rgb(hsi);
	sharpened = uint8(sharpened*255.0);
end