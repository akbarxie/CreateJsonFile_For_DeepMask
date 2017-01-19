function [xyVector area bbox]= createAnno(Img,oneImagePath)
%run createAnno can get the xyVector
Img=Img(:,:,1)>125;
I = bwboundaries(Img,4,'noholes'); %4 连接边界 
if size(I,1)~=1
   fprintf( 'error I cannot find boundaries if got 2 mask,\n file path:%s',oneImagePath);
   %error(' I cannot find boundaries if got 2 mask, file path:'
   %oneImagePath]);
   Img=imread(oneImagePath);
   Img=Img(:,:,1)>125;
   I = bwboundaries(Img,4,'noholes');
   if size(I,1)~=1
       error([' I cannot find boundaries if got 2 mask, file path:' oneImagePath]);
   end
end
fprintf('%s\n',oneImagePath);
I = I{1}; 
[M,N] = size(Img);
xmin = min(I(:,1));
ymin = min(I(:,2));


%bim = bound2im(I,M,N,xmin,ymin);
%subplot(122);
%imshow(bim);
%title('边界图像') 
%bim = bound2im(I,M,N,xmin,ymin);
%subplot(122);
%imshow(bim);
%title('findContour') 


[x,y] = minperpoly(Img,2); %使用大小�?2 的方形单元得到的 MPP
xyVector=zeros([size(x)+size(y),1]);
for i=1:size(x)
    xyVector(2*i-1)=y(i);
    xyVector(2*i)=x(i);
end
%Img=double(Img);
status = regionprops(Img,'basic');
area= status(1).Area;
bbox=status(1). BoundingBox;

end
