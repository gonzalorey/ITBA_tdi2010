function ret = medianFilter(img, num)

	% the return value type is the same as the entry image type
	ret = img;

	% process for RGB or RAW image
	if(length(size(ret.full)) == 3)
		ret.R = medianMask(ret.R, num);
		ret.G = medianMask(ret.G, num);
		ret.B = medianMask(ret.B, num);
		ret.full = ret.R;
		ret.full(:,:,2) = ret.G;
		ret.full(:,:,3) = ret.B;
	else
		ret.full = medianMask(ret.full, num);
	end
end

function ret = medianMask(A, num)
	
	% initialize the answer to improve performance
    ret(size(A,1),size(A,2)) = 0;

	% initialize the auxA matrix with the correction of the borders
	auxA = ones(size(A,1) + num - 1, size(A,2) + num - 1) * 128;
	auxA(1:size(A,1), 1:size(A,2)) = A;
	
	for i = 1 : size(A,1)
		for j = 1 : size(A,2)
			
			% get the submatrix to get the median from
			subA = auxA(i:i + num - 1,j:j + num - 1);
			ret(i,j) = median(reshape(subA,num * num, 1));
		end
	end
	
	% cast
	ret = uint8(ret);
end