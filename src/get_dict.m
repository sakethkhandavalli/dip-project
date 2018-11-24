function dict = get_dict(img,k,r)

	[h,w] = size(img);
	idx = 1;

	for i = 1:k-floor(k*r):h-k
		for j = 1:k-floor(k*r):w-k
			patch = img(i:i+k-1,j:j+k-1);
            dict(:,idx) = patch(:) - mean(patch(:));
			idx = idx + 1;
		end
    end
    
end