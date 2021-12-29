%  aliasing.m
%
%  This m-file illustrates the effects of aliasing in time and frequency domains
%
%
%  Written by Raymond Roberts and Graham Roberts,
%  students at Curtin University of Technology
%  September 1996.
%


% Four time bases, at four sampling rates.
t1 = 0:.001:8;
t2 = 0:.01:8;
t3 = 0:.05:8;
t4 = 0:.1:8;

% Four samples of a cosine at 60 rad/sec
s1 = cos(60*t1);
s2 = cos(60*t2);
s3 = cos(60*t3);
s4 = cos(60*t4);

% Plots of the four samples
subplot(221);
plot(t1,s1);
axis([0 1 -1 1]);
title('.001 s sampling rate');
subplot(222);
plot(t2,s2);
axis([0 1 -1 1]);
title('.01 s sampling rate');
subplot(223);
plot(t3,s3);
axis([0 1 -1 1]);
title('.05 s sampling rate');
subplot(224);
plot(t4,s4);
axis([0 1 -1 1]);
title('.1 s sampling rate');
clc
fprintf('Results show the effect of different sampling frequencies\n');
fprintf('and aliasing.\n\nThe sampled function is cos(omega*t)\n');
fprintf('where omega is 60 rad/sec\n\n');
fprintf('Note that if the time between samples is more than half the period of\n');
fprintf('the sampled function then an error occurs in the sampling.\n');
fprintf('This error is called aliasing.\n\n');
fprintf('In other words, to avoid aliasing when sampling a signal,\n');
fprintf('the sampling frequency must be greater than twice the highest\n');
fprintf('frequency component in the signal. This is the Nyquist Sampling Theorem.\n\n');
fprintf('Press any key to continue.\n\n\n\n');
pause

clf
clc

fprintf('Aliasing effects are also evident in the frequency spectrum\n\n');
fprintf('If the sampling frequency is less than the Nyquist frequency then the\n');
fprintf('frequency components higher than the Nyquist frequency appear erroneously\n');
fprintf('as lower frequencies.\n\n');
fprintf('The higher frequencies "fold over" around the Nyquist frequency\n\n\n');
fprintf('This series of spectrum plots illustrate the effect of changing the\n');
fprintf('sampling rate on the frequency domain representation of the signal\n\n');

S1 = fftshift(abs(fft(s1,1024)));
S2 = fftshift(abs(fft(s2,1024)));
S3 = fftshift(abs(fft(s3,1024)));
S4 = fftshift(abs(fft(s4,1024)));

w1 = -500:1000/1024:500-1/1024;
plot(w1,S1);

fprintf('Frequency spectrum: First sampling rate.\n');
fprintf('Peak is at 60 rad/sec.\n\n');

fprintf('Press any key to continue.\n\n');
pause

w2 = -50:100/1024:50-1/1024;
plot(w2,S2);
fprintf('Frequency spectrum: Sampling rate halved.\n');
fprintf('Peak is still at 60 rad/sec.\n\n');
fprintf('Press any key to continue.\n\n');
pause

w3 = -25:50/1024:25-1/1024;
plot(w3,S3);
fprintf('Frequency spectrum: Sampling rate again halved.\n');
fprintf('Peak is still at 60 rad/sec, but it''s close to the edge.\n\n');
fprintf('Press any key to continue.\n\n');
pause

w4 = -5:10/1024:5-1/1024;
plot(w4,S4);
fprintf('Frequency spectrum: Sampling rate again halved.\n');
fprintf('60 rad/sec peak now appears to be much lower. Aliasing has occurred.\n\n');
