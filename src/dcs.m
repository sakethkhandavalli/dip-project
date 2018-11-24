function hrm = dcs(lrm,hrp)
	k = 40;
	r = 0.6;
	m = 200;
    
    hrp = double(hrp);
    lrm = double(lrm);

	low = abs(low_pass(hrp,70));
	high = hrp - low;
    
    subplot(2,2,1);imshow(uint8(low));
    subplot(2,2,2);imshow(uint8(high));

	no_bands = size(lrm,3);

	Dapp = get_dict(low,k,r);
	Ddet = get_dict(high,k,r);

	disp("Dapp and Ddet computed")    
end