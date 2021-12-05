%Michael Bentivegna
%Comm Theory - Homework 5

clear;
clc;
close all;

%% Water Filling Algorithm
sigma = [1, .8, .1, .01];
lambda1 = 0.005;
lambda2 = .20; 

for i = 1:10
    midpoint = (lambda1 + lambda2) / 2;
    D1 = zeros([1,4]);
    for k = 1:4
        if sigma(1,k) > lambda1
            D1(1,k) = lambda1;
        else
            D1(1,k) = sigma(1,k);
        end
    end
    D2 = zeros([1,4]);
    for c = 1:4
        if sigma(1,c) > lambda2
            D2(1,c) = lambda2;
        else
            D2(1,c) = sigma(1,c);
        end
    end
    DM = zeros([1, 4]);
    for g = 1:4
        if sigma(1,g) > midpoint
            DM(1,g) = midpoint;
        else
            DM(1,g) = sigma(1,g);
        end
    end
    
    R1 = 0;
    R2 = 0;
    RM = 0;
   
    for q = 1:4
        R1 = R1 + .5*log(sigma(1, q)/D1(1, q));
        R2 = R2 + .5*log(sigma(1, q)/D2(1, q));
        RM = RM + .5*log(sigma(1, q)/DM(1, q));
    end
    
    if RM < 3
        lambda2 = midpoint;
    else    
        lambda1 = midpoint;
    end
    
    
end

fprintf("A Correct Lambda Value is: %d\nThe Corresponding R Value: %d\n", lambda2, R2);

%%

x = (qfuncinv(10^-5))^2/1.217
x_log = 10*log10(abs(x))

y = (qfuncinv(10^-5))^2
y_log = 10*log10(abs(y))