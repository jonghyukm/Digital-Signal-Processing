clear;clc;close all;

%% Make Random Process
x=zeros(1,10000);
for i=1:10000
    for j=1:12
        x(i)=x(i)+rand(1)-0.5;
    end
end

%% Draw Histogram
figure
histogram(x,100)
title("Histogram of X")
xlabel("Random number")
ylabel("Number of Random numbers")
grid on

%% Draw Gaussian to compare
figure
histogram(x,100,'Normalization',"pdf")
hold on
xx=-4:0.01:4;
f=normpdf(xx,0,1);
plot(xx,f,"LineWidth",2)
title("Comparison of Histogram and pdf f_X(x)")
ylabel("f_X(x)")
xlabel("x")
grid on

%% Draw Auto correlation
lags=linspace(-9999,9999,19999);
r=zeros(1,19999);
for k=1:19999
    if k>=10000
        for i=1:20000-k
            r(k)=r(k)+(x(i)*x(i+k-10000));
        end
    else
        for i=10000-k:9999
            r(k)=r(k)+(x(20000-(i+k))*x(10000-i));
        end
    end
end
r=r*(1/10000);

%% Draw Auto-Correlation
figure
stem(lags,r)
title("Auto correlation of X")
ylabel(" R_X(k)")
xlabel("k")
ylim([-0.2 1.2])
grid on