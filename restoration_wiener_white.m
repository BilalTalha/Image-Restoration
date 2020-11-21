function [x_tilde] = restoration_wiener_white(y, h, var_n)
    % move everything to the frequency domain
    Y = fft2(y);  
    H = psf2otf(h, size(Y)); % compute the optical transfer functions from the given point spread functions
    var_x = var(y(:)); %variance of the signal
    NSPR = var_n./var_x; %noise to signal power ratio
    H_conj = conj(H);
    %implement the formula for the R restoration matrix 
    R = H_conj./(abs(H).^2 + NSPR);
    %transform back the result to the spatial domain
    x_tilde = abs(ifft2(R.*Y));
end
