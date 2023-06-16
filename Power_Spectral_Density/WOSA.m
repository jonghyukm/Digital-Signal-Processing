%% settings
clear;clc;
sample_num=2^14;
x=zeros(1,sample_num);
for i=1:sample_num
    for j=1:12
        x(i)=x(i)+rand(1)-0.5;
    end
    x(i)=x(i)*sqrt(0.1);
end

%% Make filter
freq=linspace(0,2*pi,sample_num);
z=exp(1i*freq);
H1=(1-0.9*(z.^-1)+0.1*(z.^-2)+0.2*(z.^-3)).^-1;
H2=abs(H1);
H3=H2.^2;
Sx=0.1*ones(1,sample_num);
IdealSy=H3.*Sx;

%% Filtering x(n), make y(n)
X=fft(x);
Y=X.*H1;
y=ifft(Y);

%% WOSA to make Sy.
M=2^8;
N=sample_num;
wosa=zeros((M/2)-1,N);
WOSA=zeros((M/2)-1,N);
Result=zeros(1,N);
for i=1:(M/2)-1
    temp=y((M/2)*(i-1)+1:(M/2)*(i+1)).*(hamming(M).');
    wosa(i,:)=[zeros(1,N-M) temp];
end
for j=1:(M/2)-1
    WOSA(j,:)=(abs(fft(wosa(j,:))).^2);
end
for k=1:N
    Result(k)=mean(WOSA(:,k));
end
Result=Result/((M/2)-1);

%% plot
figure
plot(freq,Result,"LineWidth",2)
hold on
plot(freq,IdealSy,"LineWidth",2)
grid on
title("S_Y(Ω) by WOSA")
xticks(0:pi/2:2*pi)
xticklabels({'0','\pi/2','\pi','3\pi/2','2\pi'})
xlim([0 2*pi])
legend(["WOSA" "Ideal"])
ylabel("|S_Y(Ω)|")
xlabel("Ω")