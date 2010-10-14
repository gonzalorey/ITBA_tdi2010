function ret = getRGBasRAW(filename, matrix)
	aux = imread(filename);
	
	% get the corresponding matrix
	if (matrix == 'R')
		ret.full = aux(:,:,1);
	end
	if (matrix == 'G')
		ret.full = aux(:,:,2);
	end
	if (matrix == 'B')
		ret.full = aux(:,:,3);
	end

	ret.height = size(ret.full, 1);
	ret.width = size(ret.full, 2);	
	
end