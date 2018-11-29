function res = get_score(lrm,hrp)
	% lrm = imread('../data/Landsat/10_MS.png');
	% lrm = imresize(lrm,[size(lrm,1),size(lrm,2)]./2);
	% hrp = imread('../data/Landsat/10_PAN.png');


	l = double(imresize(lrm,[size(lrm,1),size(lrm,2)]./2));
	p = double(imresize(hrp,[size(hrp,1),size(hrp,2)]./2));

	h = dcs(l,p);
	h1 = h(1:0.8*end,1:0.8*end,:);
	lrm1 = lrm(1:0.8*end,1:0.8*end,:);
	disp(["DCS","SAM",SAM(double(h1),double(lrm1))]);
	disp(["DCS","ERGAS",ERGAS(double(h1),double(lrm1),0.1)]);
	disp(["DCS","RMSE",RMSE(double(h1),double(lrm1))]);

	h = ihs_method(l,p);
	disp(["IHS","SAM",SAM(double(h),double(lrm))]);
	disp(["IHS","ERGAS",ERGAS(double(h),double(lrm),0.1)]);
	disp(["IHS","RMSE",RMSE(double(h),double(lrm))]);

	h = brovey_method(l,p);
	disp(["BROVEY","SAM",SAM(double(h),double(lrm))]);
	disp(["BROVEY","ERGAS",ERGAS(double(h),double(lrm),0.1)]);
	disp(["BROVEY","RMSE",RMSE(double(h),double(lrm))]);
end