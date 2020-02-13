%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MATLABMAVSim - Simulation parameters
% Description: It contains all the parameters of the simulation.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Prof Dr Davi A. Santos (ITA)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMMUNICATION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% TCP socket with Unity 3D

ip_unity   = '127.0.0.1'; 
port_unity = 55001;
tout_unity = 10;
role_unity = 'client';
byteorder_unity = 'littleEndian';
nele_unity = 10;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLANT PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% MAV %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nr    = 4;
l1    = 0.25;
l2    = 0.25;
kf    = 1.2838e-5;
kt    = 3.0811e-07;
wmax  = 0.9*9620*(2*pi/60); 
km    = 1;
Tm    = 0.01;
m     = 1;
JB    = [0.015,0,0;0,0.015,0;0,0,0.03];
Jr    = 0.0005;
g     = 9.81;

% Disturbance %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

alpha_t = [0.003;0.003;0.003];
alpha_f = [0.02;0.02;0.02];


% Sensors %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sa  = [0.0039 0.0039 0.0039];
sg  = [0.001 0.001 0.001];
sm  = [0.002 0.002 0.002];
sba = [0.0001 0.0001 0.0001]*0;
sbg = [0.0001 0.0001 0.0001];
sbm = [0.0001 0.0001 0.0001];
sr  = [0.01 0.01 0.01];
mg  = [0.5 -0.8 0.002]';
ba0 = [0.02 -0.01 0.05]';
bg0 = [0.02 -0.01 0.05]';
bm0 = [0.001 0.001 0.001]';



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CONTROL SYSTEM PARAMETERS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Joystick %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vxmax = 2.0;       
vymax = 2.0;       
vzmax = 2.0;       
wzmax = 1.0;       


% Position/velocity control law %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

K3     = 0.3*eye(3);        
K4     = 1.0*eye(3);         
Kc     = diag([1.5,1.5,3]);
Fmin   = [-5.66;-5.66;0.98];
Fmax   = [5.66;5.66;19.62];
tau_ref_filter = 1;



% Attitude control law %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

K1   = diag([20 20 5]);      
K2   = diag([10 10 5]);    
Tmin = -[2.21;2.21;0.21];
Tmax =  [2.21;2.21;0.21];


% Control allocation  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

zetamin = 0.25;
zetamax = 4.65;


% Trajectory planning or guidance %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

wl    = [[0 0 2 0]',[5 0 2 0]',[5 5 2 0]',[5 5 0 0]' ];  
Kpr   = diag([0.05 0.05 0]);  
Kpp   = 0;
Kdr   = diag([0.05 0.05 0]);  
Kdp   = 0;
rhor  = 0.5;
rhop  = 5*pi/180;
dtl   = [0 0 0 0];
Ts    = 0.01;
tf    = inf;

% Auto take-off

htakeoff = 1;



% Navigation algorithm %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Rr  = diag([0.01^2,0.01^2,0.01^2]);        
Ra  = diag([0.05^2,0.05^2,0.05^2]);
Rg  = diag([0.001^2,0.001^2,0.001^2]);       
Rm  = diag([0.05^2,0.05^2,0.05^2]);
Qba = diag([0.001^2,0.001^2,0.001^2]);
Qbg = diag([0.000001^2,0.000001^2,0.000001^2]);       
Qbm = diag([0.00005^2,0.00005^2,0.00005^2]);       
P0  = blkdiag(0.0001*eye(3),0.0001*eye(3),0.0001*eye(3),0.01*eye(4),0.0001*eye(3));
x0  = [zeros(1,6) ba0' zeros(1,3) 1 bg0']' + sqrtm(P0)*randn(16,1);
q0  = x0(10:13)/norm(x0(10:13)); x0(10:13) = q0;
tau = 0.1;


x0 = [-0.00474200453136375;0.00340559089522441;-0.00606135915548891;-0.0631804903110595;0.0467605139052012;-0.0518893463786147;0;0;0;0.000215665657103282;-0.000748770998040058;-0.000830264307180187;0.999999351745538;0.0199597004279470;-0.00998300941645958;0.0500399898108888];
P0 = [0.000100000000000000,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;0,0.000100000000000000,0,0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0.000100000000000000,0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0,0,1.11218963620693e-06,-2.15480576697530e-07,1.33790181604220e-09,-4.67157069073927e-10,-6.19424530389513e-08,1.32520391875544e-08,-6.05904127092322e-11;0,0,0,0,0,0,0,0,0,-2.15480576588521e-07,1.32138858621344e-06,-1.32955444638817e-09,1.05623116431640e-09,1.33479432584375e-08,-7.48374065493002e-08,7.04348022586673e-11;0,0,0,0,0,0,0,0,0,1.33790174494013e-09,-1.32955443469627e-09,1.45632085877029e-06,1.18087985643983e-09,-1.55940009237848e-10,6.99442930021848e-11,-8.31702655447309e-08;0,0,0,0,0,0,0,0,0,-4.67157069474037e-10,1.05623116266691e-09,1.18087985606255e-09,7.81268819058471e-08,1.98327165061224e-11,-5.91894146368172e-11,-7.08599263434571e-11;0,0,0,0,0,0,0,0,0,-6.19424530389610e-08,1.33479432638786e-08,-1.55940012789288e-10,1.98327164912398e-11,3.12063637637586e-08,-1.32968853478652e-09,1.92113072024263e-11;0,0,0,0,0,0,0,0,0,1.32520391821150e-08,-7.48374065492821e-08,6.99442935717065e-11,-5.91894146878525e-11,-1.32968853451247e-09,3.24951447986039e-08,-1.75737057985910e-12;0,0,0,0,0,0,0,0,0,-6.05904091718709e-11,7.04348016780740e-11,-8.31702655447313e-08,-7.08599263554159e-11,1.92113070237341e-11,-1.75737055088677e-12,3.33282304415187e-08];

kfcalib = 0;




