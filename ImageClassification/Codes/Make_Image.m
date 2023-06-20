clc;clear;close all;

FPS=20;
one_image_fr=3.2*FPS;
numofimage=10;
directory={"Circle","Triangle","X_Shape"};
shape={"O","T","X"};

for shapenum=1
    PATH_from=strcat("C:\Users\DSP_Final_Project\Final_Project\Data\",directory{shapenum},"\");
    PATH_to=strcat("C:\Users\DSP_Final_Project\Final_Project\image\",shape{shapenum},"\");
    filelist=dir(PATH_from);
    filelist(1:2)=[];
    imgnum=1;
    imgnamehead=directory(shapenum);
    for i=1:size(filelist,1)
        load(strcat(PATH_from,filelist(i).name));
        for k=1:numofimage
            tempX=Hilbert_History((k-1)*one_image_fr+1:k*one_image_fr, ...
                1:one_image_fr);
            for a=1:one_image_fr
                tempX(a,:)=normalize(tempX(a,:),'range').*255;
            end
            tempX=uint8(tempX);
            if imgnum<10
                fname=strcat(imgnamehead{1},"000",num2str(imgnum),".png");
            elseif imgnum<100
                fname=strcat(imgnamehead{1},"00",num2str(imgnum),".png");
            elseif imgnum<1000
                fname=strcat(imgnamehead{1},"0",num2str(imgnum),".png");
            else
                fname=strcat(imgnamehead{1},num2str(imgnum),".png");
            end
            imshow(tempX);
            disp(fname);
            imwrite(tempX,strcat(PATH_to,fname),'png');
            quantization(tempX,imgnum,imgnamehead,PATH_to,one_image_fr)
            brighten(tempX,imgnum,imgnamehead,PATH_to)
            darken(tempX,imgnum,imgnamehead,PATH_to)
            gaussian_noise(tempX,imgnum,imgnamehead,PATH_to,one_image_fr)
            salt_and_pepper(tempX,imgnum,imgnamehead,PATH_to,one_image_fr)
            imgnum=imgnum+1;
        end
    end
end