function ret = getMultiplication( A , const )

	ret = A * const;
   
	% normalize
	ret = ret .* (255 / max(ret));
	ret = cast(ret, 'uint8');
end
