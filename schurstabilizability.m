close all; clear all; clc;
opt=sdpsettings('solver','sedumi','verbose',0);

%system matrices
A = [0  0   1  0
     0  0   0  1
    -0.5  0  -2.5  1
     0 -0.5   1 -2];

 B = [0 0
     0 0
     1 0
     0 1];
 
 eps=1*10^-5;
 
 %method 1
 P1=sdpvar(4,4);
 W=sdpvar(2,4);
 
 mat1=[-P1 A*P1+B*W;
        (A*P1+B*W)' -P1];
    
 F1=[mat1 <=eps*eye(8)];
 sol1=optimize(F1,[],opt);
 
 if sol1.problem==0
     disp('The Problem is Schur Stabilizable')
 else
     disp('The Problem is not Schur Stabilizable')
 end
 
 %method 2
 P2=sdpvar(4,4);
 gamma=sdpvar(1);
 
 mat2=[-P2 P2*A';
     A*P2 -P2-gamma*B*B'];
 
 F2=[gamma <=1];
 F2=[F2, mat2<=eps*eye(8)];
 sol2=optimize(F2,[],opt);
 
  if sol2.problem==0
     disp('The Problem is Schur Stabilizable')
 else
     disp('The Problem is not Schur Stabilizable')
 end