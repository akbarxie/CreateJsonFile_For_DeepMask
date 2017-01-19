B = imread('E:\服务器下载图像\2015_06_19\1\full\13_36_42_tg1434692202676gcm.jpg');
B=B(:,:,1)>125;
figure;
subplot(121);
imshow(B);
title('原始图像');  
b = bwboundaries(B,4,'noholes'); %4 连接边界 
b = b{1}; 

[M,N] = size(B);
xmin = min(b(:,1));
ymin = min(b(:,2));
%bim = bound2im(b,M,N,xmin,ymin);
%subplot(122);
%imshow(bim);
%title('边界图像') 
[x,y] = minperpoly(B,2); %使用大小为 2 的方形单元得到的 MPP
c=zeros(size(x)+size(y));
for i=1:size(x)
    c(2*i-1)=x(i);
    c(2*i)=y(i);
end

%b2 = connectpoly(x,y);
%B2 = bound2im(b2,M,N,xmin,ymin);
%figure;subplot(121);
%imshow(B2);
%title('2 方形单元')

%fill(x,y,'r')
%axis square
