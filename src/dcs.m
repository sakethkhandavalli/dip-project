function hrm = dcs(lrm,hrp)
% lrm = imread('../data/Landsat/10_MS.png');
% hrp = imread('../data/Landsat/10_PAN.png');
	%Hyper Parameters
	k = 40; % Patch size
	r = 0.6; % r percent overlap
	m = 200; % no of observations in CS
    
    %
    if(size(hrp,3) ~= 1)
        hrp = rgb2gray(hrp);
    end
    hrp = double(hrp);
    lrm = double(lrm);

	% Find the required Dictionaries
	low = abs(low_pass(hrp,70));
	high = hrp - low;
    
    subplot(2,2,1);imshow(uint8(low));
    subplot(2,2,2);imshow(uint8(high));

	no_bands = size(lrm,3);

	Dapp = get_dict(low,k,r);
	Ddet = get_dict(high,k,r);

	disp("Dapp and Ddet computed")

	% Compute matrix M
	M = zeros(no_bands*m,no_bands*k*k);
	for i = 1:no_bands
		x_idx = 1 + (i-1)*m : i*m;
		y_idx = 1 + (i-1)*k*k : i*k*k;

		M(x_idx,y_idx) = normrnd(0,1/m,[m,k*k]);
	end
	disp("M computed")

	% Compute matrix DDet
	DApp = zeros(no_bands*k*k,(no_bands+1)*size(Dapp,2));
	for i = 1:no_bands
		DApp(1+(i-1)*k*k:i*k*k,1:size(Dapp,2)) = Dapp;
		DApp(1+(i-1)*k*k:i*k*k,1+i*size(Dapp,2):(i+1)*size(Dapp,2)) = Dapp;
	end
	disp("DApp computed")

	% Compute matrix DDet
	DDet = zeros(no_bands*k*k,(no_bands+1)*size(Ddet,2));
	for i = 1:no_bands
		DDet(1+(i-1)*k*k:i*k*k,1:size(Ddet,2)) = Ddet;
		DDet(1+(i-1)*k*k:i*k*k,1+i*size(Ddet,2):(i+1)*size(Ddet,2)) = Ddet;
	end
	disp("DDet computed")

	% Upsample the LRM image to size of hrp
	lrm = upsample_lrm(lrm,hrp);
	disp("LRM upsampled")

	% Find hrm patches
	hrm = zeros(size(lrm));
	X = zeros(no_bands*k*k,1);
    tmp_cnt = 0;
	for i = 1:k:size(lrm,1)-k
%         if(tmp_cnt > 30)
%             break;
%         end
		for j = 1:k:size(lrm,2)-k
%             if(tmp_cnt > 30)
%                 break;
%             end
            tmp_cnt = tmp_cnt + 1;

			% Find X for each patch
			patch = lrm(i:i+k-1,j:j+k-1,:);
			for bnd = 1:no_bands
				tmp = patch(:,:,bnd);
				X(1+(bnd-1)*k*k:bnd*k*k,1) = tmp(:);
			end

			Y = M * X;

			% Use OMP to get the sparse coefficients
			disp("OMP started")
			alpha = OMP(M*DApp,Y);
			disp("OMP done")
% 			H = X + (DDet*alpha);
            H = X + (DDet*(alpha));
			disp("H computed")

			% Find hrm patches
			for bnd = 1:no_bands
				hrm(i:i+k-1,j:j+k-1,bnd) = reshape(H(1+(bnd-1)*k*k:bnd*k*k),[k,k]);
			end
		end
    end
    subplot(2,2,3);imshow(uint8(hrm));
    subplot(2,2,4);imshow(uint8(lrm));
    
end