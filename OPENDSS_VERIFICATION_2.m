%%Opendss results verification%%
clear all
%MATRIX IMPORT%
run YMATRIX_IMPORT.m;
Y=complexData;

run I_VMATRIX_IMPORT.m;
V=complexData;

%VOLTAGES IMPORT%
I=Y*V;


% S=44.7*1e3;
% Vb=11000;
% I=conj(S/Vb);


modI=abs(I);
angI=rad2deg(angle(I)); 