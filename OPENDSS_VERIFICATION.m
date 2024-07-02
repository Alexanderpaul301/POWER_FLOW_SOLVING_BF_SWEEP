%%Opendss results verification%%
clear all
%MATRIX IMPORT%
run YMATRIX_IMPORT.m;
Y=complexData;

run I_VMATRIX_IMPORT.m; 
V=complexData;

%VOLTAGES IMPORT%
% V=[66.39*1e3*(cos(-0.0001)+1i*sin(-0.0001));66.39*1e3*(cos(-2.0945)+1i*sin(-2.0945));66.39*1e3*(cos(2.0943)+1i*sin(2.0943)); 2.3986*1e3*(cos(-0.5252)+1i*sin(-0.5252));2.3986*1e3*(cos(-2.6196)+1i*sin(-2.6196));2.3986*1e3*(cos(1.5692)+1i*sin(1.5692))];


%%Ybus Method%%
Ic=Y*V;
modIc=abs(Ic);
angIc=rad2deg(angle(Ic));

%%Power Method%%
I=conj([64.8;64.8;64.8;64.7;64.7;64.7].*1e3./V);
modI=abs(I);
angI=rad2deg(angle(I));


%Value of the currents according to opendss
Ibis=[2435.27-1i*9741.08; -9653.66+1i*2761.53;7218.39+1i*6979.54;-0.0301595+1i*0.0635127;0.0700833-1i*0.00563748;-0.0399239-1i*0.0578752]; 
Vbis=inv(Y)*Ibis;