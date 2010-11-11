function ret = filterFFT(img, mask)
	% FFT the image and the filter
	fftImage = applyFFT(img);
	fftFilter = applyFFT(resizeMask(img.height, img.width, mask));
	
	% multiply the images
	mult = fftImage.fft .* fftFilter.fft;
	
	% create the FFT multiplied image
	newImg.fft = mult;
	newImg.height = img.height;
	newImg.width = img.width;
	
	% inverse and return
	ret = applyInverseFFT(newImg);
end