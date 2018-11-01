function [ value ] = ERGAS( E, R, ratio )
	[m, n, d] = size(E);

	summed = 0;

	for k = 1 : d
		tval = RMSE(E(:,:,k), R(:,:,k))^2 / mean(reshape(R(:,:,k), m*n, 1))
	    summed = summed + tval;
	end

	value = 100 * ratio * sqrt( 1/d * summed );
end
