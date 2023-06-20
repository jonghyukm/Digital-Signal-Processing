function darken(tempX,imgnum,imgnamehead,PATH_to)
tempX=tempX.*0.5;
if imgnum<1000
    fname=strcat(imgnamehead{1},"0",num2str(300+imgnum),".png");
else
    fname=strcat(imgnamehead{1},num2str(300+imgnum),".png");
end
imshow(tempX);
disp(fname);
imwrite(tempX,strcat(PATH_to,fname),'png');
end