clc
clear all
close all
LD=load('linedata33bus.m'); %linedata
BD=load('busdata33bus.m'); %busdata
  
Sbase=100; %MVA;

Vbase=11; %KV

Zbase=(Vbase^2)/Sbase;

LD(:,4:5)=LD(:,4:5)/Zbase;
BD(:,2:3)=BD(:,2:3)/(1000*Sbase);

N=max(max(LD(:,2:3)));

Sload=complex(BD(:,2),BD(:,3));

V=ones(size(BD,1), 1); %initial voltage values

Z=complex(LD(:,4),LD(:,5));

Iline=zeros(size(LD, 1),1);   

Iter=2000;

%The Algorithm

for i=1:Iter

%Backward Sweep

Iload=conj(Sload./V);

for j=size(LD,1):-1:1 %start from the end of the feeder
c=[];
e=[];
[c e]=find(LD(:,2:3)==LD(j,3));
if size(c, 1)==1;  %if c has only one value that means j is a beginning or ending bus
	Iline(LD(j,1))=Iload(LD(j,3));
else

   Iline(LD(j,1))=Iload(LD(j,3))+sum(Iline(LD(c,1)))-Iline(LD(j,1));

	end
end
 
%Forward Sweep

for j=1:size(LD,1)
	V(LD(j,3))=V(LD(j,2))-Iline(LD(j,1))*Z(j);

end
	end

Voltage=abs(V);

Vangle=angle(V);
