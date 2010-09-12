function ret = getContrastized2(A, r1, r2)
	
	ret = A;

	for i=1:size(ret,1)
    	for j=1:size(ret,2)
        	if (ret(i,j) <= r1)
            	ret(i,j) = ret(i,j) / 4;
        	else if (ret(i,j) >= r2)
            	ret(i,j) = ret(i,j) * (3 / 4) + 63.75;
        	end
    	end
	end
		
end

