%Michael Bentivegna
%Homework 4 - Communication Theory

clear;
clc;
close all;

%% Declarations
fc = 10;
fs = 100;
N = 4096;
kf = .5;

%% Part A
dt = 1/fs;
n = 0:2000;
t = n*dt;

m = 1 ./ (1 + (t-10).^2);
mH = (t-10) ./ (1 +(t-10).^2);

%% Part B
k = (-N/2):(N/2-1);    
f = k*fs/N;

%% Part C
M = pi.*exp(-1j.*40.*pi.*f).*exp(-2.*pi.*abs(f));
y = 20*log10(abs(M));

figure(1)
plot(f, y);
xlim([-1 1])
title("M(f)")
ylabel("Magnitude (dB)")
xlabel("Frequency f (Hz)")

%% Part D
%Time Domain
figure(2)
subplot(2,1,1);
AM90 = (1 +.9.*m).*cos(2.*pi.*fc.*t);
envelopeAM90 = 1+.9.*m;
plot(t, AM90, t, envelopeAM90, 'black', t, -envelopeAM90, 'black')
title("AM 90% Modulation")
ylabel("Magnitude")
xlabel("Time t (s)")

subplot(2,1,2);
AM10 = (1 +.1.*m).*cos(2.*pi.*fc.*t);
envelopeAM10 = 1 +.1.*m;
plot(t, AM10, t, envelopeAM10, 'black', t, -envelopeAM10, 'black')
title("AM 10% Modulation")
ylabel("Magnitude")
xlabel("Time t (s)")

%Frequency Domain
figure(3)
subplot(2,1,1);
AM90f = fft(AM90, 4096);
AM90f = fftshift(AM90f);
AM90fDB = 20*log10(abs(AM90f));
plot(f, AM90fDB)
title("AM 90% Modulation")
ylabel("Magnitude (dB)")
xlabel("Frequency f (Hz)")

subplot(2,1,2);
AM10f = fft(AM10, 4096);
AM10f = fftshift(AM10f);
AM10fDB = 20*log10(abs(AM10f));
plot(f, AM10fDB)
title("AM 10% Modulation")
ylabel("Magnitude (dB)")
xlabel("Frequency f (Hz)")

figure(4)
subplot(2,1,1);
plot(f, AM90fDB)
xlim([8 12]);
title("AM 90% Modulation Zoomed In")
ylabel("Magnitude (dB)")
xlabel("Frequency f (Hz)")

subplot(2,1,2);
plot(f, AM10fDB)
xlim([8 12]);
title("AM 10% Modulation Zoomed In")
ylabel("Magnitude (dB)")
xlabel("Frequency f (Hz)")

%% Part E
figure(5);
subplot(3,1,1);
DSBSC = m.*cos(2.*pi.*fc.*t);
envelopeDSBSC = m;
plot(t, DSBSC, t, envelopeDSBSC, 'black', t, -envelopeDSBSC, 'black');
title("DSB-SC Modulation")
ylabel("Magnitude")
xlabel("Time t (s)")

subplot(3,1,2)
USSB = m.*cos(2.*pi.*fc.*t) - mH.*sin(2.*pi.*fc.*t);
envelopeUSSB = sqrt(m.^2 + (-mH).^2);
plot(t, USSB, t, envelopeUSSB, 'black', t, -envelopeUSSB, 'black');
title("USSB Modulation")
ylabel("Magnitude")
xlabel("Time t (s)")

subplot(3,1,3)
LSSB = m.*cos(2.*pi.*fc.*t) + mH.*sin(2.*pi.*fc.*t);
envelopeLSSB = sqrt(m.^2 + mH.^2);
plot(t, LSSB, t, envelopeLSSB, 'black', t, -envelopeLSSB, 'black');
title("LSSB Modulation")
ylabel("Magnitude")
xlabel("Time t (s)")

%****Part F Done on Paper****
%% Part G
figure(6);
subplot(3,1,1);
DSBSCf = fft(DSBSC, 4096);
DSBSCf = fftshift(DSBSCf);
DSBSCfDB = 20*log10(abs(DSBSCf));
plot(f, DSBSCfDB)
title("DSB-SC Modulation")
ylabel("Magnitude (dB)")
xlabel("Frequency f (Hz)")

subplot(3,1,2);
USSBf = fft(USSB, 4096);
USSBf = fftshift(USSBf);
USSBfDB = 20*log10(abs(USSBf));
plot(f, USSBfDB)
title("USSB Modulation")
ylabel("Magnitude (dB)")
xlabel("Frequency f (Hz)")

subplot(3,1,3);
LSSBf = fft(LSSB, 4096);
LSSBf = fftshift(LSSBf);
LSSBfDB = 20*log10(abs(LSSBf));
plot(f, LSSBfDB)
title("LSSB Modulation")
ylabel("Magnitude (dB)")
xlabel("Frequency f (Hz)")

figure(7)
subplot(3,1,1);
plot(f, DSBSCfDB);
xlim([8 12]);
title("DSB-SC Modulation Zoomed In")
ylabel("Magnitude (dB)")
xlabel("Frequency f (Hz)")

subplot(3,1,2);
plot(f, USSBfDB);
xlim([8 12]);
title("USSB Modulation Zoomed In")
ylabel("Magnitude (dB)")
xlabel("Frequency f (Hz)")

subplot(3,1,3);
plot(f, LSSBfDB);
xlim([8 12]);
title("LSSB Modulation Zoomed In")
ylabel("Magnitude (dB)")
xlabel("Frequency f (Hz)")
%% Part H
figure(8)
FM = cos(2.*pi.*fc.*t + 2.*pi.*kf.*((pi/2)+atan(t-10)));
plot(t, FM);
title("FM Modulation")
ylabel("Magnitude")
xlabel("Time t (s)")

%% Part I
figure(9)
subplot(2,1,1)
FMf = fft(FM, 4096);
FMf = fftshift(FMf);
FMfDB = 20*log10(abs(FMf));
plot(f, FMfDB)
title("FM Modulation")
ylabel("Magnitude (dB)")
xlabel("Frequency f (Hz)")

subplot(2,1,2)
plot(f, FMfDB)
xlim([8 12]);
title("FM Modulation Zoomed In")
ylabel("Magnitude (dB)")
xlabel("Frequency f (Hz)")

%% Part J
figure(10); 
plot(f, abs(FMf)/max(abs(FMf)) , 'red', f, abs(DSBSCf)/max(abs(DSBSCf)), 'green');
legend('FM','DSB-SC')
xlim([8 12]);
title("FM vs DSB-SC")
ylabel("Magnitude")
xlabel("Frequency f (Hz)")