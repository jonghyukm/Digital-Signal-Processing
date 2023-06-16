%% settings for ft
clear;clc;close all;
M=20;
N=2^10;
n=linspace(0,N-1,N);
part_n=linspace(0,M,M+1);
interpolated_n=linspace(0,2*M,2*M+1);
freq_range=linspace(0,2*pi,N);

%% make x(n) and ideal y(n)
noise=zeros(1,M+1);
for i=1:M+1
    for j=1:12
        noise(i)=noise(i)+rand(1)-0.5;
    end
    noise(i)=noise(i)*0.1;
end
x=sin(0.2*pi*part_n)+noise;
x_padded=[zeros(1,N-length(x)) x];
X=abs(fft(x_padded));
s=sin(0.2*pi*part_n);
s_padded=[zeros(1,N-M-1) s];
S=abs(fft(s_padded));
tempx=zeros(1,2*M+1);
for i=1:2*M+1
    if mod(i,2)~=0
        tempx(i)=x((i+1)/2);
    end
end
x2_padded=[zeros(1,N-length(tempx)) tempx];
X2=abs(fft(x2_padded));
y_ideal=interp(x,2);
y_ideal_padded=[zeros(1,N-length(y_ideal)) y_ideal];
Y_ideal=abs(fft(y_ideal_padded));

%% filter design
d_cutoff=1/3;
win_point=12;
filter_range=linspace(0,2*win_point,2*win_point+1);
ideal_n=linspace(-N/2,N/2-1,N);
h=d_cutoff*sinc(d_cutoff*ideal_n);
window=call_window("hann",win_point,N);
ht=h.*window;

%% Filtering
y=conv(x2_padded,ht,'same').*2;
Y=abs(fft(y));

%% See Filter in Frequency domain
HT=fft(ht).*exp(-1i*freq_range*win_point);
HTM=abs(HT);
HTA=angle(HT);

%% plotting area
stemp(part_n,x,"x(n)")
stemp(interpolated_n,tempx,"Padded x(n)")
contp(freq_range,X,"X(Ω)")
contp(freq_range,X2,"Padded X(Ω)")
contp(freq_range,S,"DTFT of sin(0.2πn)")
stemp(filter_range,ht((N/2)-(win_point-1):(N/2)+(win_point+1)),"h(n)")
contp(freq_range,HTM,"H(Ω)")
contp(freq_range,HTA,"∠H(Ω)")
stemp(interpolated_n,y(end-2*M:end),"y(n)")
stemp(interpolated_n,y_ideal(1:2*M+1),"y_I_d_e_a_l(n)")
contp(freq_range,Y,"Y(Ω)")
contp(freq_range,Y_ideal,"Y_I_d_e_a_l(Ω)")
stemp(part_n,s,"sin(0.2πn)")

%% functions
function stemp(n,f,name)
figure
stem(n,f)
title("Graph of "+name)
ylabel(name)
xlabel("n")
if name~="h(n)"
    ylim([-1.5 1.5])
end
if name=="y(n)" || name=="x(n)" || name=="y_ideal(n)" || name=="Padded x(n)"
    ylim([-1.5 1.5])
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
if name=="∠H(Ω)"
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