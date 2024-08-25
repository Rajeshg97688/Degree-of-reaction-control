clear all
clc

N = 6.023E17; %conversion from molecules in 1 cm^3 to 1 m^3
kf=[1.1*10^-8 2.2*10^9 1.5*10^11 N*2.2*10^-21 N*3.2*10^-22 N*10^-23 N*9.4*10^-27 N*2.3*10^-23 N*3.1*10^-21 N*6.9*10^-13 N*9.9*10^-24 9.5*10^9 8.7*10^10 6.8*10^3 8.4*10^5 7.1*10^3 5*10^9 5.8*10^8 4.4*10^-1 1.4*10^8 2.4*10^1 4.7*10^6 N*1.9*10^-10 N*2.8*10^-10];

kb=[N*4.1*10^-10 N*1.5*10^-9  N*4.4*10^-9 N*1.9*10^-10 4.1*10^9 N*1.9*10^-12 N*6.6*10^-11 3.9*10^2 4.7*10^4 N*5.7*10^-15 N*3.8*10^-19 N*3.3*10^-9 N*7.3*10^-9 N*3*10^-9  N*2.3*10^-10 N*1.4*10^-9 N*1.5*10^-9 N*3.1*10^-9 N*3.7*10^-12 N*5.1*10^-10 N*5*10^-10 N*3.9*10^-11 1.8*10^-10 2.7*10^-4];% Define other rate constants similarly for other reactions (k2f, k2b, ..., k24b)

% Initial conditions
Pc1 = 0.45*101325;   % Initial pressure of CH4 in Pa
Par = 0.45*101325;    % Initial pressure of Ar in Pa
Pc5 = 0.1*101325;     % Initial pressure of Na in Pa
P = 1*101325;    % Total pressure in Pa
V = 0.001;          % Volume of the reactor in m^3

% Calculate the concentrations of species in the reactor
y1 = Pc1 * V / P;    % Number of moles of CH4
yar = Par * V / P;      % Number of moles of Ar
y5 = Pc5 * V / P;      % Number of moles of Na

% Calculate DRC values for each reaction step
X = zeros(24, 1); % Initialize DRC values for 24 reactions

% Calculate DRC for each reaction step
for i = 1:24
    
    % Calculate DRC for the current step
    X(i) = (kf(i) * y1) / (kf(i) * y1 + kb(i) * y5);
end
% Perform sensitivity analysis based on degree of rate control
%Find indices where DRC values are greater than or equal to 0.5
rel_DRC = find(X > 0.98);

% Display the indices
disp('Indices of DRC values greater than or equal to 0.98:');
disp(rel_DRC);
%Define the DRC values obtained from the previous calculation
DRC_values = [X(1), X(2),X(3),X(4),X(5),X(6),X(7),X(8),X(9),X(10),X(11),X(12),X(13),X(14),X(15),X(16),X(17),X(18),X(19),X(20),X(21),X(22),X(23),X(24)]; 

% Define reaction labels for the x-axis
reaction_No = {'R1', 'R2','R3','R4','R5','R6','R7','R8','R9','R10','R11','R12','R13','R14','R15','R16','R17','R18','R19','R20','R21','R22','R23','R24'}; 

% Plotting the bar graph
figure;
bar(1:24, X, 'b');
xlim([0, 25]); 
ylim([0, 1.1]);  
xticks(1:24);
xticklabels(reaction_No);

xlabel('Reaction No');
ylabel('DRC Value');
title('DRC Values for every Reaction Step');
grid on;