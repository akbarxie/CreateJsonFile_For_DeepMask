clc;
clear all;
%用于确定我们做的mask和人家标准的coco数据集中
%的mask是否一致，用于查看结果
array=[239.97, 260.24, 222.04, 270.49, 199.84, 253.41, 213.5, 227.79,...
    259.62, 200.46, 274.13, 202.17, 277.55, 210.71, 249.37, 253.41, 237.41,...
    264.51, 242.54, 261.95, 228.87, 271.34 ];
bbox= [199.84, 200.46, 77.71, 70.88];%x,y,width,heigth
bbox=int32(bbox);


fileName='./COCO_val2014_000000558840.jpg';
I=imread(fileName);

x=zeros(length(array)/2,1);
y=zeros(length(array)/2,1);

indexXYOffset=1;
for i=1:2:length(array)
   y(indexXYOffset)=array(i);
   x(indexXYOffset)=array(i+1);
   indexXYOffset=indexXYOffset+1;
end


I=bitmapplot(x,y,I,struct('FillColor',[0 1 0 0.5],'Color',[1 1 0 1]));

figure
plot(I(:,:,1),'XData',x,'YData',y);

pt = [bbox(1), bbox(2)];
wSize = [bbox(3), bbox(4)];

des = drawRect(I,pt,wSize,5 );
figure
imshow(des);

% 显示你的图片
 %imshow(I);
  
