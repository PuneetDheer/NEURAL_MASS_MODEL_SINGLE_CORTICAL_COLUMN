%CODED BY : PUNEET DHEER
%DATE : 18-02-2017
%SINGLE CORTICAL COLUMN MODEL
%REFERENCES
%[1]Jansen BH, Zouridakis G, Brandt ME (1993)
%   A neurophysiologically-based mathematical model of flash visual evoked potentials. 
%   Biol Cybern 68: 275-283
%[2]Jansen  BH,  Rit  VG  (1995)  Electroencephalogram  and  visual evoked potential 
%   generation in a mathematical model of coupled cortical columns. Biol Cybern 73: 357-366

function jansen_MAIN
tic
time=1:0.001:10; %in sec


% options = odeset('RelTol',1e-4,'AbsTol',1e-01)
options = odeset('RelTol',1e-01);

[t,y] = ode45(@jansen_F,[time],[0;0;0;0;0;0],options);

% c=length(y);
% MEAN = 120; 
% SIGMA = 200;
% p= MEAN+(randn(c,1)*SIGMA);

EEG = y(:,2)-y(:,3); %PSP MAIN OUTPUT

save('ALL_PSP.mat','y')
save('EEG.mat','EEG')

figure
plot(t,EEG)
axis tight
title('ALPHA WAVE')
xlabel('Time Points (sec)')
ylabel('mV')

figure
plot(t,y)
axis tight



%-----------------DISPLAY----------------------------
figure
for jj=1:6
subplot(6,1,jj)
plot(t,y(:,jj))
axis tight
end
%----------------------------------------------------

toc
end