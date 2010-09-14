function ret = imageSum( A , B )

	% sum the matrixes
	ret = double(A) + double(B);
	
	% cast to double so that it can be multiplied
	ret = cast(ret, 'double');

	% normalize
	ret = ret .* (255 / max(max(ret)));	
	ret = cast(ret, 'uint8');
    
end

