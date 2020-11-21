function [x_tilde] = restoration_CLS(y, h, alpha, c)
    Y = fft2(y); %move everything to the frequency domain
    %compute the optical transfer functions from the given point spread functions
    H = psf2otf(h, size(Y));
    C = psf2otf(c, size(Y));
    [m, n] = size(Y);
    H_conj = conj(H);
    %implement the formula for the R restoration matrix
    for w1 = 1:m
        for w2 = 1:n
            R(w1,w2) = H_conj(w1,w2) / (abs(H(w1,w2))^2 + alpha*abs(C(w1,w2))^2);
        end
    end
    %transform back the result to the spatial domain
    x_tilde = abs(ifft2(R.*Y));
end
