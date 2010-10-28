function ret = applyInverseFFT(img)
	ret.orig = img.fft;
	ret.height = img.height;
	ret.width = img.width;
	ret.ifft = uint8(ifft2(ifftshift(ret.orig)));
end