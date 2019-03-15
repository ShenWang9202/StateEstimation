clc
clear


R23=1.145323502901834e-05;
R34=1.145323502901834e-05;
b = 1.01;
q23 = 0;
q34 = 70;

d3 = 200;
delta_h= 0.3;
delta_h2 = 0.28

%% sufficient scenario

objective = @(x) (R23*x(1)*abs(x(1))^(0.852) + R34*x(2)*abs(x(2))^(0.852) - delta_h)^2;

% initial guess
x0 = [q23;q34];

% variable bounds
lb = [-1000 -1000]%-1000.0 * ones(2);
ub = [1000 1000]%1000.0 * ones(2);

% show initial objective
disp(['Initial Objective: ' num2str(objective(x0))])

% linear constraints
A = [];
b = [];
Aeq = [1 -1];
beq = [d3];

% nonlinear constraints
nonlincon = [];

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


%% over-determinded scenario

objective = @(x) ((R23*x(1)*abs(x(1))^(0.852) - delta_h2)^2 +0.1* (R23*x(1)*abs(x(1))^(0.852) + R34*x(2)*abs(x(2))^(0.852) - delta_h)^2);

% initial guess
x0 = [q23;q34];

% variable bounds
lb = [-1000 -1000]%-1000.0 * ones(2);
ub = [1000 1000]%1000.0 * ones(2);

% show initial objective
disp(['Initial Objective: ' num2str(objective(x0))])

% linear constraints
A = [];
b = [];
Aeq = [1 -1];
beq = [d3];

% nonlinear constraints
nonlincon = [];

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
