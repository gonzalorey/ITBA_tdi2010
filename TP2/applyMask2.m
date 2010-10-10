function ret = applyMask2(A, mask)
    
	% initialize the answer to improve performance
    ret(size(A,1),size(A,2)) = 0;

	% initialize the auxA matrix with the correction of the borders
	auxA = ones(size(A,1) + size(mask,1) - 1, size(A,2) + size(mask,2) - 1) * 128;
	auxA(1:size(A,1), 1:size(A,2)) = A;
	
	auxA = A;
	for i = size(A,1) + 1 : size(A,1) + size(mask,1)
		auxA(1:i) = aux(1:i-1,:)
	end

	for i = 1 : size(A,1)
		for j = 1 : size(A,2)
			
			% get the submatrix to apply the mask to 
			subA = auxA(i:i + size(mask,1) - 1,j:j + size(mask,2) - 1);
			ret(i,j) = sum(sum(double(subA) .* mask));
		end
	end
	
	ret = uint8(ret);
end