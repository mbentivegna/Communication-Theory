%Michael Bentivegna
%Comm Theory - Homework 6

clear;
clc;
close all;

%% Question 3d

%Let epsilon equal 1 for calculations
d_min = [2 2*sqrt(2) 4 2*sqrt(5) 6 2*sqrt(10)];
k = [20 12 8 8 4 4];

%Calculated Vectors
alpha = k./24
beta = (d_min).^2/4

%% Question 3f

%Find approximation using value chosen from part e
x = linspace(2, 8, 1000);
Approximation = alpha(1)*qfunc(sqrt(10.^(x/10)));

%Find actual value using the union sum
Union_Sum = zeros([1,1000]);
for i = 1:6
    Union_Sum(1, :) = Union_Sum(1, :) + alpha(i).*qfunc(sqrt(beta(i)*10.^(x./10)));
end

%Graph the plot
figure(1);
semilogy(x, Approximation, x, Union_Sum);
xlim([1 9]);
ylim([10^(-3) 10^(-.5)]);
legend('Approximation','Union Sum')
xlabel("Gamma (dB)");
ylabel("Error");
title("Probability of Bit Error for Varying Levels of Gamma");

%Find difference in bit error at 2dB vs 8dB
Check2 = 1 - (Approximation(1) / Union_Sum(1))
Check8 = 1 - (Approximation(1000) / Union_Sum(1000))

