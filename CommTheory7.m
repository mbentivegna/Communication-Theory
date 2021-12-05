%Michael Bentivegna
%Homework 7 - Communication Theory

clear;
clc;
close all;

%% Question 2

%Parameters
beta = .3;
span = 4;
L = 16;
Rs = 10^6;

p = rcosdesign(beta, span, L, 'sqrt');
tmp = fliplr(p);
g = conv(p, tmp);

%% Part a
figure(1);
stem(0:length(p) - 1, p);
xlabel("Index")
ylabel("Magnitude")
title("Plot of p[n]")

%Find Peak
[M, i] = max(p);
fprintf("The kp_peak Value Occurs at index %d with the value %f \n", i-1, M);

%% Part b
figure(2);
stem(0:length(g) - 1, g);
xlabel("Index")
ylabel("Magnitude")
title("Plot of g[n]")

%Find Peak and Single Interferer Magnitude
[Mg, ig] = max(g);
fprintf("The kg_peak Value Occurs at index %d with the value %f \n", ig-1, Mg);
fprintf("The max interference is %f \n", g(65 + L));

%Calculate the Sum of ISI for the SIR Value
isi = zeros([1,8]);
for i = 1:4
    isi(i) = abs(g(65+i*L));
    isi(i+4) = abs(g(65-i*L));
end
isiSum = sum(isi);
fprintf("The signal-to-noise ratio is %f \n", 10*log10(1/isiSum^2));

%% Part c
f = linspace(0, Rs, 1000);
[H, w] = freqz(p, 1, f, Rs*L);
[Hg, wg] = freqz(g, 1, f, Rs*L);
Hg_flip = fliplr(Hg);

figure(3);
plot(w, abs(H));
xlabel("Frequency (Hz)");
ylabel("Magnitude");
title("Plot of |P(f)|");

figure(4);
hold on;
plot(wg, abs(Hg));
plot(wg, abs(Hg_flip));
plot(wg, abs(Hg) + abs(Hg_flip));
xlabel("Frequency (Hz)");
ylabel("Magnitude");
title("Plot of G(f) Graphs (Linear Scale)");
legend("|G(f)|", "|G(Rs - f)|", "|G(f)| + |G(Rs - f)|")

figure(5);
hold on;
plot(wg, 20*log10(abs(Hg)));
plot(wg, 20*log10(abs(Hg_flip)));
plot(wg, 20*log10(abs(Hg) + abs(Hg_flip)));
ylim([0, 30])
xlabel("Frequency (Hz)");
ylabel("Magnitude (dB)");
title("Plot of G(f) Graphs (Decibel Scale)");
legend("|G(f)|", "|G(Rs - f)|", "|G(f)| + |G(Rs - f)|")
