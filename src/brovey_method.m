function [ sharpened ] = brovey_method( lrm, pan )

	% Upsample the LRM image
	lrm = double(upsample_lrm(lrm,pan));

	% Initialize the output image
	[~, ~, d_im] = size(lrm);
	sharpened = zeros(size(lrm));

	% Update each band in the HRM image
	for k = 1 : d_im
	   sharpened(:,:,k) = d_im * ((pan .* lrm(:,:,k) ) ./ double(sum(lrm, 3)));
    end
    
    sharpened = uint8(sharpened);
end