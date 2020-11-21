function [x_tilde] = restoration_wiener(y, h, n)
    % move everything to the frequency domain 
    Y = fft2(y); 
    N = fft2(n);
    H = psf2otf(h, size(Y)); % compute the optical transfer functions from the given point spread functions
    %compute two additional values, the power spectra
    P_XX = Y .* conj(Y);
    P_NN = N .* conj(N); 
    H_conj = conj(H);  
    %implement the formula for the R restoration matrix 
    R = H_conj./(abs(H).^2 + (P_NN./P_XX));
    %transform back the result to the spatial domain
    x_tilde = abs(ifft2(R.*Y));
end
