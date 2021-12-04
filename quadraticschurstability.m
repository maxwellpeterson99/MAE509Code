close all; clear all; clc;
opt=sdpsettings('solver','sedumi','verbose',0);

A=[0.8147*10    0.9134*10    0.2785*10;
   0.9058*5    0.6324*20    0.5469*10;
   0.1270*10    0.0975*10    0.9575*15];
Ai = [0.9649    0.9572    0.1419;
     0.1576    0.4854    0.4218;
     0.9706    0.8003    0.9157];
Adel=A+Ai;
 
eps=1*10^-5;
 
P=sdpvar(3,3);
 
mat1=[-P Adel*P;
     P*Adel' -P];
F=[mat1<=eps*eye(6)];
sol=optimize(F,[],opt);

if sol.problem==0
     disp('The Problem is Quadratically Schur Stable')
 else
     disp('The Problem is not Quadratically Schur Stable')
 end