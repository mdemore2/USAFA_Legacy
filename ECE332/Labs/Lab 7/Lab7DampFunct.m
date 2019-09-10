% Damping Function
clear all
close all
clc 

R_sig = 1;
R_L = 186;
R_chosen = 390;

x1 = 1.76;
x2 = .9;
log_dec = log(x1/x2);
delta = log_dec^2;

%Rt = R_chosen + R_par + R_L;
Rt=560;
C = 0.01*(10^(-6));
L = 82*(10^(-3));

dampFact = (Rt/2)*(sqrt(C/L))

zeta = 1/((sqrt(1+(4*(pi^2))/(delta))))

f_0 = 1/(sqrt(L*C)*2*pi)