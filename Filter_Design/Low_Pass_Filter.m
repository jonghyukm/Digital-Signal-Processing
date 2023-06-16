%% settings for ft
clear;clc;close all
M=10;
N=2^10;
n=linspace(0,N-1,N);
tempn=n(1:2*M+1);
freq=linspace(0,2*pi,N);

%% Make x(n)
v=ones(1,2*M+1);                       
noise=zeros(1,2*M+1);
for i=1:2*M+1
    for j=1:12
        noise(i)=noise(i)+rand(1)-0.5;
    end
    noise(i)=noise(i)*0.1;
end
x=v+sin(0.4*pi*tempn)+0.5*sin(0.6*pi*tempn)+noise;
x_padded=[zeros(1,N-(2*M+1)) x];    
v_padded=[zeros(1,N-(2*M+1)) v];
V=abs(fft(v_padded));

%% DTFT for x(n)
X1=fft(x_padded);
X2=abs(X1);

%% set h(n) and H(omega)
d_cutoff=0.2;
win_point=12;
filter_range=linspace(0,2*win_point,2*win_point+1);
ideal_n=linspace(-N/2,N/2-1,N);
h_ideal=d_cutoff*sinc(d_cutoff*ideal_n);
window=call_window("hann",win_point,N);
h=h_ideal.*window;

%% Filtering
y=conv(x_padded,h,'same');
Y=abs(fft(y));

%% Filter in frequency domain
HT=fft(h).*exp(-1i*freq*win_point);
HTM=abs(HT);
HTA=angle(HT);

%% plot all requirements
stemp(tempn,x,"x(n)")
contp(freq,X2,"X(Ω)")
stemp(filter_range,h((N/2)-(win_point-1):(N/2)+(win_point+1)),"h_L_P_F(n)") 
contp(freq,HTM,"H_L_P_F(Ω)")
contp(freq,HTA,"∠H_L_P_F(Ω)")
stemp(tempn,y(end-2*M:end),"y(n)")
stemp(tempn,y(end-2*M:end),"Compare y(n)")
stemp(tempn,v,"v(n)")
stemp(tempn,v,"Compare v(n)")
contp(freq,Y,"Y(Ω)")
contp(freq,V,"V(Ω)")

%% function area
function stemp(n,f,name)
figure
stem(n,f)
title("Graph of "+name)
ylabel(name)
xlabel("n")
if name=="Compare y(n)" || name=="Compare v(n)"
    ylim([0 10])
end
xlim([0 max(n)])
grid on
end

function contp(n,f,name)
figure
plot(n,f)
xticks(0:pi/2:2*pi)
xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
xlim([0 2*pi])
if name=="∠H_L_P_F(Ω)"
    title("Graph of "+name)
    yticks(-pi:pi/2:pi)
    yticklabels({'-\pi','-\pi/2','0','\pi/2','\pi'})
    ylabel(name)
else
    title("Magnitude Graph of "+name)
    ylabel("|"+name+"|")
end
xlabel("Ω")
grid on
end


function window=call_window(name,points,N)
windows=[zeros(1,(N/2)-points) rectwin(2*points+1).' zeros(1,(N/2)-points-1);
    zeros(1,(N/2)-points) bartlett(2*points+1).' zeros(1,(N/2)-points-1);
    zeros(1,(N/2)-points) hamming(2*points+1).' zeros(1,(N/2)-points-1);
    zeros(1,(N/2)-points) hann(2*points+1).' zeros(1,(N/2)-points-1)];
if name=="rect"
    window=windows(1,:);
elseif name=="bartlett"
    window=windows(2,:);
elseif name=="hamming"
    window=windows(3,:);
elseif name=="hann"
    window=windows(4,:);
end
end