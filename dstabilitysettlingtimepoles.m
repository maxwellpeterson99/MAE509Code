close all; clear all; clc;
opt=sdpsettings('solver','sedumi','verbose',0);

A=[1.0000    1.0000    1.0000         0         0    1.0000;
   -7.1817    1.4443   -8.8613    2.1305   -3.0334   -1.6987;
   -8.7020    2.3045  -12.4458    2.3438   -3.8546   -3.1652;
    8.7020   -1.3045   11.4458   -3.3438    4.8546    4.1652;
   -0.9899   -0.6192   -0.2949    1.0137   -2.1244   -0.2269;
   -9.7121    0.9237  -11.1509    3.3301   -4.7303   -4.9382];
ts=6;
alpha=(4.6/ts);


eps=1*10^-5;

P=sdpvar(6,6);
mat1=A*P+(A*P)'+alpha*P;

F=[P>=eps*eye(6)];
F=[F,mat1<=eps*eye(6)];
sol=optimize(F,[],opt);

if sol.problem==0
     disp('The poles will meet the settling time constraint')
else
     disp('The poles will not meet the settling time constraint')
end