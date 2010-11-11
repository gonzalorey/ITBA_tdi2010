function ret = filterFFT2(img, mask)
	% FFT the image and the filter
	fftImage = applyFFT(resizeMask(img.height + size(mask,1) - 1, img.width + size(mask,2) - 1, img.full));
	fftFilter = applyFFT(resizeMask(img.height + size(mask,1) - 1, img.width + size(mask,2) - 1, mask));
	
	% multiply the images
	mult = fftImage.fft .* fftFilter.fft;
	
	% create the FFT multiplied image
	newImg.fft = mult;
	newImg.height = img.height;
	newImg.width = img.width;
	
	% inverse and return
	ret = applyInverseFFT(newImg);
end