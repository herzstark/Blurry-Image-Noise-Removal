clear, clc;
Blurry = imread('BlurImage.png');

ConImg=uint8(zeros(size(Blurry,1),size(Blurry,2)));
filter=[1 1 1 ; 1 -8 1 ; 1 1 1]; %%filter that come from the second derivative

row=size(Blurry,1);
col=size(Blurry,2);
new_pix=uint8(zeros(1));
padded=zeros(row+2,col+2); 
padded(2:row+1,2:col+1)= Blurry;  %%with padding now I have zeros around my image
Final=uint8(zeros(size(Blurry,1),size(Blurry,2)));

for i=2:1:row+1
    for j=2:1:col+1
        %%for the new pixel intentisty value I need to multiply every
        %%value with their filter value and find their sum. so that my new
        %%pixel will be its second derivative
        new_pix=filter(1,1)*padded(i-1,j-1)+filter(1,2)*padded(i-1,j)+filter(1,3)*padded(i-1,j+1)+filter(2,1)*padded(i,j-1)+filter(2,2)*padded(i,j)+filter(2,3)*padded(i,j+1)+filter(3,1)*padded(i+1,j-1)+filter(3,2)*padded(i+1,j)+filter(3,3)*padded(i+1,j+1);
        ConImg(i-1,j-1)= new_pix; %%Second derivative of the image
    end
end
Final = Blurry-ConImg; %%need to subtract it rom the original to get sharpened one
subplot(1,2,1),imshow(Blurry),title('Before');
subplot(1,2,2),imshow(Final),title('After');
imwrite(Final,'EnhancedImage2.png');
