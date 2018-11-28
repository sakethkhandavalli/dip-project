prefix = "../data/Landsat/";
folder = dir(prefix);

%% Reading the input images
for k=3:2:length(folder)
    lrm = double(imread(char(prefix + folder(k).name)));
    hrp = double(imread(char(prefix + folder(k+1).name)));
    
    %% Show the Results with different existing methods
    subplot(1,2,1);
    imshow(uint8(lrm));
    title('LRM image');

    subplot(1,2,2);
    imshow(uint8(hrp));
    title('HRP image');
    
    figure;
    subplot(1,4,1);
    hrm = ihs_method(lrm, hrp);
    imshow(uint8(hrm));
    title('Fused HRM image using IHS Method');

    subplot(1,4,2);
    hrm = brovey_method(lrm, hrp);
    imshow(uint8(hrm));
    title('Fused HRM image using Brovey Method');
    
    subplot(1,4,3);
    hrm = dcs(lrm, hrp);
    imshow(uint8(hrm));
    title('Fused HRM image using Proposed Method');
    break;
    
end
