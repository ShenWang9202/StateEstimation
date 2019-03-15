clc
clear
% solve the Water Flow Problem or State estimation problem with sufficient measurment using fmincon.

% fix head of reservoir only,and min((h_tank - h_res- measurement of head different between head of tanks and reservoir)^2), the fmincon CANNOT give us the right solution.
% and if you change the x0, you would find the solution given by fmincon
% changes even if with the help of Global Search.

% solution from epanet
Xsolution=[881.477416992188;875.891296386719;866.959716796875;863.492492675781;865.497741699219;865.733276367188;700;834;976.846008300781;219.214935302734;61.7122116088867;682.631042480469;82.5027313232422;30.7850589752197;-38.2877883911133;651.846008300781;976.846008300781;1];

% resistant of 8 pipes;
Resistance8pipes = [1.62162942170156e-05,0.000412704020811468,0.00167577337533995,5.72661751450917e-05,0.000412704020811468,0.000412704020811468,0.00234608272547592,0.000194857919993929];

% demand of 6 node
demand6node = [0,75,75,100,75,0];

% initial guess
x0 = [0;0;0;0;0;0;700;834;0;258.849878465807;0;302.984031264846;9.25610945494594;221.217689475498;-86.4535282109235;81.7657814025879;705.854189898517;1];

% if we make solution as initial guess, the final solution is not corrent.
%x0 = Xsolution;


%% sufficient scenario
objective = @(x) ((x(8)-x(7)-(x0(8)-x0(7)))^2);

% variable bounds
lb = [];
ub = [];

% show initial objective
disp(['Initial Objective: ' num2str(objective(x0))])

% linear constraints
A = [];
b = [];
% equality constranints
Aeq = [];
Aeq = [
    0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,1,0;
    0,0,0,0,0,0,0,0,1,-1,0,-1,0,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,1,-1,0,-1,0,0,0,0,0;
    0,0,0,0,0,0,0,0,0,0,1,0,0,0,-1,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0;
    0,0,0,0,0,0,0,0,0,0,0,1,0,-1,0,-1,0,0]; % demand ;conservation of mass matrix
Aeq = [Aeq;0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0;]; % fetch reservoir from x
%Aeq = [Aeq;0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0;];% do not fix tank
Aeq = [Aeq;0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1;]; % fetch speed from x
[m,n] =size(Aeq);
% add a column
%Aeq = [Aeq zeros(m,1)]; % make the 19th column;
%Aeq = [Aeq;0 0 0 0 0 0 -1 1 0 0 0 0 0 0 0 0 0 0 1];%epsilon - (x(8)- x(7) ) = x0(8) - x0(7)
%Aeq = [Aeq;0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1];%epsilon - (x(8)- x(7) ) = x0(8) - x0(7)
beq = [];
beq = demand6node';% demand
beq = [beq;x0(7)]; % fix reservoir
%beq = [beq;x0(8)]; % do not fix tank 
beq = [beq;x0(18)];% fix speed
%beq = [beq;x0(8)-x0(7)]; %epsilon - (x(8)- x(7) ) = x0(8) - x0(7)
%beq = [beq;0]; 

% check our constraints using solution first; if linearcheck is not all 0
% it means our constraints is not correct;
linearcheckfirst=Aeq * Xsolution - beq;

% nonlinear constraints
nonlincon = @(x)nlcon8node(Resistance8pipes,x);

% check our constraints using solution first; if ceq is not all 0, 
%it means our constraints is not correct;
[~,ceqcheckfirst]=nlcon8node(Resistance8pipes,Xsolution);

% optimize with fmincon

%x = fmincon(objective,x0,A,b,Aeq,beq,lb,ub,nonlincon);


rng default % For reproducibility
opts = optimoptions(@fmincon,'Algorithm','sqp');
problem = createOptimProblem('fmincon','objective',...
    objective,'x0',x0,'Aineq',A,'bineq',b,'Aeq',Aeq,'beq',beq,'nonlcon',nonlincon);
gs = GlobalSearch;
[x,f] = run(gs,problem)



% show final objective
disp(['Final Objective: ' num2str(objective(x))])

% print solution
disp('Solution')
disp(['x1 = ' num2str(x(1))])
disp(['x2 = ' num2str(x(2))])

% check the constratins again by the solution from fmincon
linearcheck1=Aeq * x- beq;
[c,ceq1]=nlcon8node(Resistance8pipes,x);

