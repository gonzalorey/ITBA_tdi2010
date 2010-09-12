function ret = equalize(A)
	
	% get the gray histogram between [0,255]
	hist = getGrayHist(A);

	% calculate de cdf for every value of the hist array	
	cdf = cumsum(hist);
	
	% normalize the cdf array
	newHist = cast((cdf - min(cdf)) / (length(A(:,1)) * length(A(1,:)) - min(cdf)) * 255, 'uint8');

	% map the image with the new hist
	for i = 1 : length(A(:,1))
		for j = 1 : length(A(1,:))
			ret(i,j) = newHist(A(i,j) + 1);
		end
	end

end