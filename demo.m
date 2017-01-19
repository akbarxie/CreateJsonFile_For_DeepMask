clear all;
clc;

param.baseDir='E:\服务器下载图像';
%cd(param.baseDir);

searchDirs=dir(fullfile(param.baseDir));

num_of_all_dir=size(searchDirs,1);
dirnames = cell(num_of_all_dir-2,1);%必须去除.目录和..目录

dirIndex=1;
for f = 1:num_of_all_dir
    if(length(searchDirs(f).name)>3 &&exist([param.baseDir '\' searchDirs(f).name],'dir'))%去除.目录和..目录,且加上是目录的假设
        dirnames{dirIndex} = searchDirs(f).name;
        dirIndex=dirIndex+1;
    end;
end


num_of_dir=size(dirnames,1);

%创建json文本文件 hour(now) '_' minute(now) '_' second(now)
%printg
json_id = fopen([datestr(now,'yyyy-mm-dd') '_' sprintf('%g_%g_%g',hour(now),minute(now),second(now))  '.txt'],'a+')

%添加内容
%fprintf(json_id,'{"info":');
fprintf(json_id,'{"info": {"description": "tongue segment mask dataset.","url": "http://sorry we do not have a url", "version": "1.0", "year": 2016, "contributor": "XieJW group", "date_created":"%s"}, ',datestr(now,'yyyy-mm-dd'));
%images 
fprintf(json_id,'"images": [');
fnames=cell(num_of_dir,1);
disp('go to annno');
g_index=0;%全局的index



ntimes=1;%跑的文件夹个数


for k=1:ntimes%num_of_dir
    searchPath=[param.baseDir '\' dirnames{k,1} '\1\full'];
    fnames{k} = dir(fullfile(searchPath, '*.jpg'));
    %image
    for g=1:size(fnames{k},1)
    	oneImagePath=[searchPath '\' fnames{k,1}(g).name];
    
        I=imread(oneImagePath);
        if(k==1&&g==1)
            fprintf(json_id,'{"license": 1, ');
        else
            fprintf(json_id,',{"license": 1, ');
        end
        
        
        fprintf(json_id,'"file_name": "%s",',fnames{k,1}(g).name);
        fprintf(json_id,' "coco_url": "http://sorry/we/donot/give/url",');
   
        fprintf(json_id,' "height":%.0f,', size(I,1));
        fprintf(json_id,' "width": %.0f,', size(I,2));
        fprintf(json_id,'  "date_captured": "%s",',fnames{k,1}(g).date);
        fprintf(json_id,' "flickr_url": "http://sorry/we/donnot/provide/flicker/url",');
        
        fnames{k,1}(g).index=g_index;
        
        fprintf(json_id,'"id": %.0f}',g_index);
        g_index=g_index+1;
    end
   
    
end
fprintf(json_id,'],');

fprintf(json_id,'"licenses": [{"url": "http://creativecommons.org/licenses/by-nc-sa/2.0/", "id": 1, "name": "Attribution-NonCommercial-ShareAlike License"}, {"url": "http://creativecommons.org/licenses/by-nc/2.0/", "id": 2, "name": "Attribution-NonCommercial License"}, {"url": "http://creativecommons.org/licenses/by-nc-nd/2.0/", "id": 3, "name": "Attribution-NonCommercial-NoDerivs License"}, {"url": "http://creativecommons.org/licenses/by/2.0/", "id": 4, "name": "Attribution License"}, {"url": "http://creativecommons.org/licenses/by-sa/2.0/", "id": 5, "name": "Attribution-ShareAlike License"}, {"url": "http://creativecommons.org/licenses/by-nd/2.0/", "id": 6, "name": "Attribution-NoDerivs License"}, {"url": "http://flickr.com/commons/usage/", "id": 7, "name": "No known copyright restrictions"}, {"url": "http://www.usa.gov/copyright.shtml", "id": 8, "name": "United States Government Work"}],');

%annotations
g_annoId=0;
fprintf(json_id,' "annotations": [');
for k=1:ntimes%num_of_dir
     searchPath=[param.baseDir '\' dirnames{k,1} '\1\full'];
    for g=1:size(fnames{k},1)
        oneImagePath=[searchPath '\' fnames{k,1}(g).name];
        I=imread(oneImagePath);
	%add segmentation array
        if(k==1&&g==1)
            fprintf(json_id,'{"segmentation":');
        else
            fprintf(json_id,',{"segmentation":');
        end
	
        [xyVector area bbox]=createAnno(I,oneImagePath);
        fprintf(json_id,'[[%.0f',xyVector(1,1));
        for j=2:size(xyVector,1)
             fprintf(json_id,', %.0f',xyVector(j,1));
        end
        fprintf(json_id,']],');
        fprintf(json_id,' "area": %.3f,',area);
        fprintf(json_id,' "iscrowd": 0,');
        fprintf(json_id,' "image_id": %.0f,',fnames{k,1}(g).index);
        fprintf(json_id,' "bbox": [%.2f, %.2f, %.2f, %.2f],',bbox(1,1),bbox(1,2),bbox(1,3),bbox(1,4));
        fprintf(json_id,' "category_id": 1,');%目前只定义了一个类舌像
        fprintf(json_id,' "id": %.0f}',g_annoId);
        g_annoId=g_annoId+1;
        
    end
end

fprintf(json_id,'],');%anno
disp('go to categories');
fprintf(json_id,'"categories": [{"supercategory": "tongue", "id": 1, "name": "tongue"}]');



fprintf(json_id,'}');%全局的大括号
fclose(json_id);
