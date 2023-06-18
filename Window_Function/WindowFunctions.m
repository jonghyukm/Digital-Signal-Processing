clear;clc;close all

%% settings
N=2^9;
n=linspace(0,N-1,N);
omega=linspace(0,2*pi,length(n));

%% Make window, causal
window11=make_window(n,12,"rectwin");
window12=make_window(n,12,"bartlett");
window13=make_window(n,12,"hamming");
window14=make_window(n,12,"hann");
window21=make_window(n,25,"rectwin");
window22=make_window(n,25,"bartlett");
window23=make_window(n,25,"hamming");
window24=make_window(n,25,"hann");

%% plotting
doplot(window11,omega,"Rect",12)           
doplot(window12,omega,"Bartlett",12)           
doplot(window13,omega,"Hamming",12)          
doplot(window14,omega,"Hann",12)    
doplot(window21,omega,"Rect",25)           
doplot(window22,omega,"Bartlett",25)           
doplot(window23,omega,"Hamming",25)          
doplot(window24,omega,"Hann",25)  

%% Functions
function doplot(w,omega,name,M)
%Settings
Ms=num2str(M);
W=abs((fft(w)));
DW=20*log10(W);

%plot regular
figure
plot(omega,W,"LineWidth",1.35)
xticks(0:pi/2:2*pi)
xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
ylabel("|W(Ω)|")
xlabel("Ω")
xlim([0 2*pi])
title(name+" window's Magnitude, M = "+Ms)
grid on

%plot dB scale
figure
plot(omega,DW,"LineWidth",1.35)
xticks(0:pi/2:2*pi)
xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
ylabel("20log_1_0|W(Ω)|")
xlabel("Ω")
xlim([0 2*pi])
title(name+" window's dB scale, M = "+Ms)
grid on
end

function window=make_window(n,M,name)
if name=="rectwin"
    window=[rectwin(2*M+1).' zeros(1,length(n)-(2*M+1))];
elseif name=="bartlett"
    window=[bartlett(2*M+1).' zeros(1,length(n)-(2*M+1))];
elseif name=="hamming"
    window=[hamming(2*M+1).' zeros(1,length(n)-(2*M+1))];
elseif name=="hann"
    window=[hann(2*M+1).' zeros(1,length(n)-(2*M+1))];
end
end