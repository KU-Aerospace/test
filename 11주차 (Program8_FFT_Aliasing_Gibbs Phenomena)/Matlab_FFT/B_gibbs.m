%-------------------------------------------------------------------------
%function gibbs(n)
% An illustration of Gibbs phenomenon.
% This function computes the partial Fourier series sum
% of a square wave, to illustrate the peaks that occur
% at jump discontinuities when using the Fourier series.
% 
% The function plots a square wave. and asks the user
% for the number of terms to use in the Fourier series
% sum. The partial Fourier series approximation is then
% superimposed upon the square wave.
%
% variable n is the number of terms to use
% in the partial sum.
%
% Raymond Roberts and Graham Roberts
% students in Mechanical Engineering at Curtin University of Technology,
% August 1996.
%-------------------------------------------------------------------------
% create the square wave
%-------------------------------------------------------------------------
% Try with n
% n=2^(k)  for k=4,5,6,'''''''
%-------------------------------------------------------------------------
dt = 0.001;
t = 0:dt:pi;
f = 100 * ones(size(t));
f(1) = 0;
f(length(f)) = 0;

%-------------------------------------------------------------------------
%create the partial Fourier series approximation
%-------------------------------------------------------------------------
s = zeros(size(t));
for i = 1:n
  s = s + 1/(2*i - 1)*sin((2*i - 1) * pi * t / pi);
end
s = 400 / pi * s;

%-------------------------------------------------------------------------
%plot the approximation and the square wave
%-------------------------------------------------------------------------
plot(t, s, '-r', t, f, '--b');

title('Gibbs Phenomenon');
%-------------------------------------------------------------------------
