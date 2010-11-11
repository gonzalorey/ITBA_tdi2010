function ret = swapPhases(img1, img2)
	
	% apply the FFT
	fftImage1 = applyFFT(img1);
	fftImage2 = applyFFT(img2);
	
	% z = module(cos(phase) + i sin(phase))
	z1 = fftImage1.module .* (cos(fftImage2.phase) + sin(fftImage2.phase) .* i);
	z2 = fftImage2.module .* (cos(fftImage1.phase) + sin(fftImage1.phase) .* i);
	
	% swap the phases
	fftImage1.fft = z1;
	fftImage2.fft = z2;
		
	% inverse FFT
	ret.img1 = applyInverseFFT(fftImage1);
	ret.img2 = applyInverseFFT(fftImage2);
end