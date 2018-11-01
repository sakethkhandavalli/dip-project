%% Reading the input images
hrp = double(imread('../data/HRP.jpg'));
lrm = double(imread('../data/LRM.jpg'));

%% Show the Results with different existing methods
subplot(1,4,1);
imshow(uint8(lrm));
title('LRM image');

subplot(1,4,2);
imshow(uint8(hrp));
title('HRP image');

subplot(1,4,3);
hrm = ihs_method(lrm, hrp);
imshow(hrm);
title('Fused HRM image using IHS Method');

subplot(1,4,4);
hrm = brovey_method(lrm, hrp);
imshow(hrm);
title('Fused HRM image using Brovey Method');

