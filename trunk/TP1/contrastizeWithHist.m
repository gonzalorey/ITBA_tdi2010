function ret = contrastizeWithHist(A)

	% get the gray histogram for values [0,255]
	hist = getGrayHist(A);

	% contrastize with the mean value
	ret = contrastize2(A, mean(hist), mean(hist));
		
end

