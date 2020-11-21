function out_img = blur_edge(in_img)
    %degradation kernel
    h = fspecial('gaussian', 60,10); 
    H = psf2otf(h,size(in_img));% compute the optical transfer functions from the given point spread functions
    blurred_img = abs(ifft2(H.*fft2(in_img))); %blurred version of the input with this optical transfer function
    wm = ones(70,70); %create a 70x70 sized array with full of ones
    wm_pad = padarray(wm,[1,1]);%pad it with one layer of zeros around itself
    wm2 = imresize(wm_pad,size(in_img),'bilinear'); %resize this array to the original size of the input_img
    wm2 = mat2gray(wm2,[0,1]);%force the elements to remain in the [0, 1] closed interval
    out_img = in_img.*wm2 + (1-wm2).*blurred_img;%weight the in_img with wm2 and weight the blurred img with 1-wm2
end
