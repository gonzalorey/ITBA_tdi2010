function ret = kirshOperator(img)
	
	% the return value type is the same as the entry image type
	ret = img;
	
	% create the mask
	mask1 = [5, 5, 5; -3, 0, -3; -3, -3, -3];
	mask2 = [5, -3, -3; 5, 0, -3; 5, -3, -3];
	mask3 = [5, 5, -3; 5, 0, -3; -3, -3, -3];
	mask4 = [-3, -3, -3; 5, 0, -3; 5, 5, -3];

	% process for RGB or RAW image
	if(length(size(img.full)) == 3)
		ret.R = applyMask(img.R, mask1);
		ret.G = applyMask(img.G, mask1);
		ret.B = applyMask(img.B, mask1);
		ret.R = applyMask(img.R, mask2);
		ret.G = applyMask(img.G, mask2);
		ret.B = applyMask(img.B, mask2);
		ret.R = applyMask(img.R, mask3);
		ret.G = applyMask(img.G, mask3);
		ret.B = applyMask(img.B, mask3);
		ret.R = applyMask(img.R, mask4);
		ret.G = applyMask(img.G, mask4);
		ret.B = applyMask(img.B, mask4);
		ret.full = ret.R;
		ret.full(:,:,2) = ret.G;
		ret.full(:,:,3) = ret.B;
	else
		ret.full = applyMask(ret.full, mask1);
		ret.full = applyMask(ret.full, mask2);
		ret.full = applyMask(ret.full, mask3);
		ret.full = applyMask(ret.full, mask4);
	end
end