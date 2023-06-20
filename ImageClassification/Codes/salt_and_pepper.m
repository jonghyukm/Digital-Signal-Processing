function salt_and_pepper(tempX,imgnum,imgnamehead,PATH_to,frame)
for sr=1:frame
    for sc=1:frame
        determine=rand(1);
        if (0<determine) && (determine<=1/8)
            tempX(sr,sc)=0;
        elseif (1/8<determine) && (determine<=1/4)
            tempX(sr,sc)=255;
        end
    end
end
if imgnum<1000
    fname=strcat(imgnamehead{1},"0",num2str(500+imgnum),".png");
else
    fname=strcat(imgnamehead{1},num2str(500+imgnum),".png");
end
imshow(tempX);
disp(fname);
imwrite(tempX,strcat(PATH_to,fname),'png');
end
