function quantization(tempX,imgnum,imgnamehead,PATH_to,frame)
for qr=1:frame
    for qc=1:frame
        if tempX(qr,qc)<128
            tempX(qr,qc)=0;
        else
            tempX(qr,qc)=255;
        end
    end
end
if imgnum<1000
    fname=strcat(imgnamehead{1},"0",num2str(100+imgnum),".png");
else
    fname=strcat(imgnamehead{1},num2str(100+imgnum),".png");
end
imshow(tempX);
disp(fname);
imwrite(tempX,strcat(PATH_to,fname),'png');
end