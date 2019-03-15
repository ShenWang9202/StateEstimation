clc
clear

b = 1.01;
d3 = 200;
delta_h= 0.3;
delta_h2 = 0.28;
Xsolution=[881.477416992188;875.891296386719;866.959716796875;863.492492675781;865.497741699219;865.733276367188;700;834;976.846008300781;219.214935302734;61.7122116088867;682.631042480469;82.5027313232422;30.7850589752197;-38.2877883911133;651.846008300781;976.846008300781;1];
Resistance8pipes = [1.62162942170156e-05,0.000412704020811468,0.00167577337533995,5.72661751450917e-05,0.000412704020811468,0.000412704020811468,0.00234608272547592,0.000194857919993929];
%Resistance8pipes=10.47/4.727 *Resistance8pipes;

demand6node = [0,75,75,100,75,0];

%% sufficient scenario

%objective = @(x) (R23*x(1)*abs(x(1))^(0.852) + R34*x(2)*abs(x(2))^(0.852) - delta_h)^2;
% x(1:18) is the normal x, and the 19 th is epsilon
objective = @(x) 0;

% initial guess
x0 = [0;0;0;0;0;0;700;834;705.854189898517;258.849878465807;105.573497566017;302.984031264846;9.25610945494594;221.217689475498;-86.4535282109235;81.7657814025879;705.854189898517;1];
x0= [x0;0] % inital for epislon

% variable bounds
lb = [];%[-1000 -1000]%-1000.0 * ones(2);
ub = [];%[1000 1000]%1000.0 * ones(2);

% show initial objective
disp(['Initial Objective: ' num2str(objective(x0))])

% linear constraints
A = [];
b = [];
Aeq = [];
Aeq = [
    0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,1,0;
    0,0,0,0,0,0,0,0,1,-1,0,-1,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,1,-1,0,-1,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,1,0,0,0,-1,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,1,0,-1,0,-1,0,0]; % demand ;conservation of mass matrix
Aeq = [Aeq;0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0;]; % fetch reservoir from x
%Aeq = [Aeq;0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0;];% fetch tank
Aeq = [Aeq;0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;]; % fetch speed from x
[m,n] =size(Aeq);
% add a column
Aeq = [Aeq zeros(m,1)]; % make the 19th column;
Aeq = [Aeq;0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 1];%epsilon - (x(8)- x(7) ) = x0(8) - x0(7)
Aeq = [Aeq;0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];%epsilon - (x(8)- x(7) ) = x0(8) - x0(7)
beq = [];
beq = demand6node';% demand
beq = [beq;x0(7)]; % fix reservoir
%beq = [beq;x0(8)]; % fix tank
beq = [beq;x0(18)];% fix speed
beq = [beq;x0(8)-x0(7)]; %epsilon - (x(8)- x(7) ) = x0(8) - x0(7)
beq = [beq;0]; 
% linearcheck=Aeq * Xsolution - beq;
% [c,ceq]=nlcon8node(Resistance8pipes,Xsolution);
% nonlinear constraints
nonlincon = @(x)nlcon8node(Resistance8pipes,x);

% optimize with fmincon
%[X,FVAL,EXITFLAG,OUTPUT,LAMBDA,GRAD,HESSIAN] 
% = fmincon(FUN,X0,A,B,Aeq,Beq,LB,UB,NONLCON,OPTIONS)
x = fmincon(objective,x0,A,b,Aeq,beq,lb,ub,nonlincon);


% show final objective
disp(['Final Objective: ' num2str(objective(x))])

% print solution
disp('Solution')
disp(['x1 = ' num2str(x(1))])
disp(['x2 = ' num2str(x(2))])

linearcheck=Aeq * [Xsolution;0] - beq;
[c,ceq]=nlcon8node(Resistance8pipes,[Xsolution;0]);

%% over-determinded scenario

%objective = @(x) ((R23*x(1)*abs(x(1))^(0.852) - delta_h2)^2 +0.1* (R23*x(1)*abs(x(1))^(0.852) + R34*x(2)*abs(x(2))^(0.852) - delta_h)^2);

objective = @(x) (zeros(1,18)*x);

% initial guess
x0 = [0;0;0;0;0;0;700;834;705.854189898517;258.849878465807;105.573497566017;302.984031264846;9.25610945494594;221.217689475498;-86.4535282109235;81.7657814025879;705.854189898517;1];

% variable bounds
lb = [];%[-1000 -1000]%-1000.0 * ones(2);
ub = [];%[1000 1000]%1000.0 * ones(2);

% show initial objective
disp(['Initial Objective: ' num2str(objective(x0))])

% nonlinear constraints
nonlincon = nlcon8node(Resistance8pipes,x);

% optimize with fmincon
%[X,FVAL,EXITFLAG,OUTPUT,LAMBDA,GRAD,HESSIAN] 
% = fmincon(FUN,X0,A,B,Aeq,Beq,LB,UB,NONLCON,OPTIONS)
x = fmincon(objective,x0,A,b,Aeq,beq,lb,ub,nonlincon);

% show final objective
disp(['Final Objective: ' num2str(objective(x))])



% print solution
disp('Solution')
disp(['x1 = ' num2str(x(1))])
disp(['x2 = ' num2str(x(2))])
