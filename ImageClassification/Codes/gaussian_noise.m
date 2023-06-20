function gaussian_noise(tempX,imgnum,imgnamehead,PATH_to,frame)
for gr=1:frame
    for gc=1:frame
        tempX(gr,gc)=tempX(gr,gc)+50*randn(1);
    end
end
if imgnum<1000
    fname=strcat(imgnamehead{1},"0",num2str(400+imgnum),".png");
else
    fname=strcat(imgnamehead{1},num2str(400+imgnum),".png");
end
imshow(tempX);
disp(fname);
imwrite(tempX,strcat(PATH_to,fname),'png');
end