function [y, h, n] = degradation(x)
    [a, b] = size(x);  %Size of the input image
    y = zeros(a,b);  
    %degradation kernel
    h = fspecial('motion', 42, 30);
    %white noise
    n = randn(a,b) * sqrt(0.001);
    %apply the kernel to the input
    y_inter = imfilter(x, h, 'replicate', 'same', 'conv');
    %add noise
    y = y_inter + n; 
end
