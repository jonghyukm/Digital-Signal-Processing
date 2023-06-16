%% settings
clear;clc;
sample_num=2^14;
Sx=0.1*ones(1,sample_num);

%% Make Z filter
freq=linspace(0,2*pi,sample_num);
z=exp(1i*freq);
H1=(1-0.9*(z.^-1)+0.1*(z.^-2)+0.2*(z.^-3)).^-1;
H2=abs(H1);
H3=H2.^2;

%% make ideal S_Y
Sy=H3.*Sx;

%% Plotting
figure
plot(freq,Sy,"LineWidth",2)
title("Ideal S_Y(Ω)")
xticks(0:pi/2:2*pi)
xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
xlim([0 2*pi])
ylabel("|S_Y(Ω)|")
xlabel("Ω")
grid on