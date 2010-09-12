function ret = getDiff( a , b )

   ret = a.full - b.full;
   
   for i=1:size(ret,1)
    	for j=1:size(ret,2)
        	if (ret(i,j) > 255)
            	ret(i,j) = 255;
            elseif (ret(i,j) < 0)
                ret(i,j) = 0;
        	end
    	end
	end

end

