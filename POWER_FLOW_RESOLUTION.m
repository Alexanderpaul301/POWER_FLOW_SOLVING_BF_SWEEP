clear all
%% _*Definition of the context*_
% In this part we will define the number of sources and loads we have in order 
% to properly use the Y matrix

reduced=1;          % 0 if Y is not reduced, 1 if it is.
nsrc=3; 
nld=3;
nrst=6;            % Depends if we use the reduced matrix or not (8 if we keep the neutral from the others)
%% 
% 
%% _*Y Matrix import*_

run YMATRIX_IMPORT.m;


Y=complexData;
Yinv=inv(Y);
%% 
% 
%% 
%% 
%% 
%% _*Itteration 0 : Initial Loads currents and source voltages*_
% For the following part of the code loads will be in the following order: A,B,C
% Calculation of the apparent powers

VL=[0.4*sqrt(3)*1000;0.4*sqrt(3)*1000;0.4*sqrt(3)*1000];
pfL=[0.95;0.95;0.95];
PL=[30000;20000;25000];
QL=PL.*sin(acos(pfL))./pfL;
SL=PL+1i*QL;

% Calculation of the initial currents

IL=conj(SL)./conj(VL); 
%% 
% We now have the initial values of our loads thanks to the nominal power of 
% the loads. We can now build the IR matrix in which we initialize currents wich 
% are not from the load to 0.

IR=zeros(nrst,1);
IR=[IR;IL];
IS=zeros(nsrc,1);
I=[IS;IR]
%% 
% 
% 
% 
% Calculation of the initials voltages for the sources phases
% In order to do that we will first start by by describing partitions in order 
% to work with simpler notations, We will name IS and VS respectively the currents 
% and the voltages associated with the circuit source.
% 
% We will name IR and VR respectively the currents and the voltages associated 
% with the rest of the circuit.
% 
% The Y matrix will now have the following look: Y=[YSS,YSR;
% 
% YRS,YRR];
% 
% We have the following : 
% 
% IS=YSS*VS+YSR*VR;   and IR=YRS*VS+YRR*VR; by combining those equations we 
% find that : 
% 
% IS=(YSS-YSR*inv(YRR)*YRS)*VS + YSR*inv(YRR)*IR
% 
% IR=YRS*VS+YRR*VR
% 1) We first start by defining the submatrices.

YSS=Y(1:nsrc,1:nsrc);
YSR=Y(1:nsrc,nsrc+1:end); 
YRS=Y(nsrc+1:end,1:nsrc);
YRR=Y(nsrc+1:end,nsrc+1:end);
% 2) We can now calculate the values of VS the sources voltages
% We start by calculating the value of the source voltages called VS and then 
% we can calculate the value of the currents in the source:

VR=Yinv*I;
% VS=polar_to_rect([11000;11000;11000],[0;-2*pi/3;2*pi/3]);
VS=[11000*cos(0)+1i*11000*sin(0);11000*cos(-2*pi/3)+1i*11000*sin(-2*pi/3);11000*cos(2*pi/3)+1i*11000*sin(2*pi/3)];
IS=(YSS-YSR*inv(YRR)*YRS)*VS+YSR*inv(YRR)*IR;
%% 
%% 
%% 
%% 
%% _*Itterations : Itterating the process until it converges*_
% Now that the system has been initiated, we can now itterate the process until 
% we converge.

eps=0.5;  % Criteria of convergence
%% 
% We can now itterate the process: 

t=1;
while(t>eps)
%% 
% For the _*source voltages*_ we only keep the magnitude of the voltage because 
% the source display a 3 phased balanced system and so we impose the voltages 
% phases to be 0°, -120° and 120°.

    V=Yinv*I;
    magnitude=abs(V(1:3,1));
    anglV=[0;-2*pi/3;2*pi/3];
    V(1:3,1)=polar_to_rect(magnitude,anglV);
%% 
% 
% 
% 
% 
% _*Now we update the value of our currents:*_
% 
% 

    In=Y*V;
%% 
% For the _*loads currents*_ we only keep the angle from the new itteration 
% and replace the magnitude that has already been correctly calculated in the 
% first itteration.

    angl=angle(In(nsrc+nrst+1:end,1));
    In(nsrc+nrst+1:end,1)=polar_to_rect(IL,angl);
%% 
% We now check the loop condition and update the value of the currents.

    t=abs(In-I);  % Here we create the variable that tells us if we need to continue to itterate or not.
    I=In;         % We update the value of the current
end
disp('Getting out of the loop');
%% 
% 
% 
% 
%% _*Display of the final values*_
% We can now check that the values we calculated are directly corresponding 
% with the values calculated in OpenDSS, in order to do that we need to check 
% the I and V matrix that synthetize all the values of the currents and tensions 
% in our circuit.

%Affichage des courants
display(abs(I));


display(rad2deg(angle(I))); 










%Affichage des tensions
display(abs(V));



display(rad2deg(angle(V)));
%% 
%