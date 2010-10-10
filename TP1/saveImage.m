function ret = saveImage(img, filename)

	if(length(size(img.full)) == 3)        
        % apply for a RGB image		
		imwrite(img.full, filename);
	else		
		% apply for a RAW image  
		fid = fopen(filename, 'wb');
		fwrite(fid, img.full);
	end
end