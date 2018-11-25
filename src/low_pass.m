function filtered_hrp = low_pass(hrp)
	 
	% compute FFT of the grey image
	A = fft2(double(hrp));
	A1 = fftshift(A);

	% Gaussian Filter Response Calculation
	% It has three parameters : Two means mu_x,mu_y and the standard deviation sd

	[M,N] = size(A);
	sd = 90;
	X = 0:N-1;
	Y = 0:M-1;
	[X,Y] = meshgrid(X,Y);
	mu_x = 0.5*N;
	mu_y = 0.5*M;
	filter = exp(-(((X-mu_x).^2+(Y-mu_y).^2))./(2*((sd).^2)));
	
	out = A1.*filter;
	out=ifftshift(out);
	filtered_hrp = ifft2(out);

end