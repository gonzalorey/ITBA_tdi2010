function ret = canny( w )
%CANNY Canny edge detector, Receives a matrix representing a grayscale image and finds its borders, the argument cannot be a structure. 

%Example

%A = imread('PLAQS1.TIF');
%canny(A)

img = imread('PLAQS1.TIF');
%Parameters for the filters used for convolution
Nx1=10;
Sigmax1=1;
Nx2=10;
Sigmax2=1;
Theta1=pi/2;
Ny1=10;
Sigmay1=1;
Ny2=10;
Sigmay2=1;
Theta2=0;
alfa=0.1;

	if(length(size(w.full)) == 3)
		w = ind2gray(w.R, gray(512));
	else
		w = w.full;
	end

w = double(w);
%w = ind2gray(w, gray(512));



%subplot(1,2,2);
filterx=d2dgauss(Nx1, Sigmax1, Nx2, Sigmax2, Theta1);
Ix = conv2(w,filterx,'same');
%imshow(Ix);

%subplot(3,2,3);
filtery=d2dgauss(Ny1, Sigmay1, Ny2, Sigmay2, Theta2);
Iy = conv2(w,filtery,'same');
%imshow(Iy);

%subplot(3,2,4);
NVI=(sqrt(Ix.*Ix + Iy.*Iy));
%imshow(NVI);

%subplot(3,2,5);
I_max=max(max(NVI));
I_min=min(min(NVI));
level=alfa*(I_max-I_min)+I_min;
Ibw=max(NVI,level.*ones(size(NVI)));
%imshow(Ibw);

[n,m]=size(Ibw);
for i=2:n-1,
for j=2:m-1,
	if Ibw(i,j) > level,
	X=[-1,0,+1;-1,0,+1;-1,0,+1];
	Y=[-1,-1,-1;0,0,0;+1,+1,+1];
	Z=[Ibw(i-1,j-1),Ibw(i-1,j),Ibw(i-1,j+1);
	   Ibw(i,j-1),Ibw(i,j),Ibw(i,j+1);
	   Ibw(i+1,j-1),Ibw(i+1,j),Ibw(i+1,j+1)];
	XI=[Ix(i,j)/NVI(i,j), -Ix(i,j)/NVI(i,j)];
	YI=[Iy(i,j)/NVI(i,j), -Iy(i,j)/NVI(i,j)];
	ZI=interp2(X,Y,Z,XI,YI);
		if Ibw(i,j) >= ZI(1) & Ibw(i,j) >= ZI(2)
		I_temp(i,j)=I_max;
		else
		I_temp(i,j)=I_min;
		end
	else
	I_temp(i,j)=I_min;
	end
end
end

ret.R = I_temp;
ret.G = I_temp;
ret.B = I_temp;
ret.full = ret.R;
ret.full(:,:,2) = ret.G;
ret.full(:,:,3) = ret.B;
end

