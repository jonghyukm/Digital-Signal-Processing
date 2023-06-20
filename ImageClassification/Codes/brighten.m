function brighten(tempX,imgnum,imgnamehead,PATH_to)
tempX=tempX.*2;
if imgnum<1000
    fname=strcat(imgnamehead{1},"0",num2str(200+imgnum),".png");
else
    fname=strcat(imgnamehead{1},num2str(200+imgnum),".png");
end
imshow(tempX);
disp(fname);
imwrite(tempX,strcat(PATH_to,fname),'png');
end