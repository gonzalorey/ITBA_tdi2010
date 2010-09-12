function ret = getGrayHistogram(A)

ret = zeros(1,256);

	for i=1:size(A,1) 
    	for j=1:size(A,2)        
        	ret(1,A(i,j) + 1) = ret(1,A(i,j) + 1) + 1;        
    	end    
	end

end
