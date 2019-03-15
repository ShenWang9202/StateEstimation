clc
clear


R23=1.145323502901834e-05;
R34=1.145323502901834e-05;
b = 1.01;
q23 = 0;
q34 = 70;

d3 = 200;
delta_h= 0.3;
delta_h2 = 0.28;
solution = [];
solution = [solution;q23 q34];
C_es = [];
JumpPoints = [];
index = 0;


%% sufficient scenario

for i=1:100
    c_23 = (R23*q23*abs(q23)^(0.852)-q23);
    c_34 = (R34*q34*abs(q34)^(0.852)-q34);
    C_es = [C_es; c_23 c_34;];
    cvx_begin
    variables Q23 Q34 x
    % objective function is the box volume
    minimize(x * x) % suppose delta_h2  is much more accurate.
    subject to
    Q23 + Q34 == delta_h - (c_23+c_34) + x
    %Q23  == delta_h2 - (c_23) + y
    Q23 - Q34 == d3
    cvx_end
    q23 = Q23 ;
    q34 =  Q34 ;
    solution = [solution;q23 q34];
    if(mod(i,4)==0)
        JumpPoints = [JumpPoints;q23 q34];
        index = index + 1;
        tendency = solution(i,:) - solution(i-2,:);
        q23 = solution(i,1) + 100 * tendency(1,1);
        q34 = solution(i,2) + 100 * tendency(1,2);
    end
end

q23 

q34


for i=1:100
    c_23 = (R23*q23*abs(q23)^(0.852)-q23);
    c_34 = (R34*q34*abs(q34)^(0.852)-q34);
    C_es = [C_es; c_23 c_34;];
    cvx_begin
    variables Q23 Q34 x y
    % objective function is the box volume
    minimize(0.1*x * x + y*y) % suppose delta_h2  is much more accurate.
    subject to
    Q23 + Q34 == delta_h - (c_23+c_34) + x
    Q23  == delta_h2 - (c_23) + y
    Q23 - Q34 == d3
    cvx_end
    q23 = Q23 ;
    q34 =  Q34 ;
    solution = [solution;q23 q34];
    if(mod(i,4)==0)
        JumpPoints = [JumpPoints;q23 q34];
        index = index + 1;
        tendency = solution(i,:) - solution(i-2,:);
        q23 = solution(i,1) + 100 * tendency(1,1);
        q34 = solution(i,2) + 100 * tendency(1,2);
    end
end
q23 

q34
