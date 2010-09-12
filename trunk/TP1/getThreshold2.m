function ret = getThreshold(image, threshold)
	
	ret = image.full;

	for i=1:size(ret,1)
    	for j=1:size(ret,2)
        	if (ret(i,j) > threshold)
            	ret(i,j) = 0;
        	else
            	ret(i,j) = 255;
        	end
    	end
	end

end

