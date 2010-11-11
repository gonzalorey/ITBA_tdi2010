function ret = applyFFT(img)
	ret.orig = img.full;
	ret.height = img.height;
	ret.width = img.width;
	ret.fft = fftshift(fft2(img.full));
	ret.real = real(ret.fft);
	ret.imag = imag(ret.fft);
	ret.module = sqrt(ret.real .^2 + ret.imag .^2);
	ret.phase = atan2(ret.imag, ret.real);
end