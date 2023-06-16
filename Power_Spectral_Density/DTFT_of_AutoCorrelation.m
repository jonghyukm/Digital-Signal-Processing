%% settings
clear;clc;close all;
sample_num=2^14;
x=zeros(1,sample_num);
for i=1:sample_num
    for j=1:12
        x(i)=x(i)+rand(1)-0.5;
    end
    x(i)=x(i)*sqrt(0.1);
end
IdealSx=0.1*ones(1,sample_num);
freq1=linspace(0,2*pi,sample_num);
X=fft(x);

%% Filtering and make ideal
z=exp(1i*freq1);
H1=abs((1-0.9*(z.^-1)+0.1*(z.^-2)+0.2*(z.^-3)).^-1).^2;
H2=(1-0.9*(z.^-1)+0.1*(z.^-2)+0.2*(z.^-3)).^-1;
IdealSy=H1.*IdealSx;
Y=H2.*X;
y=real(ifft(Y));

%% Auto correlation
lags=linspace(-(sample_num-1),(sample_num-1),(2*sample_num-1));
ry=zeros(1,2*sample_num-1);
for k=1:(2*sample_num-1)
    if k>=sample_num
        for i=1:2*sample_num-k
            ry(k)=ry(k)+(y(i)*y(i+k-sample_num));
        end
    else
        for i=sample_num-k:sample_num-1
            ry(k)=ry(k)+(y(2*sample_num-(i+k))*y(sample_num-i));
        end
    end
end
ry_padded=[0 ry];
Sy=abs(fft(ry_padded))/length(ry);
freq2=linspace(0,2*pi,length(ry_padded));
ry=ry/sample_num;

%% Plot
figure
stem(lags,ry)
title("R_Y(k)")
ylabel("R_Y(k)")
xlabel("k")
grid on

figure
plot(freq2,Sy)
hold on
plot(freq1,IdealSy,"LineWidth",3)
grid on
title("S_Y(Ω) by DTFT of R_Y(k)")
xticks(0:pi/2:2*pi)
xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
xlim([0 2*pi])
legend(["DTFT of R_Y(k)" "Ideal"])
ylabel("|S_Y(Ω)|")
xlabel("Ω")