close all; clear all; clc;
opt=sdpsettings('solver','sedumi','verbose',0);

A = [-1 1 0 -0.25 -0.25;
    45 -1 0 -17 -1.5;
    1.3 0 0 0 0.25;
    0 0 0 -20 0;
    0 0 0 0 -20];
mp=0.1;

eps=1*10^-5;

P=sdpvar(5,5);
mat1=[pi*(A*P+(A*P)') log(mp)*(A*P-(A*P)');
     log(mp)*(A*P-(A*P)')' pi*(A*P+(A*P)')];

F=[P>=eps*eye(5)];
F=[F,mat1<=eps*eye(10)];
sol=optimize(F,[],opt);

if sol.problem==0
     disp('The poles will meet the max percent overshoot constraint')
else
     disp('The poles will not meet the max percent overshoot constraint')
end

eig(A)