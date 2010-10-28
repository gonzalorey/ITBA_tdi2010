function img = susan(img1, umbral, limit)
	
	if(length(size(img1.full)) == 3)
		img1.full = img1.R;
	end
	
	img=img1;
	lado = 7;
	pagina = 1;
	clear img.data;

	data = int32(zeros(size(img1.full,1)+lado-1, size(img1.full,2)+lado-1));
	
    for i = 1 : lado
	    for j = 1 : lado
		
            if ( i - floor(lado/2) - 1 ) ^ 2 / floor(lado/2)^2+(j-floor(lado/2)-1)^2/floor(lado/2)^2 < 1.15
                
                data(i:i+size(img1.full,1)-1, j:j+size(img1.full,2)-1, pagina) = img1.full(:,:);
                pagina = pagina + 1;
		
            end
        end
    end

	c=int32(zeros(size(data,1), size(data,2)));
    
	for i = 1:size(data,3)
	     c = int32(c) + int32(abs(data(:,:,19)-data(:,:,i))<umbral);
	end

	c = c < limit;

	c = c(floor(lado/2)+1:floor(lado/2)+1+size(img1.full,1)-1, floor(lado/2)+1:floor(lado/2)+1+size(img1.full,2)-1);
	img.R=uint8(c*255);
    img.G=uint8(c*255);
    img.B=uint8(c*255);
    img.full = img.R;
    img.full(:,:,2) = img.G;
    img.full(:,:,3) = img.B;
end