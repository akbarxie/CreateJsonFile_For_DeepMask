B = imread('E:\����������ͼ��\2015_06_19\1\full\13_36_42_tg1434692202676gcm.jpg');
B=B(:,:,1)>125;
figure;
subplot(121);
imshow(B);
title('ԭʼͼ��');  
b = bwboundaries(B,4,'noholes'); %4 ���ӱ߽� 
b = b{1}; 

[M,N] = size(B);
xmin = min(b(:,1));
ymin = min(b(:,2));
%bim = bound2im(b,M,N,xmin,ymin);
%subplot(122);
%imshow(bim);
%title('�߽�ͼ��') 
[x,y] = minperpoly(B,2); %ʹ�ô�СΪ 2 �ķ��ε�Ԫ�õ��� MPP
c=zeros(size(x)+size(y));
for i=1:size(x)
    c(2*i-1)=x(i);
    c(2*i)=y(i);
end

%b2 = connectpoly(x,y);
%B2 = bound2im(b2,M,N,xmin,ymin);
%figure;subplot(121);
%imshow(B2);
%title('2 ���ε�Ԫ')

%fill(x,y,'r')
%axis square
