%%Opendss results verification%%

%MATRIX IMPORT%
run YMATRIX_IMPORT.m;
Y=complexData;

%VOLTAGES IMPORT%
V=[polar_to_rect(6.3504*1e3,0);polar_to_rect(6.3504*1e3,-2*pi/3);polar_to_rect(6.3504*1e3,2*pi/3)];

S=64.7*1e3;
I=conj(S./V);


Ic=Y*V;
modI=abs(I); modIc=abs(Ic);
angI=rad2deg(angle(I)); angIc=rad2deg(angle(Ic)); 