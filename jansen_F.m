%CODED BY : PUNEET DHEER
%DATE : 18-02-2017
%SINGLE CORTICAL COLUMN MODEL
%REFERENCES
%[1]Jansen BH, Zouridakis G, Brandt ME (1993)
%   A neurophysiologically-based mathematical model of flash visual evoked potentials. 
%   Biol Cybern 68: 275-283
%[2]Jansen  BH,  Rit  VG  (1995)  Electroencephalogram  and  visual evoked potential 
%   generation in a mathematical model of coupled cortical columns. Biol Cybern 73: 357-366

function ydot=jansen_F(t,y)
t

a = 100;  %rate constant for postsynaptic population response to excitatory input
b = 50;   %rate constant for postsynaptic population response to inhibitory input
A = 3.25; % max. amplitude of EXCITATORY(EPSP) mV
B = 22;   % max. amplitude of INHIBITORY(IPSP) mV
C = 135;  % (lumped connectivity constant) Average No. of SynapseS
C1 = C;         %pyramidal to excitatory interneurons EIN
C2 = 0.8 * C;   %excitatory interneurons(EIN) to pyramidal
C3 = 0.25 * C;  %pyramidal to inhibitory interneurons (IIN)
C4 = 0.25 * C;  %inhibitory interneurons(IIN) to pyramidal


MEAN = 120;%120;
SIGMA = 200;%200; %SD

p= MEAN+(rand*SIGMA); %uniformly distributed white noise
% p= MEAN+(randn*SIGMA); %Gaussian White Noise

ydot = zeros(6,1);

%Y(1),Y(2),Y(3) are the outputs of the three PSP blocks
%y(1)_psp block-> AVERAGE (EPSP) MEMBRANE POTENTIAL for the EIN and IIN
%y(2)_psp block-> AVERAGE (IPSP) MEMBRANE POTENTIAL for the PYRAMIDAL_NEU_P
%y(3)_psp block-> AVERAGE (EPSP) MEMBRANE POTENTIAL for the PYRAMIDAL_NEU_P
%OUTPUT = y(2)-y(3) SUMMED PSP at PYRAMIDAL_NEU_P (mV)

ydot(1) = y(4); %ydot0
ydot(2) = y(5); %ydot1
ydot(3) = y(6); %ydot2

ydot(4) = A*a*S(y(2)-y(3)) - 2*a*y(4) - a*a*y(1);%ydot3 excitatory synaptic input to the EIN and IIN

ydot(5) = A*a*(p+C2*S(C1*y(1))) - 2*a*y(5) - a*a*y(2); %ydot4 excitatory synaptic input to the pyramidal population,

ydot(6) = B*b*(C4*S(C3*y(1))) - 2*b*y(6) - b*b*y(3); %ydot5 inhibitory synaptic input to the pyramidal population,

end

% Sigmoid function
function r = S(v)
%r = 2*e / (1.0 + exp(r * (V - v)));
%e=2.5,max firing rate of neural population
%r=0.56, steepness of sigmoid transformation
%V=6, PSP mV

r = 5.0 / (1.0 + exp(0.56 * (6.0 - v)));


end


%for wendling model (for seizure activity)
%p varies between 30 and 150 pulse per second
%then, mean=90 and std=30 gaussian white noise

