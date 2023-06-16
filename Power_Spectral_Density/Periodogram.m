%% settings
clear;clc;
sample_num=2^14;
N=2^8;
Ys=zeros(N,sample_num);
Sy=zeros(1,sample_num);

%% Make filter
freq=linspace(0,2*pi,sample_num);
z=exp(1i*freq);
H1=(1-0.9*(z.^-1)+0.1*(z.^-2)+0.2*(z.^-3)).^-1;
H2=abs(H1);
H3=H2.^2;

Sx=0.1*ones(1,sample_num);
IdealSy=H3.*Sx;

%% make Ys
for i=1:N
    x=make_x(sample_num);
    X=fft(x);
    Ys(i,:)=(abs(X.*H1).^2);
end

%% use periodogram to make Sy.
for j=1:sample_num
    Sy(j)=mean(Ys(:,j));
end
Sy=Sy/length(Sy);

%% plot
figure
plot(freq,Sy)
hold on
plot(freq,IdealSy,"LineWidth",3)
title("S_Y(Ω) by Periodogram")
xticks(0:pi/2:2*pi)
xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
xlim([0 2*pi])
legend(["Periodogram" "Ideal"])
ylabel("|S_Y(Ω)|")
xlabel("Ω")

%% function area
function x=make_x(sample)
x=zeros(1,sample);
for i=1:sample
    for j=1:12
        x(i)=x(i)+rand(1)-0.5;
    end
    x(i)=x(i)*sqrt(0.1);
end
end