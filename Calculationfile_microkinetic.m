clear all
clc
tr = [0 7200];
R = 8.314 % gas constant in Pa-m^3/Mol-K
T = 973 % Temperature in Kelvin
%y1=5.636457E-3; %mol P1/RT
%y5=1.252546E-3; %mol P6/RT
Pc1=0.45*101325;
Par=Pc1;
Pc5=0.1*101325;
N=6.023E17;
vi=0.001; %m^3
y1=Pc1*vi/(R*T); %mol P1V0/RT
y5=Pc5*vi/(R*T); %mol P6V0/RT
yar=Par*vi/(R*T); %mol ParV0/RT
y=[y1,0,0,0,y5,0,0,0,0,0,0,0,0,0,0,0];
[T Y] = ode15s(@micro,tr,y)

plot(T,Y(:,1),'-','LineWidth',2)
title('variation of CH4 with time');
xlabel('time(seconds)');
ylabel('number of moles');
